Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B765688AED
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Feb 2023 00:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjBBXjN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Feb 2023 18:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjBBXjM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Feb 2023 18:39:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F35365EF0;
        Thu,  2 Feb 2023 15:39:10 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312IDnYc023779;
        Thu, 2 Feb 2023 23:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7MQ1FauXbrv3Pw4+fg8rieGyA9392gB8jND675QgMgg=;
 b=zolXBXxjsslzEbUo7OZKPEkAVpTo8/ymBHde3Ec77yZ1gfiaM8YfeuY9bs61CK8Y4DFL
 ITiODp82QIXLYX2Oc5RdRkDIPgnMD6cJQj0RT5nzMUxCPhql4ye6Z15dr3IDXb4XxPJh
 PiHxtwWDLC5GNfpKpQG69Le6g2MdSikMQKFPmG8bA47qsqsR2KqbtDVC8bpiDJ3NZ+Ww
 Wvczo99dtOEiNoiKP0GanrNDQxmcQthQtBdUw+WRgJ7hWSb1pnaeu+uq9TxraofEsdSm
 xYtHajv7162OLbc6jTt35g/tD96ZCtlJgh64XgIlzYi1sUySsTKYHiYaVjBnKpm1eth3 BQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfq4hm784-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 23:39:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 312NU7g4034298;
        Thu, 2 Feb 2023 23:39:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5gbnmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 23:39:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Im8ByfMq1UI/qDFDw0PTITgbq4OaYFE5kuNWJ3DwHgXhPjUplyJcbcjxpl4hZPnG2mOsJkXl9uOYZHVm1gGhYNd/fMYq211cmhcQMO0iaZHm9Or713gFGNL93QYLv0mMs2YluroaePF9eZhrESPYiStgFEwHibk6VQd8OFR2YBlLpKxJlDXBrWwV1p6K9DHj7Bdi+5vhQOwbNU795YkP9wtLCU3kOBPz+MgjA9+Jk6YLLb21hOBYmwCvLTRM01KDmcxmIa1ao+vHetQWxZ6CcQo1uiYKsUwt1xhIBArDHjWBQRkLqWK/f4AclA4z6mNMebLSMzG4bWAXt4LgZCtLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MQ1FauXbrv3Pw4+fg8rieGyA9392gB8jND675QgMgg=;
 b=e7/lWCHv/9mems1VtSJhR9xj/p+VizLXt37iAeEfmLBPV1+fw3KqHWGGcx5XcKZVjAFjX6AqfCsYX3vpLX/T0s5/NjZ9b5e3Fax6WNSNv8nUX5206ErYHqLt9d72aYaViWHjv5220k7QUuBIqjCU82y2EQzK0bbMSmoXjnCz6nfloKOjuTxBdSwqGVgVuVUV8485B86AIldx11sWGmlJhpSkGKtrnNnysNTZXHa20H3YgX3NkrSbJD4poJ2RUeSDA5w8MiqCzimFojW+mXxj4tLDMwi5nW+3Ttjgw8uiIrGyxIf7dcVzDpe2bAH9exqlf2wABgdUWXfbQt+m9/rg0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MQ1FauXbrv3Pw4+fg8rieGyA9392gB8jND675QgMgg=;
 b=y/lp8enefQzCsDjwT2Wkh3YQz2JMsu8lPklZxfByGD20D2ZTpETyNo+aCxMQKbcXZEDV339Wc1agyYxz8uhXJyBaf67mkyL3p3idSbcpx4E2o+Zt0CYJ9CJfwwiNMeuq07gPrImGg5PDo+8R/6hKB23oxRJcXhlGBYiSvaoC+x8=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by IA0PR10MB6819.namprd10.prod.outlook.com (2603:10b6:208:438::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.8; Thu, 2 Feb
 2023 23:39:01 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2280:b9da:9056:c68b]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2280:b9da:9056:c68b%3]) with mapi id 15.20.6064.022; Thu, 2 Feb 2023
 23:39:01 +0000
