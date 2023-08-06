Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A289771612
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Aug 2023 18:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjHFQ2j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Aug 2023 12:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFQ2i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Aug 2023 12:28:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290D9115
        for <linux-nfs@vger.kernel.org>; Sun,  6 Aug 2023 09:28:34 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 376CGvPL029461;
        Sun, 6 Aug 2023 16:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=CJgSS3Tyc7Zt683kh6XEP5rWpW/4GXdYgCkvGTU6Yhk=;
 b=g9xXnYXJq/ENFPh1NLKPLxLyP0DPrMEUlheK5L60ZS37mIxN/nYBnWnxYe0XUsJPJXao
 tWnIkvvdIlX6a0pT8j9C1ZoaQucxbrJEMeZGmSKD2yapCoI3cTe3RVIBJwWBK/5isM5p
 O3v86WOXzjzfyEQiCMcxuz7T0WYNBIKTuT3oj+BREDV8P4t2WPncFSPbwmSIfb1xTSaS
 vvnDKsb6vkTN6Dh0/7boKo08DUbSgMaEf6ci+1Q5kQxrxY7TzfL/MJbenURsJ7H7n5ew
 jurFxwg/DU48lzjPj7wj1TeyPqC1MHuavAzjF/iIPcuC/scVJcrgSyKOHhE1IvzEKN+a bw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9eyu9a0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Aug 2023 16:28:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 376G25eA021515;
        Sun, 6 Aug 2023 16:28:29 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cva00sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Aug 2023 16:28:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwVh1jla9i7JE/YUn5V5n7uHhJtrxag9myph6gaa+wvS/Ymj4ZEPHLjh4dC7Mo4IFNloKWxDz0tiUoyC7aO5i0wDsG/uPnJQE5qwhgYW0OUnDyw+C9dw3gDzVzvGfjgBoLELXDWmsXCD+2mC4Jocj2GjZh/h5sk7hxs2gyHEldppVq//R1yrIzY3sxQJu18leo0gfSW2RewdjXFVvQgzhpo7H7yMJuGm2iWtHNqf/uAd8QaJcG8KO3wddWTRBJB0qf7JgKmNe4kQLX1bzHaxjwFmGyoPYs1FhBWdFLl4ChN6nFzG9b7KmGD5nyO5Li8UMfFy9IyRwuRS65RAZ9x1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJgSS3Tyc7Zt683kh6XEP5rWpW/4GXdYgCkvGTU6Yhk=;
 b=Q8pg63neU1P4peZsBe7wUk9kfoVmHyGTwOZBX8HwnyZYF4HRoz9uv1VM6Eoaq0b259eqDIQtw91a4pQEUqj1SjSpMVf1osMmK2BTd5/j1hQhfOjauH2MgLK0VGNU9Tr69dWB8crB7h9Xrlr+qmvxjVZV3yqntAw3ETWg154BoIEUUDUPDhlnYclZC2dqmWFLvrZ0Zz47Tx1VBR1IH5rmMcku1DXv2+0o3T4uG+gEFBybLUgcV7qYSHDG5j+pJsPwK41vtl5pzzDemaPrdR2XxDnAWt/wMV4Ybt5+ZDxjdjA8Kz1871/Gk80Yy8xg6DnKiHrewU0SrJVoEYDAzO7xFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJgSS3Tyc7Zt683kh6XEP5rWpW/4GXdYgCkvGTU6Yhk=;
 b=TzF30dFhi4jhTNX8FwN7/Y5r6yCaGIN36XEIKC36pyFfRZyLNxuThvVlkT8uVvaOXTd03rmUr9qd3ffcRBvDjBoE4n053gCYC/aAVnsZx8swM9YkoZwG/78RiidVUtMTNbW+PGW18Pz1+dDngCmYaQ/kvgpNS3YSf3tpI0Ek7Os=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB6349.namprd10.prod.outlook.com (2603:10b6:a03:477::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Sun, 6 Aug
 2023 16:28:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.026; Sun, 6 Aug 2023
 16:28:26 +0000
Date:   Sun, 6 Aug 2023 12:28:17 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Rick Macklem <rick.macklem@gmail.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Noveck <davenoveck@gmail.com>
Subject: Re: RFC: new attributes
Message-ID: <ZM/KIQY8WOXSvSX6@tissot.1015granger.net>
References: <CAM5tNy4d02dOyWsVk7Y-nFEyGjE=eo4nJgrap3M5DebDJz9ehw@mail.gmail.com>
 <42DE2EB5-E2E5-45D6-B0B9-8C63FD6DC67D@oracle.com>
 <CAM5tNy7UL_mG20uHEgBjgK2B4d2JiT8Z6QknO1-6ByQ8GpOGNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM5tNy7UL_mG20uHEgBjgK2B4d2JiT8Z6QknO1-6ByQ8GpOGNg@mail.gmail.com>
X-ClientProxiedBy: CH0PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:610:b3::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 2131e471-0887-4ae0-5074-08db969a291c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gyh50+kEeJpdXIIwlhLbbFjlH+yOyfCQPH4FVNhShVY7u1NVMTAqx2ZHxE9i7wY4MjCznA0bTPuRcGw/akPZEDKwO9Mvk2HNXivuR4OHy1MD2pXX3kDld2feQd0MzLgjKIRrvCSwv4Pdhtm+SB7TPaEsmcjE15fsIGWddF2sAQm4av8PlQWVSqa1ciLL0T7PpTisEkkkvdxI7hUCxA962RRgsHqKQIqtmVjT/XinR3F6pd/VyToA65+izvFiaDWQ/S3OvsRatClseeJb3/VjV4ChQrii0DwSfDB3uj63GZy4tgLu5uMhK/utRyBCbRSPe0PXzDyGUTAa64MF9eGH4wbzlzhd4t7ht/XqRZndzBOVt442gpWZo2wGATddn/B8uwVclgGzZMkLL+gx7VDZIuHNkUFq7oMfd1kGYgB4CgAlIkyAeDUX+xuT9HU+gOv77630H/fpjyd7L4kEdBksyT1f/AbHzNDYF7779cp2WQPLW+esOgWblpJUPFUYUd5SUNGrbpg6fYssOJ18+b5BE2VNIz7CuETCHJPyDJ9TmeEVnA+Fl3pUhSQfeyGPl4Rt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(396003)(346002)(376002)(1800799003)(186006)(451199021)(83380400001)(54906003)(2906002)(6916009)(4326008)(5660300002)(8936002)(316002)(44832011)(8676002)(38100700002)(66946007)(66556008)(66476007)(86362001)(6512007)(478600001)(9686003)(6666004)(6486002)(41300700001)(6506007)(26005)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0czWjBwWVp1R3Y2UERzVUNqSXBSdFVSUXVCeThBU3pzWDVsdkF6d1ZkeHdl?=
 =?utf-8?B?TmNsU2U2ZlltY0kxLzJSR3dOQkJlZ25QSXA5bHN5V0ZtOVlqZW1FVzFlSnZ3?=
 =?utf-8?B?bXl0NzcvdEFmdVg3bzFlMmxRK3dFbk1wYWgyMStXdTk5YUROZ0xRUnIxVUor?=
 =?utf-8?B?L0hkSzhnSUE5UVk3VnBlS3NCQ0VObmJIdHh5SkZFVStmSllzQkR3cEtsQ1or?=
 =?utf-8?B?TTVPZVdBWW1SV3RsclFWRHdrWE5uemtadXZraUhtaGI5KzRNSXo0d21KR0RC?=
 =?utf-8?B?UUFwYVJ6S1VRRkRqN0VCdHU3VVNaVjFnZ3hGR3NIcHBOZUFyU2RybElRbk9x?=
 =?utf-8?B?dVBvYlJPTWpMdG1uaDRRUk9oTGFtZENSWnQ3ZjZnNTlaazVxY3B6OFBJZGRJ?=
 =?utf-8?B?TXR2eGJHVE9aN1ZhelRNUDdsMWp6QzRmRmVwMTROdE0wWkZwZ3JjQ1p6SDBL?=
 =?utf-8?B?MmRIb1prNUpRY0xidjd5N0NzQTlwVnUxQzU3RjdPcDQ0b2RkTXlsV2ttV0cw?=
 =?utf-8?B?bEF6dTZxYmk1UHl4VGlHU094Y1NRTDBQQTJqdjloeGFIN1lMYkszaUdkVjBx?=
 =?utf-8?B?cE5vYk12c2ZjcGFMdms3RjJVT2FEVk8yWXZKRzZKM1RYbkwvZGJQaHlsc1hP?=
 =?utf-8?B?UHJabG00cmJEMzJEd2VLa05wL2U5Q040eWovcUZxN0hmTXhEUFlHc0xSSm5J?=
 =?utf-8?B?MDFCSWhHRE9SV1U4Snc5Y3FzSCsxcjcyNE5aMGdkVCtJRko3VkxaemtVYmVM?=
 =?utf-8?B?V0NVVGpmNWt2bmgvK2U2NTJIamdvaXlIallXZ3Z4T0ErRy92THRWQXdhNkR2?=
 =?utf-8?B?c3dzTmROZDdsa2ZuZFd1ZkFHcE1jTG1mMTZ3ZThaaEdNeVRQZmV2WGpHWUdh?=
 =?utf-8?B?TEJEMGdxTWU4aVlEWklFeGg2bk1pSkZ6cFB2WEZmSk9lcWpYMG45Ymo5MTJI?=
 =?utf-8?B?eG9UeDdFVWxua291cERwaXVwYlZRemd3b0VjckJsalVueUlHSXZROEV6TTcw?=
 =?utf-8?B?WlU1RWpQb1JqaExWVmk5cUpZV3NEaXpvcUtaVllwRXdlSlA4VDNFNkZaSjhF?=
 =?utf-8?B?MllkTE9OWlowL3h2Ykx1U3diK1J6VWVranI3UVNrWUVoWHVjS2phOU5WMG90?=
 =?utf-8?B?UDJYd1FYaGtRNGNvVnFjdXRLZS9XQXlJWU5NdW81V2J5Y3krTzlaUjRucnU4?=
 =?utf-8?B?RGxIUTlUTllsYjlMcEZKemxhSXFPQVRNb1BpVTJ6S0hJYjNocFZDTktmQit5?=
 =?utf-8?B?eWhlUnRJYVErRVFUWlh1MHlPeVBiS3d4UVdQWVQ1bCtHeVNtVzJiaVZqazk1?=
 =?utf-8?B?cGw3ck1kZnZTV2JkRGJwRkNwMUdRNTNXdFZyeFJ3QS8yUTZ1VXNzRElnZHcr?=
 =?utf-8?B?MytqNk10ei9PbVVJWUd0VFpnaS9kU3ZYK2F3amwxS0M3ejBoU05wMlprdmFR?=
 =?utf-8?B?ZXF5V0Eyamx6ZWVpR3hwL2VoZVRGbWt1c2U3bGQ3SUd2V1FzLzhKejdxRUl6?=
 =?utf-8?B?OTFFd2lTOVl1S211Q2VDY0owRUdOUG5yKzRPMStzT1lwOTIxR25haXA0Mnpx?=
 =?utf-8?B?TmtOQzl6d1FFYzRWRzZ2NjNwQVVldk9zREpBWCs4ekdPMVNZMWRnZDZwdmY4?=
 =?utf-8?B?ejN3Wkovcy90MEpwbTVRREhHMU84OUZIV1BxbU1qQkM4WlBUV3B5d01hcHlD?=
 =?utf-8?B?T0VUMlhqaW1KdkVrbk85NlRLM2JLUk05ZXUxeW1EbEdQUUw1ci9nK3VIMXha?=
 =?utf-8?B?c3lkUnFWeHlYc04wdWw1M01BcmZ3cmlyM3JHZEdJaHRPcXU5OWsyMXc3TkJK?=
 =?utf-8?B?SGZlcTNFSGxiWWFPYU1qQ0RrR0hhZFhpczZ5bkxFZlNrWlFsK0lIQXUrQmp1?=
 =?utf-8?B?SjQ1U2ExcjR0RUdLRDU2ZFMxOE5iM3R6TlIyWHhKVFBvVWZqeVVZR0dBOFh1?=
 =?utf-8?B?MmhuNDE4Zkp3cHpYQkIraEdUOTJJL1MrdGExN3lldFJXQ0JObUJMZEZSYVgz?=
 =?utf-8?B?bmRpZmdaYUpoNmtiNHBMZkRzdFUvb1A5aW8xdTJ4azRHVzdlWDJlazVrQU5m?=
 =?utf-8?B?RU5hMmNET282ZXAwK1VGamEvZzlKZHkvRXV1WFRwZG5PdTVGOWx1V3BIZ3Az?=
 =?utf-8?B?MGxzNktYRElKa1UzR3VoMDRNa2twc2FQYVFCZzZvdWVna1E2cy9iUHN6c1pE?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: twWxRKhlEQmRkOeBTGxkcV7YJN8jTrtkER5UlBdFe33ds8ptoEfSBeABxRoDBAwbe4Urlgwt1/9EQPEs+MFoEuosrC0I7WOpjuIqFfabqOhFGk2FQY8YJBHkkRMfbi2MiXXMdgVnJ0DqaOx7U8+mXTR9BDTM9+DREHxr+GOf9eZy50Rgzqina/n0QD36ol0PhXk5egjU2SHOImoL+7Bvq34JnAu/AQnPBbjFM7MA8qVt9K0gVMVu6MhgSO04IuBLIl2s/sgOd31TAKQoo58XKFcLXYS2iAK17FVwPyUFWED2tX4li1ljwT60bQFIwDq7QyFhMDpblgXG7RCuOhcs0ULWiM9U0eB4P+Q3w7xKLMcOU+hSo4G6lnwA08yoePuAnQc0meGGBkiliQKAdcKOjcgNLiqkR3DttowHF1v1D6dS56uBr6BUstRWcsyr0rUy9FRrtp3G3GoRPoYLmVseTU2jrV0f23m5a15c5H7gdDyD+22G/WPpmZGEhRG0zbYOvXwBGgYcBOyWuF6vQrPp5gsYYw3MTO553CDi3fcExEeRaYhBOtcKWarQIdUcdwzdfj/ITQgmlxe75EN0mxoJWrBlEv3tWO9AWagtLstbw1jUzaTyHG32sXFyU8FgortIXLzTtnNudZ3N/acMjc9K/vg1Hkm1swibLs3YUUSea9obBzcKDOZHLSWDuVTh2uyYUKTeUAhZ0FHXdW3xDqjci2lsjpQNBFlMSvmVrGA/hPwNANIC3LVhWhr5y7u8plsQ3YWg2H72fFi4C7vcC3a3LGbB1b97P3EL/lpk85gWE8g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2131e471-0887-4ae0-5074-08db969a291c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2023 16:28:26.3437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCAji7uL/oJMTIavU8R749w4wYsYlyaTcglx9xvXfNs/JRiORk8OGyTH9L7FD30nyfjivJTeKzArukf8ekFFWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6349
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-06_13,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308060157
X-Proofpoint-GUID: iACoredTA08gKFn-jHNx0YWTh8VH7dtZ
X-Proofpoint-ORIG-GUID: iACoredTA08gKFn-jHNx0YWTh8VH7dtZ
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Aug 05, 2023 at 03:05:59PM -0700, Rick Macklem wrote:
> On Sat, Aug 5, 2023 at 7:51 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >
> > Hi Rick -
> >
> > > On Aug 4, 2023, at 6:18 PM, Rick Macklem <rick.macklem@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > I wrote an IETF draft proposing a few new attributes for NFSv4.2.
> > > Since there did not seem to be interest in them, I just
> > > let the draft expire.  However, David Noveck pinged
> > > me w.r.t. it, so I thought I'd ask here about it.
> > >
> > > All the attributes are meant to be "read only, per server file system":
> > > supported_ops - A bitmap of the operations supported.
> > >     The motivation was that NFS4ERR_NOTSUPP is supposed to
> > >      be "per server", although the rumour was that the Linux knfsd
> > >      uses it "per server file system".
> >
> > Before crafting new protocol, we should have a look at server
> > implementation behavior to see if it can be improved in this
> > area.
> >
> > Is Linux the only problematic implementation? Send email,
> > bug reports, or patches... we'll consider them.
> >
> This was discussed on the IETF working group mailing list some years
> ago.  I was asking if NFS4ERR_NOTSUPP could be used "per server
> file system" or "per server". Tom Haynes said his intent was "per server",
> but that was not clear in the RFC.  The only place in any RFC where it
> seemed to indicate "per server" was the definition for NFS4ERR_NOTSUPP
> as follows:
> 15.1.1.5.  NFS4ERR_NOTSUPP (Error Code 10004)
> 
>    Operation not supported, either because the operation is an OPTIONAL
>    one and is not supported by this server or because the operation MUST
>    NOT be implemented in the current minor version.
> 
> Bruce Fields noted that he thought the Linux knfsd was doing NFS4ERR_NOTSUPP
> w.r.t. optional 4.2 operations on a "per file system basis" and there was some
> mumbling to the effect that it should be applicable "per server file system".
> 
> In FreeBSD, certain 4.2 operations (such as Allocate) can only be done
> on certain file systems.
> Without a way to indicate to a client that this operation is supported on
> file system X but not file system Y, the server is forced to not support the
> operation. (It is currently controlled by a tunable that a sysadmin could
> set incorrectly and result in NFS4ERR_NOTSUPP for some of the file
> systems. As such, you could say that the FreeBSD server can do this.)
> 
> I do not have a Linux server with various types of file systems to confirm
> if what Bruce Fields thought was the case is actually the case.

I wondered if the subtle difference between "per-server" and "per-
server filesystem" would have implications for extensibility (RFC
8178) but I don't see anything specific there. It distinguishes
between

  NFS4ERR_ILLEGAL - operation is not valid for this minor version

