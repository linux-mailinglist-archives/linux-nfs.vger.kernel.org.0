Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A3A787B78
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Aug 2023 00:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbjHXW1F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 18:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239936AbjHXW0x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 18:26:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA0C1BEB
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 15:26:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJESHs018536;
        Thu, 24 Aug 2023 22:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Sia9zNv6kgDoKrRa+jTjr1K8cXW/MUyUyAnFVJXROd4=;
 b=V5G5215NIFgPK7wfBVuwBZwJb7bNqbhBsjNeuM00M0+YisREIdmVQiJ6amMA0cT1jcpN
 Ec164hcR/aCcubx2vLDDliyy2KiD7rcpXoMY+EmosNSdSLVuA01TQ2kZn0K+PkIu2pqH
 dpamWkxcohJW5nPt8AYDZOeV1a9QsZuR4qb5lJgIdUMIIJr9o6Ihpca9wpiiu8LWnW6r
 hq5TDCM+X8S4FoI2VYtIxw40KhBhvRZ/L9ArccoN3r8ZuCmLfYb+xHS1nP3CGSJR1Ady
 JQiOdQWipAmOvDxoxgGrw9zUuxv0Bk2ECVTW52p9uKjuQttCUdraXJqxC0/7wQmKXU3+ /Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20cn7bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 22:26:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37OMA1dE036065;
        Thu, 24 Aug 2023 22:26:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yq2k0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 22:26:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7HczlAmi2e6KeBP/gdWFg2JkYl2XktYlFok0fV/3jY6+Vkv/vBfIBJIqOWOZsMy5W51Kumxd8h5Ne4LZ7DAfMSOu9hyqL6XmlpCs25fbmhz+hvu1fb/nQrE4HbAWUQtj8Rg4yrZfrq2Br0G+dbyjXzc0UrmcyHC34UyO0RcgR7Qt93fQsnFFVuvbEVndgnR/JhanrEv2UEbGBgajVfQnG5MO2xNf+MVWssK1t+LgR7PxF33fQieajfmULSgI8afNkS5uFOvFE0rhMNSPX7ED2o8RT3Q8ewnEqns4ALUjF1huEycxt0TB1jQQRmvth2QO8utp/C+FzDOSeM5ddd8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sia9zNv6kgDoKrRa+jTjr1K8cXW/MUyUyAnFVJXROd4=;
 b=F7Qmvefy3YRWDT5BTS6r1bgBjS5SIDiwKwHqocOn6gJctTOOfPsj3+cwH8a8BSXNnYMhd4oEAbeTlix7akhqLv1xRxjA9bn1o751mdq4TzdTsnET3r7xAIpxeGy3eHaWiQdIETSIz+jwIymRpevt68wqG3PhszYbcf0hetwxlqXsoZ48sB/QfeUxSstSCaDlCJe7K/xxKg0lDDb41ymzBKKMTwDnq9q8qtDyPMk3J6/qQiR4M6czmKLYs7jEuuxTgULqVNCaBz+nbzblM/vN2mRD8ne8OF/4xXPiB8bhGVU6WHM7dVFUFNXzfag2E6ienVqVn+l/k0n6v6HNWeA6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sia9zNv6kgDoKrRa+jTjr1K8cXW/MUyUyAnFVJXROd4=;
 b=KSGJZpIcgEikCiYlRECMBrdlyOY4g45BbX34HI3RRwJRgTVbEbrF9vZRUIGoECH4PwLMszZ320p4TWzpycQzhNJC51M49XhiSnm4BrSRG7gjvy501ZlwEyvkmltMHlgK7Ucy22V0mCPq4+vK9nE3XjggFPQbz2NO44QLyxBwSag=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by SA2PR10MB4697.namprd10.prod.outlook.com (2603:10b6:806:112::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 22:26:43 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2%4]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 22:26:43 +0000