Message-ID: <1bf774e2-8667-b222-7cbc-ccdd24bffdb0@oracle.com>
Date:   Thu, 2 Feb 2023 15:38:58 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] NFSD: fix deny mode logic in nfs4_upgrade_open
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Pumpkin <cc85nod@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230202073611.13106-1-cc85nod@gmail.com>
 <CBAFB3E5-5737-47A7-8234-3A771E908C4F@oracle.com>
 <7b7edc8bacb863915d00673f9e03d38798341a69.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <7b7edc8bacb863915d00673f9e03d38798341a69.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0240.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::35) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|IA0PR10MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 820efefd-02cf-442b-9341-08db0576a9a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IdPbZObs9Yxp8+MA5orkUybjKYpmcBA7Wv/6OQBKmLrRt6z+VzUAoC2aIaB62JqkAM4HeFKm9rRmaSyrfwzmolJ6a8Y7vuomtT+qlmbn1fEw/4IfjhTOoDzKbOtoqt/TTeHopTc8jibugAp6cdeBicRN3pztW+pMpmZdHxw/yy1yA1GBa3HnRdi8GykQHtnFCtXxjbbIR8/fdq8uBjhx18EXUdA7d4gkm+1wC7kBV2AgjJEzpcMmnKvGbMHg5dF1kVlTYhtJBRYG2FOPoKdeeNSXyQFMTPzBZ9rToIyd0SV3M+zpy5xHAaRm+DTuk/pA2Ox6hN4knjBZmJeHWiZ3jkFP3vKdmTfixwTc8TdOhIQ8L/kYAUe/NRN9OKPhCgYD1Sti6lQrmlBqkOcplX1fxeJAStx7hXI08TQ4aqhUdNp++WztTL0Fjcem6+Pv72dMZNB/WhARZROBcf+6PMorMC83W5bxdhtCnRd62zIWjvABSVmqZUw8xt1CPXG6K/lUEEPz9y7CzYFfyAtezC7ZWaJz3L5TCTnmsYk915os5RgL10rZocqTKH4SOurCdq8oFpkU9j15SU2JJLiYLqVp6JIpKUykqzRFc5qMea81uw5nizfQy0kebGcDmDfGm816FY1F35kiQmTSl/RfcTCyyF+pugrfeKyPcUQc9ssmyApTrazrdbmBLll9AmiykvDEP1owWVLNssjnVRv89+zaPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199018)(54906003)(316002)(110136005)(38100700002)(2906002)(36756003)(31696002)(86362001)(66946007)(66476007)(8676002)(4326008)(83380400001)(66556008)(41300700001)(5660300002)(6666004)(2616005)(6486002)(478600001)(8936002)(6512007)(26005)(186003)(9686003)(53546011)(31686004)(6506007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU1GMUxyL0c1NkM0WUJDZXJaMGY3c21UMEtuZ250d3J5R2d4ODNiWGo3SW8r?=
 =?utf-8?B?VFJsU2tNVG9HeG93Sk1JaW1udW0rcjdRZFprQjNSMVhMdGNwN2JSNWw1dVBU?=
 =?utf-8?B?dU9ucVhNV3ZLbEs1a2kyV29MSHhjbm94dFAvZ3JINCtKU2s2YzAzNmdXdW9M?=
 =?utf-8?B?OUFZdlFJNFZMZmtFTTdOT2Z4Z21MQUNkS042VHFwcHRTSWtvam9MaTJzZFNt?=
 =?utf-8?B?UTRvbXYxbW91eUx1cjRwbXlHbWpwZDVHc2E4aWJ3eGxGcWMraU5RMS9jQ1FV?=
 =?utf-8?B?SFZpN1FiWVA1amJJR0c5VW9MeStUYlJ4dHpZT3JBUkZHcHFoa2JoN2VJY0RM?=
 =?utf-8?B?VHdPbnp4SzlGRjc3VUF5OERINExuK3Z2MmpRQXRlK0VBRHFubTlHVFhXV28r?=
 =?utf-8?B?QWpRYWZrNFpHTEd0RVkyNTlPdzVrM1drU0wvVHZ0WElXaUhQUmhnQUdOeFFX?=
 =?utf-8?B?eElFYnE3MXhSOUdsWkdaUWY2aVBsN2NjL0pBSXJXc2hEeWxhNHhpaG1ySnNC?=
 =?utf-8?B?eVorNHNWdktRNUlqdzU0cmVEV25iNEFBTmx4N3pzWnlMVmUyaHlBY0RRWFBo?=
 =?utf-8?B?UFJkRTU0dExnTHhJTm5UNnBZRGdkcHBkRnlwY3lrY3NzSHZFN0FUVkJCdGsw?=
 =?utf-8?B?ZkVQZm54aDBXM2ZYRS8zYnhVZWNDc2ZEbzRYRnpJWVpOTVZyRHp0TGtQKzhQ?=
 =?utf-8?B?TnRqaitFRkpTREtvcDNSSDNCVzl2YUx2OGhWOEk5amhERXlkOTlpVU56YnVn?=
 =?utf-8?B?ZjFYNE41eU1GOGY5MVRmeWlkSTFkUUlrZ2dqVTMrbHRHM0crWjRlNm5NMURW?=
 =?utf-8?B?Y2gwSWU5V292eXd1ZkZ4L0lYL0ZQRWovQTJYdjRSbXBoNGdpZU0wVnlnMWxZ?=
 =?utf-8?B?WHpETFhqcTc1SWJjcFpoOGF2T2JrZHJlTDBxU2JNaGZPVnZnL3NvNDZ2bUJn?=
 =?utf-8?B?ZU81ejZiUnQ5Y2pLNU5yblBjQTVUVEFIY0tMejUzaWdaMyszalcycVRUUmN5?=
 =?utf-8?B?c3cxUk9jVG93MlNINnk3RFJtRDZMS2l5aDUzM2xNT293UzF5RzZwM09GL2l5?=
 =?utf-8?B?QXdsRXN5ZGZ1K3czekRiOEIxbm82Vlp4QStaN0oweXNPQTFEOExsbWJNakdl?=
 =?utf-8?B?Yy9mcS9QdFJZMWRrZEFYUjZERndhTTZvTUNlb09PSU03d2Z6cE45aDNUa3ZH?=
 =?utf-8?B?MGFDN05ZS0RqYWFlWk91SzdYWDA4WmF0RkhNaEcyaExoQnc4M2QyZnNVMG5p?=
 =?utf-8?B?dmZ3a2pVUkUyemVlbDdLcmEvRGNCVEEzMnRNT1pKUmJETXdDbFpLYzVYOFU5?=
 =?utf-8?B?UExOelZnYlBMZDQ4Wmc3RURqTDlvY000WGorSlltVHdKd2JQYlZqT3duOEps?=
 =?utf-8?B?eUcyQ3N1dWZiWUdMYXI4SkJGdmdzY1JDdG1kS2ZwbFlWamQwaFlqdkpnbTRL?=
 =?utf-8?B?R0wrN1FUMXk2VUNjckYyelBhR1RyeE9ibVBkSTJkZ1ZjRi8za3NyZG5wNXFP?=
 =?utf-8?B?NFJ2eE5XT1BSUk1kYkhHc0EwZVlhNGpxSDZOczVZYk56ZEorenc4ODFyODNT?=
 =?utf-8?B?Y2dYQUM3cy9DTGdGMjRlMGlzd2VKbVptTk83TmdhZ2ZEMnZYV3hxa0FXTVFn?=
 =?utf-8?B?L0R4Z3cvMmx6TmZGNnJ0djBiOXZxb01iN0wrNHc5aWZJZXp1Zis0UHBPcy84?=
 =?utf-8?B?bzRBd3dHN2hGWVB5Z2o2TXdJUk5hQlN4OFJFWnljcDJ3RjNCNFJBZGlWMk1l?=
 =?utf-8?B?aTRNMmdGdFc4RWR6NlJkYU5JUlA4aXpoa1NINEdXcnFOU2RySkJzL3JuT1RG?=
 =?utf-8?B?Mk5Jc0kxM00zT21oMzkvalh0OURoTGtqVmtMb2srK0Q5Y3ZXaElaYnE1ODlr?=
 =?utf-8?B?UGl1ajZIci9VQVEzNUY1WWR5QzkvZWRJVGxTR2JjQkkySGNoVlQrZC9VZnBh?=
 =?utf-8?B?MjhwVU1vVmFoS1J3aTVQOGNRUloxMllyRmp6RS9zQnpxakFEL0xEOEd1Znkv?=
 =?utf-8?B?bHdPeWhDTktNd0cyZXhDUlBUMzl4a1JGY2ZscUVtWGk5amZrTjhYN01ZRkVI?=
 =?utf-8?B?ZU43K0hsanliQURtSVgyN21oRTFQOE9DczJmeEhUV1hQT2JnRGxSS2ZWc1dQ?=
 =?utf-8?Q?44qVYFtZnO0ifDqM1e0nQM0pG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8psUGehnTz84WCSpMB7bYYa/d+Z1o0vE+EoZ2jXUmIkfo520jeulTBBirFNCDIi1Ysv3pl5f2KwKisg1BW5tc4EuPgmKKA20tdjxN/fe3w15NgAiJ+O6Npx6XutI5lD+DGveOW76d0jPjXcQ/LV2JXK1mVWdk2sEwYBu1fjbguPv204TE4RYZPFtNrunYLch9KQNN1aFtPjpZjFqAc2jmvKBXoyu20OPUKCFqwe+OIFfMnyI2zdh9HTcK7ji8lhm+sB2Bvwwp0SboHfK8MPeSFQaiQuh5r+PXCBWLRkOMfyhW3YH3iLNeCW1hYYBFKIX6unN9eml8UEHDWM0sERfliy4HkZ+TMNMtGPNWYZHcnndrCaCym/1JKDT+PiszKr4XzIiMV6bknHK/3tE0bhlg1wDrgR6w4Iuyy2HvEN3YPgYNXGU/U1MbPJw1HiTJpI54fsjFIGV6dZT9WvdoeTUX89oURNPDEuNMj8nvKmyCvWO051SKrzTDoVY689GKdj+0aTr60gepd7cEh0JYyB1c/UZKnWq9VW+TDX7yC9T3CeDE/P7AcCsLcu9lyRvB2nwK1jAf3+P6WwjSxKIiSecg0oVdl8gp2G+0xoC1mNwUQGulM3oyIs24SXEQQb5nTbNJvCVHA60DUW2SrhTgTBtwz1hg7RQCRl0YQ0v02zuetdE1hrL5ZpLExKr8tiN6HYt/0p7JgRg59nGEo4m98OOJgnkNsnF9KIPW5GtWOhVjXe1n8+WesQy/06PV9QokU0kv7MeNKAaKfR8GDSeFMaM9sCW7QS+GhPnbj6l9U6jQOvqnVQ5UkfD+YGArQ4Ydrk+
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820efefd-02cf-442b-9341-08db0576a9a5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 23:39:01.5880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdixWiQONpIXPY1Th8f6gvqVYmjta7/C2/I7wj8BEk/dhf/f3sojFpdDjTtAtdmGk1q7K69YCrHf4X+5Aco9dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_15,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020210
X-Proofpoint-GUID: ZN7iDvxVefZcyzf1E29sPQguhLm_6uB2
X-Proofpoint-ORIG-GUID: ZN7iDvxVefZcyzf1E29sPQguhLm_6uB2
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 2/2/23 1:22 PM, Jeff Layton wrote:
> On Thu, 2023-02-02 at 19:41 +0000, Chuck Lever III wrote:
>>> On Feb 2, 2023, at 2:36 AM, Pumpkin <cc85nod@gmail.com> wrote:
>>>
>>> If the upgrading deny mode is invalid or conflicts with other client, we
>>> should try to resolve it, but the if-condition makes those error handling
>>> cannot be executed.
>>>
>>> Signed-off-by: Pumpkin <cc85nod@gmail.com>
>>> ---
>>> fs/nfsd/nfs4state.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 4ef529379..ebdfaf0f9 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -5298,7 +5298,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp,
>>> 	/* test and set deny mode */
>>> 	spin_lock(&fp->fi_lock);
>>> 	status = nfs4_file_check_deny(fp, open->op_share_deny);
>>> -	if (status == nfs_ok) {
>>> +	if (status != nfs_ok) {
>>> 		if (status != nfserr_share_denied) {
>> if status == nfs_ok then status will definitely not equal
>> share_denied. So this check is a bit nonsensical as it stands.
>>
>> Usually I prefer "switch (status)" in situations like this
>> because that avoids this kind of issue and I find it easier
>> to read quickly.
>>
>> Jeff, you are the original author of this function, and
>> Dai, your commit is the last one to touch this area. Can
>> you guys have a look? The one-liner looks correct, but I
>> might be missing something.
>>
> Yeah, that code is clearly broken and it looks like it was done in
> 3d69427151806 (NFSD: add support for share reservation conflict to
> courteous server).
>
> I don't believe that one-liner is correct though. If the result is
> nfs_ok, then we want to set the deny mode here and that won't happen.

not sure what I was thinking. The check was totally wrong.

>
> Something like this maybe? (completely untested):
>
> ---------------8<-------------------
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c39e43742dd6..af22dfdc6fcc 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5282,16 +5282,17 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp,
>          /* test and set deny mode */
>          spin_lock(&fp->fi_lock);
>          status = nfs4_file_check_deny(fp, open->op_share_deny);
> -       if (status == nfs_ok) {
> -               if (status != nfserr_share_denied) {
> -                       set_deny(open->op_share_deny, stp);
> -                       fp->fi_share_deny |=
> -                               (open->op_share_deny & NFS4_SHARE_DENY_BOTH);
> -               } else {
> -                       if (nfs4_resolve_deny_conflicts_locked(fp, false,
> -                                       stp, open->op_share_deny, false))
> -                               status = nfserr_jukebox;
> -               }
> +       switch (status) {
> +       case nfs_ok:
> +               set_deny(open->op_share_deny, stp);
> +               fp->fi_share_deny |=
> +                       (open->op_share_deny & NFS4_SHARE_DENY_BOTH);
> +               break;
> +       case nfserr_share_denied:
> +               if (nfs4_resolve_deny_conflicts_locked(fp, false,
> +                               stp, open->op_share_deny, false))
> +                       status = nfserr_jukebox;
> +               break;
>          }
>          spin_unlock(&fp->fi_lock);

LGTM.

Thanks,
-Dai