and

  NFS4ERR_NOTSUPP - operation is valid for this minor version but is
  not supported by this implementation

Because the specs are not clear about this, a client could remember
the support status of an operation and not use that operation at all
when a server shares a mix of filesystems that support a feature and
filesystems that do not.

But it looks like we have a de facto deviation from what was intended
but not written in the protocol specs -- NFS4ERR_NOTSUPP is used by
some implementations on a per-filesystem basis (not that I've actually
audited the Linux server implementation yet).

I would find documenting this de facto interpretation more palatable
than adding a new bitmask attribute.


> > > dir_cookie_rising - Only useful for directory delegations, which no
> > >      one seems to be implementing.
> >
> > We've been talking privately and informally about implementing
> > directory delegation in the Linux NFS server, so this one
> > could be interesting. But there aren't enough details here to
> > know whether this new attribute would be useful to us.
> >
> I wrote a bunch of code implementing directory delegations on FreeBSD,
> but never completed the work to the point of testing.
> I found that, for FreeBSD, it was infeasible to implement the client side
> for server file systems where the directory offset cookie was not monotonically
> increasing. (Basically maintaining ordering of "directory chunks" because too
> difficult with being able to do so based on directory offset cookie ordering.)
> 
> So, my implementation, if even completed, would only work for the case of
> monotonically increasing directory offset cookies and detecting that that is
> not the case "on the fly" would have been messy.