Message-ID: <6a9e0757-b901-c694-1720-632f1a0339e0@oracle.com>
Date:   Thu, 24 Aug 2023 15:26:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/1] nfs42: client needs to update file mode after
 ALLOCATE op
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <1692892434-4887-1-git-send-email-dai.ngo@oracle.com>
 <c02190c39f123a16aeae70fd65a68fba4aa70b6f.camel@hammerspace.com>
 <067a68e1-cd7a-55c5-619b-d64266b5ada9@oracle.com>
 <af94f54e27b14e3129691d78ae1f439b33fb7733.camel@hammerspace.com>
 <24ae5b14-0fe3-15e8-37e8-e8aed0cdefa9@oracle.com>
 <5b0bc635-40bb-2c3e-28dd-b9a71814a7bb@oracle.com>
 <737abceb902411f583f731108fbc7eb235120eaf.camel@hammerspace.com>
 <F88C0F0D-62EB-45A2-8C70-477CD13D6EBF@oracle.com>
In-Reply-To: <F88C0F0D-62EB-45A2-8C70-477CD13D6EBF@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::24) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4270:EE_|SA2PR10MB4697:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a0aa37-6a91-40d3-0a7f-08dba4f131d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B17a+lpVLLP/JEU2znEIw1d+0tvXgsZMXdUz3145NO10VWIRAirVNx8JbcfaDO4Wctg/7kEBo2sGt/BYlnQz4I9J38zu7HnGiKi6psgZ+9xoQlovmfO345g3BWD9m5/b6eV8BlD512jsHuYO0mcrRfuWgDRilnWH2kJ+OpHKasLTwOwwMk2uhdDZyBAB5tDIqcbxvQx+aeykNZtreJ74quOZ/L3Y/CbjhaDc4RQibO9UlMA/mF65KIZHezoMkk12/+84exBNkZ3PpumVY/sT3y7caE1cCWCFe19ZhV7Iu+LMkZbO4uPFtvkIyugQalBq5meuePypq2/CxUm9rkgBZCpIPQ3OV9CeSPSI/2I9YI3dySX/g7ieTIUQm1ElOLHjIQYRQTCB9ChsUuy3AcOPEzS/qPLNtDTpsZWgAISTwgKmmdwwBBlGHDKOFaq7qbpPKYrJhkwjgVwFUwbmMb5T8pwfr6Jzz8njTShlB+aIr/zdkYpUA3zJcvq6/dQgcNWbBKkto06nTpENU7kyMONR8zzCAMuxNlxmNFLoY9BGxbTN/BBUtYh24KR+sXqXWa6StmoatRsOip+gg2hEp5124MNtAUddZwsNCMkUXDjcOqslAabUidOtn99pqMiaxlQv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(2616005)(5660300002)(4326008)(8676002)(8936002)(36756003)(15650500001)(83380400001)(26005)(6666004)(38100700002)(66556008)(66946007)(66476007)(54906003)(6916009)(316002)(478600001)(31686004)(53546011)(41300700001)(6512007)(9686003)(6506007)(2906002)(86362001)(6486002)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmNhRzBvT2VUbDkxYUJIWmRIZEVCVE5TWGk1V1ptVVcyeWswTWZsNDJaRmIz?=
 =?utf-8?B?cmNnaVhkWUwwYnVvdlRGK2s1cGdYc3dvUSsvUDFhRi9oUC9oR1dDRldsWWdz?=
 =?utf-8?B?RlVVc0Yzb1NRQU1OaWRGSDVZaDV3ZFNQN2trbHlpZ0U5cUZ1d3oxaDFqeVpK?=
 =?utf-8?B?amdCek9aZ1h5cWpuTHBsdjhSMEtaVEFLMWkyd0NFeHo4U2xqKy9kaXNhZlRT?=
 =?utf-8?B?T0VRQ2M4dW5PdDYzdkt1azJDS2ZVemZEZ08vOWVleXVyeWpYUWRrRU51Uy9W?=
 =?utf-8?B?akl3UVpHTnhZMXY0MXoxRU1VR2dHUzFPU2FUSHJ5Z1lwSTRXTTJYNjFuNXdE?=
 =?utf-8?B?dVZzZkRqUU9udDJuQ3lSY1ZQUkJBdEk0V0hqREZtd3NUWDBHZVFYcENRbkpS?=
 =?utf-8?B?RmtaN2JZVWRwSXdRSG1EQk10UlRQd2pXSUhxNEtrcWk3RUUvNUVObmdZV3Zw?=
 =?utf-8?B?aEh5ZjBSVmtXM3IrUVBIdjFLQzJtS2tyaTdKRzNmZmY3cWNsL040ZGdkNkxp?=
 =?utf-8?B?a2o5YW1UazlzZVJjb1Nja05obnR1ZWZzZXhYWUN2NGdmWUxzQlQ1QTRJc3Ra?=
 =?utf-8?B?Q0JXMDh0NHNtVFBlQ091NERKRFYzY3ZIaTIwRHE0ZFhtM0M1bFgrLy9wcXhk?=
 =?utf-8?B?NVFEY2lwRys5RjVzMnhVdis0eC9LWTUrc3JlVmEwVzl6TU1kZlJqc3Z1eHhT?=
 =?utf-8?B?c0JVOTNsSGdlanhTK0FNbThIbllDdUJtbWprQWROYjFJMWc3VFpwbkFaOWVq?=
 =?utf-8?B?elFIOVo5a3Fwcmd4ZjVVZTVySkRpekowd3R0T3hYTGFjNGNQMTYyL0wxTTZL?=
 =?utf-8?B?dE5rRWNadzd1TEFzRTdWM2xrQ0duZTZ5K1RIb0tSVU1sWTZQVTZHSmxHZnV3?=
 =?utf-8?B?Zks2N040c1RFKzFpZHM0S0RYaEVrNXdJWEZTOUZmb0sxaWNzd2FYN3JBRHpB?=
 =?utf-8?B?dTdkSGl4c0pLV2N5ZXhvR3V4SFhJQllwZWNIKzVmSGtDbEZweTNPVERmdnc0?=
 =?utf-8?B?cWo5dVFIZk14UCtlc0UrOWRlb3hWVWlMWGl5SXB1SFpKekhnUGljZWM5VnJR?=
 =?utf-8?B?SzZKazl6MytpS1I1NWNtb3B6RHZRV2gyWEFrbjFUVXJrRTB2SVA1b3BLYW9B?=
 =?utf-8?B?YmVFazZpbFBBK3pJNHNJcmcweFBjcnpZTDhjUEE2MjQxK2dUeUhjWDJlSG92?=
 =?utf-8?B?M2JmV2J2Vy84aG5USFV0NjQyM0hrV0FrZG9BS3YyamQwR3p2L1dHYVdBMXh0?=
 =?utf-8?B?Z0xQeFk5MDFnc1poMStNTmk1NGRUQk40OHNuRmFEbzM5L05Ja3gwbHo1SDM0?=
 =?utf-8?B?YWxjOU5sSTNDUjRUTmJqV1dVdEdoaGNSbjA2NVM1bVNVa3U0N1IwbXBuenJP?=
 =?utf-8?B?ZkpmbGRZc0xPSWE1d0duNVZZYWhzR1JmNGo4UDJLZllrREN4WEJZUVdIWGh2?=
 =?utf-8?B?Rmd0UU1GSVZEbTQyZEVmNzNUTFNZakI1amIydnBZUGF4RlhRRTg2cjk0R2c1?=
 =?utf-8?B?R001dVgzaVVNdXdRa2ZOQkNteFB6Tkt5QUw5cTJjSklTZ0FIVGFhN1VXRDIx?=
 =?utf-8?B?MGVBcndXOXJaZnVpVlZ3NlVEMHdLZlYreEJmVHZPdkVSVDZseGVDU3dobVhG?=
 =?utf-8?B?TDZyYnV1cWJjZytxbG9uTmVTckZZWlJWcGc4WTRIUG9ZdHd1RzMzOElyR1gx?=
 =?utf-8?B?eDdrOHJBWWpsWEdsVnhZL1BRaC9MdmdLT1l3Tm1OdGd6UmorR2R3Y1NHM0ds?=
 =?utf-8?B?WTc4TlZTeDFnay9hcmFGcEd5b2lnNFRqcklHODJOM2ZYS2lQN1JKTzVyNWdF?=
 =?utf-8?B?ang1cWNWUVMwSzZJaVN5M3cvSkE0MmNhVlU0djlZM3NzRWRUaDJMSFZMLzY0?=
 =?utf-8?B?bkFZTkFCRnFPeThuV2h1VWJ4TWIxQXg3d1hxRmdDMkhJUXdxN1dHdytwd1d2?=
 =?utf-8?B?TDNjZXpqb1hyYjlEQklaZ2haVUZxSlExMXUzRGNuYzRua1VXajA2bUpWdTZx?=
 =?utf-8?B?NzdRUXk5KzVLR1BDV1Y5c0wrNlE2UjZ6dXpSa0RtcUgySkxjUVQ3dzV1K3BY?=
 =?utf-8?B?TU9KcEJDcVJFOGNCTlUvUW5NdWZJajI2M21qWUh4SlBhd2hjaGlNcFdmb2N2?=
 =?utf-8?Q?ji1URViA/7fpcXCym0C8rnc+T?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WNzWVbttVdf7FCyI88oyBlESjmwoExcWqsqXkXPk9Zb72GCvco0tpEgSae4UW3pZ5kvaCGebHw9KhiYrIBCMsci5820PmfZowdPlhvVwOINkuvZUBEpdLaWguessGdre9HgWgwE6qPXXcPzgCQ4oj3lZgGYiavMR19/Tp9xcHTdf6iYQhf63CnRX72cHgYSH2fKpJpf3EyWSGKN/7FVQRX/uCbAefKVVZkGbPoD0M0rR/oz7Kvdw9CaWcS66dI6Oqc5aK/l5ZFcBCNnJciDSt9ZZK3CXwy5iegM+fKDzSUPQTxcFklQOYnjOMpmpRC163NoCAiMuBZ67Ma0jaBVDhw6GsR5R9OBl8vAp609FcqHMeDpIXtykHXhT0loSgCH5iMnPahMR6cSIMLLkdXj7LNANf1HLtz6Q1BI69iV1fBEuutBib3ow/jZXNvfEzEUDWKVR6Q/8eg3F1Zm41xxOkDsUnt7yY1LDooQdCtBd5F478dvsJs4WHqXCyzdG6TgX016opV1RD3JTmtHY+jOkdWjxuFJjpGCOeVcbX1nmptsoxvudH5KAoI1o/nCt2UyzsDfZncga7vxg1o3T2S6k5SeqsRuXTbuD1KcZRVaV64JDzFPystY4xL3OWf+uow26d2PU1l9DlcBrfkQkcys9jfUtDwkOnv/kAGw33S7OBq2UN/xOojDmxUfLz/jtt4MnAVCtJM3pNBsyFO6vVlvMG6s+fmnVCVNcIpyRHe2Ut9ENUvIQOXi1VkFMSvrqIr5xoAp9w2H/LSPeoO5kc5uCXpL1PZi+L5CDkJXSaancHtXTDB56B/ssWiShM1CG7gXJBPPygjbawUoWxdbdNlwuyw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a0aa37-6a91-40d3-0a7f-08dba4f131d5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 22:26:43.4741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7Rnd922kRlQ54z2yM/+mRu2R03dGQLDeekDo9rLMCYPUum6agxAIFp9ErYO6l8VdBbcBwr9e6xaEs0YBtdYFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_18,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240195
