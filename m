Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4286E550E
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Apr 2023 01:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjDQXOe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Apr 2023 19:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjDQXOZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Apr 2023 19:14:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E9C49ED
        for <linux-nfs@vger.kernel.org>; Mon, 17 Apr 2023 16:14:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HLTb6g004074;
        Mon, 17 Apr 2023 23:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=C+IoF2/M7MFtf10p0b2ZjrqF7z93dCM1lVtyFj9knw8=;
 b=4KYbIdEqeYtb8FqKZvtuN6zglE62/Tvfp5kJCgxlpKo3se8ESCyKAhxndSAqO2YkZMWu
 Fbo03E3UUduwcD8EIwBo1HNf0pzwUCYC/u7dKhkbMpDWpKIfjhAlFmPkZvbhpx4Brxv3
 WbuTHPZVqwSyRt+Xkv9G5Bq6V+qMdjpdheYX3c0Ts46mF2GP4euOuEnZ4/SdRQsyphtN
 7nIrSslTvfmx2SleHeIDTui7rMmvxK4ZmCQvUq0NYYw3K0EyRXaYqYSOl1YowQ64vFQV
 6P2ep+3SFSogQhAPBe9VSGT/fe3aQGLU1o8zkyk+u7upUrxCXssnE5ROB49NKbwXUjK4 nA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyktamahh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Apr 2023 23:14:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33HLPavw017566;
        Mon, 17 Apr 2023 23:14:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcb1new-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Apr 2023 23:14:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8Qy4CidLID8QvSqyuhLV8mOUIPs+qnRMQgZuPIHZuBTv9IIcVmLJDjj3eBKOQu0gdqEp5QGzcf2U1JsSzxMoPS0EcPgoLDK0cXonRXbeg07LeTW0Q0YBmYBegy0vYGmsYJFOL/VFe2tk6xtQDoXw7IMid+dK14TmQ4J1Ewb22fdJhu/pycj/cj1vI3lrkIdpkS9E+ceDjRIpI82mYJZjNBNsV9rM4stuSRPIUSVv0YXYiZplZl+MBg6M6cZoPU/jw3IhYkOo1PAyEzV0VL+Ul1k6kV6OFs6B2dAggZILHLZMc4DmkfUdkOVMAWZK2LL1SL+zFfmAhj7s29HjaAaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+IoF2/M7MFtf10p0b2ZjrqF7z93dCM1lVtyFj9knw8=;
 b=O45seij207gSaKWSI3N910QJGn5Y3wwR+emBzg/Vdnuwo3UnL+uyHvijJ6w2KhRh+p3r7UKzgdll2zLCqhLSX6B92IxCxpe+TDMVp7a1Wa7WpZweC4xAwt+wZdXLlRfOHeFm7Egx8oIt6DVZpodKED6RRjiigb6NwoQwm4TUZp+TQcAlQDQGbXq1kNX8uROazaYqr354oqOqC33LYlN1C6kZL31/GGRusE2S4pHrskkyWMP9WmK2bu/OvP6IfDR5PgjJ6iw1KctNWugC83kMVxOmkB/8dxIjN4rUUrPMmeSyjtBjh0lWvlKcfYFTXVE3h+qwyOkFLPayq7GQFSme8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+IoF2/M7MFtf10p0b2ZjrqF7z93dCM1lVtyFj9knw8=;
 b=ipNltDiatpAQE11LmcpLEuXNJWHzN5wxZ8svKdcukhOeTUvXbR82oPxpItN3eDxUt/5han41M3AlaPpKWbDrU4q3xsrqsU3UlrZjYuoVB9V9HxgeLA+ecQRO7ccRjyc4W23dLYuQANvvrRHvizfU34GNznb7oS1+iC/fJSZ5uHs=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DS0PR10MB6030.namprd10.prod.outlook.com (2603:10b6:8:ce::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.45; Mon, 17 Apr 2023 23:14:14 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%6]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 23:14:14 +0000