I'm still not clear on what "monotonically increasing directory
offsets" means.

I'm familiar with only a couple of Linux filesystems, and they seem
to use distinct offset values that increase monotonically as new
entries are created in the directory. The offset values do not
confer any particular information about entry locality.


> > > seek_granularity - The smallest size of unallocated region reported
> > >      be the Seek operation.  FreeBSD has a pathconf(2) variable called
> > >      _PC_MIN_HOLE_SIZE that an application can use to decide if
> > >      lseek(SEEK_DATA/SEEK_HOLE) is useful.

I checked. On Linux, fpathconf(3) does not list a MIN_HOLE_SIZE
variable, fwiw.


> > I'm not aware of a scenario where the Linux server would provide
> > a value not equal to 1, so it would be easy for us to implement.
> A value of 1 is of limited use. If an application is going to use the
> information (btw, I think this pathconf name was in Solaris?), the
> size (such as 32K or 128K) can be more useful.
> --> No point in doing Seek if the data is not sufficiently sparse.

To provide an implementation there just needs to be a clear use case
for it and a clear explanation for the semantics of that value
provided by an open specification.


> > What would clients do with this information, aside from filling
> > in a pathconf field? Might this value be of benefit for READ_PLUS?
> As proposed, it does not give indications of "sparseness" for individual
> files. It would, however, indicate if READ_PLUS can be useful.
> --> If the server returns 0, there is no point in performing READ_PLUS.
> (This was not explicitly stated in the draft, but should be.)