X-Proofpoint-ORIG-GUID: Of174wTUN7TlBkCE16AgTlj-fhLv1tDN
X-Proofpoint-GUID: Of174wTUN7TlBkCE16AgTlj-fhLv1tDN
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/24/23 1:05 PM, Dai Ngo wrote:
>
>> On Aug 24, 2023, at 12:01 PM, Trond Myklebust <trondmy@hammerspace.com> wrote:
>>
>> ﻿On Thu, 2023-08-24 at 11:42 -0700, dai.ngo@oracle.com wrote:
>>>> On 8/24/23 9:38 AM, dai.ngo@oracle.com wrote:
>>>>
>>>> On 8/24/23 9:34 AM, Trond Myklebust wrote:
>>>>> On Thu, 2023-08-24 at 09:12 -0700, dai.ngo@oracle.com wrote:
>>>>>> On 8/24/23 9:01 AM, Trond Myklebust wrote:
>>>>>>> On Thu, 2023-08-24 at 08:53 -0700, Dai Ngo wrote:
>>>>>>>> The Linux NFS server strips the SUID and SGID from the file
>>>>>>>> mode
>>>>>>>> on ALLOCATE op. The GETATTR op in the ALLOCATE compound
>>>>>>>> needs to
>>>>>>>> request the file mode from the server to update its file
>>>>>>>> mode in
>>>>>>>> case the SUID/SGUI bit were stripped.
>>>>>>>>
>>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>>> ---
>>>>>>>>     fs/nfs/nfs42proc.c | 2 +-
>>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
>>>>>>>> index 63802d195556..d3d050171822 100644
>>>>>>>> --- a/fs/nfs/nfs42proc.c
>>>>>>>> +++ b/fs/nfs/nfs42proc.c
>>>>>>>> @@ -70,7 +70,7 @@ static int _nfs42_proc_fallocate(struct
>>>>>>>> rpc_message
>>>>>>>> *msg, struct file *filep,
>>>>>>>>            }
>>>>>>>>               nfs4_bitmask_set(bitmask, server-
>>>>>>>>> cache_consistency_bitmask,
>>>>>>>> inode,
>>>>>>>> -                        NFS_INO_INVALID_BLOCKS);
>>>>>>>> +                       NFS_INO_INVALID_BLOCKS |
>>>>>>>> NFS_INO_INVALID_MODE);
>>>>>>>>               res.falloc_fattr = nfs_alloc_fattr();
>>>>>>>>            if (!res.falloc_fattr)
>>>>>>> Actually... Wait... Why isn't the existing code sufficient?
>>>>>>>
>>>>>>>            status = nfs4_call_sync(server->client, server,
>>>>>>> msg,
>>>>>>>                                    &args.seq_args,
>>>>>>> &res.seq_res, 0);
>>>>>>>            if (status == 0) {
>>>>>>>                    if (nfs_should_remove_suid(inode)) {
>>>>>>>                            spin_lock(&inode->i_lock);
>>>>>>>                            nfs_set_cache_invalid(inode,
>>>>>>> NFS_INO_INVALID_MODE);
>>>>>>> spin_unlock(&inode->i_lock);
>>>>>>>                    }
>>>>>>>                    status =
>>>>>>> nfs_post_op_update_inode_force_wcc(inode,
>>>>>>> res.falloc_fattr);
>>>>>>>            }
>>>>>>>
>>>>>>> We explicitly check for SUID bits, and invalidate the mode if
>>>>>>> they
>>>>>>> are
>>>>>>> set.
>>>>>> nfs_set_cache_invalid checks for delegation and clears the
>>>>>> NFS_INO_INVALID_MODE.
>>>>>>
>>>>> Oh. That just means we need to add NFS_INO_REVAL_FORCED, so let's
>>>>> rather do that.
>>>> ok, I'll create a new patch and test it.
>>> This is the new patch:
>>>
>>> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
>>> index 63802d195556..ea1991e393e2 100644
>>> --- a/fs/nfs/nfs42proc.c
>>> +++ b/fs/nfs/nfs42proc.c
>>> @@ -81,7 +81,7 @@ static int _nfs42_proc_fallocate(struct rpc_message
>>> *msg, struct file *filep,
>>>          if (status == 0) {
>>>                  if (nfs_should_remove_suid(inode)) {
>>>                          spin_lock(&inode->i_lock);
>>> -                       nfs_set_cache_invalid(inode,
>>> NFS_INO_INVALID_MODE);
>>> +                       nfs_set_cache_invalid(inode,
>>> NFS_INO_REVAL_FORCED);
>> No. The above needs to add NFS_INO_REVAL_FORCED.
>>
>> IOW:
>>     nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE | NFS_INO_REVAL_FORCED);
> Ok, I’ll try again.

I tried again with this patch:

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 63802d195556..5c6f15961a9b 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -80,8 +80,10 @@ static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
                                 &args.seq_args, &res.seq_res, 0);
         if (status == 0) {
                 if (nfs_should_remove_suid(inode)) {
+                       printk("%s: FORCE nfs_set_cache_invalid with NFS_INO_REVAL_FORCE\n", __func__);  <<== for testing
                         spin_lock(&inode->i_lock);
-                       nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
+                       nfs_set_cache_invalid(inode,
+                               NFS_INO_REVAL_FORCED | NFS_INO_INVALID_MODE);
                         spin_unlock(&inode->i_lock);
                 }
                 status = nfs_post_op_update_inode_force_wcc(inode,
[dngo@nfsdev linux]$

and the xfstest's generic/683 still fail as with previous patch:

[root@nfsvmd08 xfstests-dev]# diff -u /root/xfstests-dev/tests/generic/683.out /root/xfstests-dev/results//generic/683.out.bad
--- /root/xfstests-dev/tests/generic/683.out	2023-08-17 23:59:09.621604998 -0600
+++ /root/xfstests-dev/results//generic/683.out.bad	2023-08-24 15:47:40.684240872 -0600
@@ -1,19 +1,19 @@
  QA output created by 683
  Test 1 - qa_user, non-exec file falloc
  6666 -rwSrwSrw- TEST_DIR/683/a
-666 -rw-rw-rw- TEST_DIR/683/a
+6666 -rwSrwSrw- TEST_DIR/683/a
  
  Test 2 - qa_user, group-exec file falloc
  6676 -rwSrwsrw- TEST_DIR/683/a
-676 -rw-rwxrw- TEST_DIR/683/a
+6676 -rwSrwsrw- TEST_DIR/683/a
  
  Test 3 - qa_user, user-exec file falloc
  6766 -rwsrwSrw- TEST_DIR/683/a
-766 -rwxrw-rw- TEST_DIR/683/a
+6766 -rwsrwSrw- TEST_DIR/683/a
  
  Test 4 - qa_user, all-exec file falloc
  6777 -rwsrwsrwx TEST_DIR/683/a
-777 -rwxrwxrwx TEST_DIR/683/a
+6777 -rwsrwsrwx TEST_DIR/683/a
  
  Test 5 - root, non-exec file falloc
  6666 -rwSrwSrw- TEST_DIR/683/a
@@ -33,9 +33,9 @@
  
  Test 9 - qa_user, group-exec file falloc, only sgid
  2676 -rw-rwsrw- TEST_DIR/683/a
-676 -rw-rwxrw- TEST_DIR/683/a
+2676 -rw-rwsrw- TEST_DIR/683/a
  
  Test 10 - qa_user, all-exec file falloc, only sgid
  2777 -rwxrwsrwx TEST_DIR/683/a
-777 -rwxrwxrwx TEST_DIR/683/a
+2777 -rwxrwsrwx TEST_DIR/683/a
  
[root@nfsvmd08 xfstests-dev]#

I don't think adding NFS_INO_REVAL_FORCED will fix the problem
because nfs_post_op_update_inode_force_wcc(inode, res.falloc_fattr)
will only update the file attributes with the attributes returned
from the GETATTR in the ALLOCATE compound which currently does not
ask for the file's mode attribute.

-Dai

>
> Thanks,
> -Dai
>>>                          spin_unlock(&inode->i_lock);
>>>                  }
>>>                  status = nfs_post_op_update_inode_force_wcc(inode,
>> -- 
>> Trond Myklebust
>> Linux NFS client maintainer, Hammerspace
>> trond.myklebust@hammerspace.com
>>
>>