Message-ID: <00fe5d5a-43b8-0f0e-2afe-ae68367f822d@oracle.com>
Date:   Mon, 17 Apr 2023 16:14:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
Content-Language: en-US
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
References: <1680924600-11171-1-git-send-email-dai.ngo@oracle.com>
 <ed95d6e3da7b2a27a27837f19ca39980037eb28d.camel@hammerspace.com>
 <C7FE1DB9-576A-4463-81BF-E7B1EC266E4F@oracle.com>
 <8723e01c577e257c399e8d3b6e20bca6320964c3.camel@hammerspace.com>
 <19bf7b21-fc68-5281-e587-b7d290899456@oracle.com>
 <d0a5cf8b8c8dbdbf83658b9456afb798af5d7941.camel@hammerspace.com>
From:   dai.ngo@oracle.com
In-Reply-To: <d0a5cf8b8c8dbdbf83658b9456afb798af5d7941.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0062.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::13) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|DS0PR10MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: 28fad7c5-a271-4100-22f5-08db3f9975eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vQTYBfXmf1tGlK6xogMt1g+NUf+UtAXMB0kKLd46ibvwJdWfrmInytgcZB3RIdGbwdbEJAHvD1wKZbn9mMw7ggv5rvJ8st5OYVNJLvmbRN+Cs3DcbauLuNIruo716KQ6O4bgOz+PZ+FEmYuFg+PAvEhp/rSBAzmpg1MY9eyKbHuWTgeGVM+6bf4VEDohREhfjWcWLQHWxqG2V1neSPtQTU4UyKSmKk4ieZkxR080976kBTRU16CTi1jlWetdBBO+S62IZdiKJ1uuOX94ieSJnnaKV6i8dZBB5iUVtLH5IDOIZtleDvBsFwcYqBdATXx4zJIH3STyvXfTgLQLSLoIE7Qr6Z1sSGYOol32cWkxvOgSMk/dkw5M1WskhCtVDlxVuim1e8M0pGbxLK3ckNsXDCcgOHTVwpZljv7KkRKWvlD6VaWONNKjb5tfmidVRw4HKIf8JW4WAD/IupLeH65RrSkzcKSR/4s+K5Q4QU7mmt9Tvpsbj73zk5YYOSrCrjqRFpsGZaYd9RHt7Hd2n8L6IEEZ5qk3vkxjqcjsSfJZp9YCYzSrg3WnbQpcXMm8HtkNebyS3zQJmT4//bCFeN4DvDosG9qfkcOMymUEWkXxjXXqBHDC6WNa1/RLCIgzoSG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199021)(5660300002)(2616005)(9686003)(83380400001)(31696002)(186003)(86362001)(26005)(6512007)(53546011)(6506007)(38100700002)(8936002)(8676002)(110136005)(54906003)(478600001)(6486002)(6666004)(41300700001)(316002)(36756003)(4326008)(66556008)(66476007)(66946007)(31686004)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2ZVYkwyR3Uvajk2QVBraFJSSHFwNFZLV2pONS9NQ2tLbEhJNzdYUVozang0?=
 =?utf-8?B?UElYZGpMZTZoNCswTDhkK1ZDN1ZUV09ZQ3pkNWY5R2FkL1l5S0tHMThZK3dT?=
 =?utf-8?B?ZjR2YkJWaDRvb0FGNmZ2V24vekdudXZTTUlUNStPMjhHdEZKUnBZK0ZXOFBt?=
 =?utf-8?B?bVgxb1gzZVNDclI3cTk0aVduNlJyU1dTTXY5R2pNYTlCMytka05BcUtUdDgy?=
 =?utf-8?B?Ny8zUGZiaWdUbWhsbDhvUmJaU0RxUTBWbGk5S0lTOUh4WjNkQU5pbndTSy9E?=
 =?utf-8?B?V1NaRWIxVE9YU2JoamttM3oxSmEwR1ZyVC80b01vQ09pZVNJdnpkZzNjM1FH?=
 =?utf-8?B?bDhZa2JNRDhwVUdkZjNRUWZRQ0VwRU41bzZkNi9Ta1ZTdUtkQTNmeDhXRTlD?=
 =?utf-8?B?WG1ZN2o2VTlEYnlvQTNhaEJLY3htWmRhRGpQWUNLSmxxYVE2Q2prWjlWYVl6?=
 =?utf-8?B?aEI3RjV0b21LaFJzd3Q5bnZDVHRpUEhSWEtDNjJOUGZlL1lNWFVsTDg4Wk9Y?=
 =?utf-8?B?VU1TNUwrcm1GOFV5OGxSVzRDdmRIZ3AzQXJyaEhXdXR0Y2ZLazBQR25DTFIr?=
 =?utf-8?B?S2l3V2tvR1cyV1RsMERXL1RSY1ZpaVVDQVk0WUFNTW5zMjZLNXAxMDVvNzhU?=
 =?utf-8?B?NVZYVWlqYkVsTWNIdTN3eFl5Nmp2M3BvdWM2bnJzRDRQSEZ1bTl2ZmFzMjdL?=
 =?utf-8?B?MEdCQjFudldrUEhpb0xyWXdRVVJnZHpUS2lvTXZzdlJUU2lhTTdtV21Sbmht?=
 =?utf-8?B?TDk3WWFpWEk1WWlnbGV1c3dQM3Z3TEFmNnZ0YUNuQ0cxbzVTb2pyeFZwUjNp?=
 =?utf-8?B?Q1BuZTNKbUhiOHlYL3d1YzFUV0d5UE5kL2VGWng2TE51bDQxUy8vby9aV3E3?=
 =?utf-8?B?UWNhdEJtaUxrMUNwWklCZHhSa3RhenJGSUFzY3R4d28zV0Q4Z2JJWSs2UmFY?=
 =?utf-8?B?UVkwMitNa2JjQzF3dHNsbE5jL3ViSURZZVhLNElHbmFXTS9YRW1kY3VQN2da?=
 =?utf-8?B?dHlHUHBtNXd4ZklVdUtQYlVyQThWbG9kaFFseG1VWENyNkhsdnhhMUNLODRB?=
 =?utf-8?B?ZDZVUHBQNTg0UVJOQ094WUNKTk11VllJUHhsNzJ4Rm05a2lGR2dhQ2EvVUd3?=
 =?utf-8?B?aHNFOXI0RlFQM0hrRlErcXV5eWdxa2xsRm94M1NpZnpabERsdktLc0xkWU9I?=
 =?utf-8?B?b0tKS01kTkRaRlZSeEpMMjBsdU1DU0NaaVdtWk1IZkVBR0p0T2s3enRHMjdu?=
 =?utf-8?B?d2JjdUk0bVkzV2ZrZ3BFb1JiMlRDTDVZK0hXSTh3MXVLQ3RDdWRLM1VwSkNO?=
 =?utf-8?B?Y2t3Y0JHdVVLZ0VQcjJGeHdlbERoMERQQm1kdDNIMVdCOGp1dFB1VzRXM0Nh?=
 =?utf-8?B?bWl2S2Myc2h1WUxNK1FyR2N3VVRrUk1wUnJLenJNVkRRN3pCbmk4NXZMSW1N?=
 =?utf-8?B?RGFJTjJ5aTcyUlJ4U05zN2w0aGZPMlRkc1JZQnZ5MDhyVE5FbG52S0dENkti?=
 =?utf-8?B?SGNGVCtTUGswcys3MDlaczNOS2hkTnNnRi9SaG56NThSNzIzOVNFSmFQZWNj?=
 =?utf-8?B?SUJRZklZcmw4WnE5YlhxSlhxbDQ2OG5pS2FPT2l2VFlYSVlmMzIyZytxWG9D?=
 =?utf-8?B?WkU4RDk3MXljc0ZQSzhUNVlXNWRwSGVZUWRZUk1lK3lzb3JwN2txMUNnVDJE?=
 =?utf-8?B?YUNVTThYbU5WMCszNS9jS1BLUU1sQ2M3TkJQb3hZY05aamludkN3R2ZjVUxo?=
 =?utf-8?B?eDNxTkhINVJXd3NqMHR2STE5c25VTTRMVDRoSXRhRzdvWUY5RjlMa1dLcHh5?=
 =?utf-8?B?cWQ3ZGU4MmlDbGJYYXZENytnTERsZ3V2RVI0OE5PZzdEbTlWeGM4SUwzL09L?=
 =?utf-8?B?L1dlMXJiRzVZanNwZDNlZFZYZDJHRDR3OFRMNkYvcTh6eUY3MmVUSTFTTmpU?=
 =?utf-8?B?OGFxU0RuOXpFNUZad0poa1U2OE0vd25qQlQ2WEZDZXlicUUyWWZKb29HelBI?=
 =?utf-8?B?aHdOQklpby9adDJYalQrNXZtSUlFdSt4STVjT0tiNEpYQ1BZa1RHdWJyOENv?=
 =?utf-8?B?T3ZEZ2V2dENNOG5PTzlMSkZmeVNnWGkwYjFaNTZtTWNvY3lGb0ZCYkZYbHB4?=
 =?utf-8?Q?MIpDgwqHVtintabvZq3KDUQLL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 92akx+gjoCPOL/6pNovyXKMLwK3bBDs9boSn/EFZJvKoFRFahu9WkJSAd6tAjW9lsi0iSEnX/CPG0QxQJNnqn7JLSHFskYc2a4+3DvN+0XeHAEAizFcpPfRyeLsrll7WfM6HT+bNag/Vv6LfFbgJ8g0G45lbPk2UtklaenG7vCSN/H3ESRROnBrwU/TrelaoPXVad/H7+PC7hhFTYCZD3bAYlJo297KkVB7mt2Zac1v0QxyRmIi21NtTirnj04/BQNhfIFDu8rjZ8bhsrqqJI8Yu6hvSxLWjWkQO8FCnNyRan6gIPvVRT9m2CE4TDP1DIyG2oUgSRmGFjTV6LvOByXxnFWcOlcMlhcL1dgJDtFUvgZxP7Rmdt1S7N/aLDhToTz18gKFxSW874XeXIVSgnGFoCUjhITBijc8yD8kDdU4SQ8noMcsxWDMlmiGbJVCbfXVWrgCETDXqEuPEhxG1xTh2cigK6aSf9CFtXSVPo9ifEKoJW3gL9qBUgJ40v7CzQ+L7sLIbnLvOcPkt/6pc/XrokGkXy67T2RoRKjluIBli6yVd9dcilc5A8LhRwXEBq8VnJh6IGFBYnADM8TldFNou8CoVaAfdGhpby6JMgaHObb2gNq1DukeP3XJOBvBGI83of9IBaztXgx9fmBmnM8gDBb/qLo5+P4O71CuV7oDrlnJPomQxmZJ83Qw0l/cz8s6mwSnTlT6kFLQ9/BHyEJBnVWf4dtSsiGp5+F7JiFd2XJaRZpcOMusrJdqnIh0Ww1KDocw6Yw28tQSom1mw18JHo80L5jnPo4px6TXVN6RUDT7mgS8fIt9eBcPtzy6qwICl6ziQC5DDUBcynb8O0w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fad7c5-a271-4100-22f5-08db3f9975eb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 23:14:14.6029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMOVsKjDUsrmfXLobkRu7UertWYZ4dEUHozKnKyiP34A54EK6IXdvKs9VWQVSpVDBz+heLVQ5EHwrDtye78Rtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304170204