That's where I'm thinking the benefit might be for clients that
implement READ_PLUS but do not care about MIN_HOLE_SIZE.


> > > max_xattr_len - Allows the client to avoid attempting to Setxattr an
> > >     attribute that is larger than the server file system supports.
> >
> > Can you elaborate on the problem you are trying to solve? Why
> > isn't the current situation adequate?
> For FreeBSD, an application can attempt to set a very large extended
> attribute (I've actually done a 1Gbyte one on ZFS during testing).
> As such, for NFSv4.2 it can attempt one up to the maximum allowable
> size for a compound (a little over 1Mbyte).
> 
> Without this attribute, most servers will fail with NFS4ERR_XATTR2BIG,
> resulting in a fair amount of "on the wire" traffic for some application
> that insists on doing large ones a lot.
> 
> This attribute would allow the client to avoid putting Setxattr operations
> with too large an attribute "on the wire", but it is a minor optimization.

The Linux server restricts the maximum size of RPC messages during
CREATE_SESSION, so it wouldn't be possible to write more than about
a megabyte at maximum to an xattr residing on Linux. But I believe
many of our local filesystem implementations do not support xattrs
much larger than 64KB. This limit very likely varies depending on
the filesystem.

IMO large xattrs were not in the minds of the authors of RFC 8276.
If applications want to store large amounts of data in secondary
byte streams, they should use named attributes instead, since a
named attribute I believe is written with WRITE, which enables
extending the attribute size after it's been created.

I remember also there was a question of write atomicity when we
discussed this before. Atomicity and large writes generally do not
mix for the most common Linux filesystem implementations.