X-Proofpoint-ORIG-GUID: rFU8emzm288gq0HrQt9zw5w0qPOeyNrA
X-Proofpoint-GUID: rFU8emzm288gq0HrQt9zw5w0qPOeyNrA
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/17/23 2:53 PM, Trond Myklebust wrote:
> On Mon, 2023-04-17 at 14:51 -0700, dai.ngo@oracle.com wrote:
>> On 4/17/23 2:48 PM, Trond Myklebust wrote:
>>> On Mon, 2023-04-17 at 21:41 +0000, Chuck Lever III wrote:
>>>>> On Apr 17, 2023, at 4:49 PM, Trond Myklebust
>>>>> <trondmy@hammerspace.com> wrote:
>>>>>
>>>>> On Fri, 2023-04-07 at 20:30 -0700, Dai Ngo wrote:
>>>>>> Currently call_bind_status places a hard limit of 9 seconds
>>>>>> for
>>>>>> retries
>>>>>> on EACCES error. This limit was done to prevent the RPC
>>>>>> request
>>>>>> from
>>>>>> being retried forever if the remote server has problem and
>>>>>> never
>>>>>> comes
>>>>>> up
>>>>>>
>>>>>> However this 9 seconds timeout is too short, comparing to
>>>>>> other
>>>>>> RPC
>>>>>> timeouts which are generally in minutes. This causes
>>>>>> intermittent
>>>>>> failure
>>>>>> with EIO on the client side when there are lots of NLM
>>>>>> activity
>>>>>> and
>>>>>> the
>>>>>> NFS server is restarted.
>>>>>>
>>>>>> Instead of removing the max timeout for retry and relying on
>>>>>> the
>>>>>> RPC
>>>>>> timeout mechanism to handle the retry, which can lead to the
>>>>>> RPC
>>>>>> being
>>>>>> retried forever if the remote NLM service fails to come up.
>>>>>> This
>>>>>> patch
>>>>>> simply increases the max timeout of call_bind_status from 9
>>>>>> to 90
>>>>>> seconds
>>>>>> which should allow enough time for NLM to register after a
>>>>>> restart,
>>>>>> and
>>>>>> not retrying forever if there is real problem with the remote
>>>>>> system.
>>>>>>
>>>>>> Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock
>>>>>> requests")
>>>>>> Reported-by: Helen Chao <helen.chao@oracle.com>
>>>>>> Tested-by: Helen Chao <helen.chao@oracle.com>
>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>> ---
>>>>>>    include/linux/sunrpc/clnt.h  | 3 +++
>>>>>>    include/linux/sunrpc/sched.h | 4 ++--
>>>>>>    net/sunrpc/clnt.c            | 2 +-
>>>>>>    net/sunrpc/sched.c           | 3 ++-
>>>>>>    4 files changed, 8 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/sunrpc/clnt.h
>>>>>> b/include/linux/sunrpc/clnt.h
>>>>>> index 770ef2cb5775..81afc5ea2665 100644
>>>>>> --- a/include/linux/sunrpc/clnt.h
>>>>>> +++ b/include/linux/sunrpc/clnt.h
>>>>>> @@ -162,6 +162,9 @@ struct rpc_add_xprt_test {
>>>>>>    #define RPC_CLNT_CREATE_REUSEPORT      (1UL << 11)
>>>>>>    #define RPC_CLNT_CREATE_CONNECTED      (1UL << 12)
>>>>>>    
>>>>>> +#define        RPC_CLNT_REBIND_DELAY           3
>>>>>> +#define        RPC_CLNT_REBIND_MAX_TIMEOUT     90
>>>>>> +
>>>>>>    struct rpc_clnt *rpc_create(struct rpc_create_args *args);
>>>>>>    struct rpc_clnt        *rpc_bind_new_program(struct
>>>>>> rpc_clnt *,
>>>>>>                                   const struct rpc_program *,
>>>>>> u32);
>>>>>> diff --git a/include/linux/sunrpc/sched.h
>>>>>> b/include/linux/sunrpc/sched.h
>>>>>> index b8ca3ecaf8d7..e9dc142f10bb 100644
>>>>>> --- a/include/linux/sunrpc/sched.h
>>>>>> +++ b/include/linux/sunrpc/sched.h
>>>>>> @@ -90,8 +90,8 @@ struct rpc_task {
>>>>>>    #endif
>>>>>>           unsigned char           tk_priority : 2,/* Task
>>>>>> priority
>>>>>> */
>>>>>>                                   tk_garb_retry : 2,
>>>>>> -                               tk_cred_retry : 2,
>>>>>> -                               tk_rebind_retry : 2;
>>>>>> +                               tk_cred_retry : 2;
>>>>>> +       unsigned char           tk_rebind_retry;
>>>>>>    };
>>>>>>    
>>>>>>    typedef void                   (*rpc_action)(struct
>>>>>> rpc_task *);
>>>>>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>>>>>> index fd7e1c630493..222578af6b01 100644
>>>>>> --- a/net/sunrpc/clnt.c
>>>>>> +++ b/net/sunrpc/clnt.c
>>>>>> @@ -2053,7 +2053,7 @@ call_bind_status(struct rpc_task *task)
>>>>>>                   if (task->tk_rebind_retry == 0)
>>>>>>                           break;
>>>>>>                   task->tk_rebind_retry--;
>>>>>> -               rpc_delay(task, 3*HZ);
>>>>>> +               rpc_delay(task, RPC_CLNT_REBIND_DELAY * HZ);
>>>>>>                   goto retry_timeout;
>>>>>>           case -ENOBUFS:
>>>>>>                   rpc_delay(task, HZ >> 2);
>>>>>> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
>>>>>> index be587a308e05..5c18a35752aa 100644
>>>>>> --- a/net/sunrpc/sched.c
>>>>>> +++ b/net/sunrpc/sched.c
>>>>>> @@ -817,7 +817,8 @@ rpc_init_task_statistics(struct rpc_task
>>>>>> *task)
>>>>>>           /* Initialize retry counters */
>>>>>>           task->tk_garb_retry = 2;
>>>>>>           task->tk_cred_retry = 2;
>>>>>> -       task->tk_rebind_retry = 2;
>>>>>> +       task->tk_rebind_retry = RPC_CLNT_REBIND_MAX_TIMEOUT /
>>>>>> +
>>>>>> RPC_CLNT_REBIND_DELAY;
>>>>> Why not just implement an exponential back off? If the server
>>>>> is
>>>>> slow
>>>>> to come up, then pounding the rpcbind service every 3 seconds
>>>>> isn't
>>>>> going to help.
>>>> Exponential backoff has the disadvantage that once we've gotten
>>>> to the longer retry times, it's easy for a client to wait quite
>>>> some time before it notices the rebind service is available.
>>>>
>>>> But I have to wonder if retrying every 3 seconds is useful if
>>>> the request is going over TCP.
>>>>
>>> The problem isn't reliability: this is handling a case where we
>>> _are_
>>> getting a reply from the server, just not one we wanted. EACCES
>>> here
>>> means that the rpcbind server didn't return a valid entry for the
>>> service we requested, presumably because the service hasn't been
>>> registered yet.
>> That's correct.
>>
>>> So yes, an exponential back off is appropriate here.
>> I think Chuck's point is still valid. It makes the client a little
>> more
>> responsive; does not have to wait that long, and the overhead of a
>> RPC
>> request every 3 seconds is not that significant.
> It is when you do it 30 times before giving up.

This is true for a dead NFS server, we save 25 RPC calls in a period
of ~90 seconds.

In the case of a head failover and the NFS service on the takeover
head can take up to 15 seconds to restart to pick up the new exports
from the fail head, then the client can potentially wait up to ~20
seconds, after the NFS server is ready, to resume normal operation.
IMHO, it's a 'long' time and I'd prioritize speed over saving some
overhead.

Having said that, I will make the change that Trond suggested if
Chuck and Jeff don't have any objection.

-Dai

>
