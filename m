Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AD35909E7
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Aug 2022 03:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbiHLBex (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Aug 2022 21:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiHLBew (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Aug 2022 21:34:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B856BBF71
        for <linux-nfs@vger.kernel.org>; Thu, 11 Aug 2022 18:34:50 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BN6B2J010959;
        Fri, 12 Aug 2022 01:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7L+Kj8Ytq2Ml8kDqapYPPpEHS0UtUxk53M+ZxxY20ZI=;
 b=u7dHP0ffa96e/nQ+NtM6jnCKm7EWuuHxT3RganzT8kvpKc5vXYdApJ5zi68K8Z1+M05F
 APZGAKDYDc2t3M/kHdz247gq3xOzC3tOoXwrOQgeOP8GBZqezJxnSaXnmpPetV+UuQVt
 foTRBmlQiLTC5X2XXIiKkjKlJnr+FQlijmU/BHSTmObY6GCOAX7NVTdqPbFeZWBcXFuu
 AXoSNmuHOTkFyXaRZnVkgDBT0dELx4uH0sO7Uv1XqjYS9JwEJO8HitHpHzS2LWJ1Zz4S
 yFemVBEJYQwbSq3BbtfCB4VWZTw7Vh3Zuk9eVxlwQjZhl/BEGWfDM4O9bkF06GWxQtiY iw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqgp34e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 01:34:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27C0THoD018973;
        Fri, 12 Aug 2022 01:34:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqknt6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 01:34:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0z6SygdDHVj2us31ISLZ0NBCVib5wnSO/NKCbvjvNBLAxi2ff+MxMzJ0RwmlRCfSAxUbJwU7hOkHSMG90n3dDM/kZ/MxvfVqaL0Zreu3RRVvyCrm21OYY45kic6GTLCszSwS2f/Cpe8neBsmFbxLHqpvpacJhXBE9TIAItrJKBXf25admXU2DnIrPCyO5e6urscyzWRqwnIGWNN8VoMLjr5Fz3gQzLStiizNbO1ZrWcRf09vxsA2FOrGy0hgFmKkxEuuxYir1TO30Og8DSHTosF+yDfZB9AS9Hjt+3gX/F+kz15lWsgjsarpkyakW2KnuHQxxBNkNJVVMehm2m9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7L+Kj8Ytq2Ml8kDqapYPPpEHS0UtUxk53M+ZxxY20ZI=;
 b=MMgUuLWxuWp2XyHQz+rf6f8Gsf13s3B4z3oKRbBbVnsJSxDyO03Wmq0QvIpplDqOYluv0w7m+rTmiraHcQS36nxEcluqVG8Axvmxji+ylrQSDTktvcQ4lOI7WANluVRuji3/nZBJSbRqTyWFazsIYviwibSnrCpriX5Wl75pRH4j3xLopXeBh05seshIbCZ2eVI4zSKIaivzLjH5yjqGgAzDYsbr6TVTZ4kLesHvkyd/FcTaZ4dA04cedTACF0NoSmpPeKx/F5CA+qOvj00UGOA1qHT/KXyQJtFv1CyUXvzAPgLgEYsmOVnZ+26eArWIFvpk/qlcezKAcjGFuuThIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L+Kj8Ytq2Ml8kDqapYPPpEHS0UtUxk53M+ZxxY20ZI=;
 b=yh/mxSz+EL0rEdpq7ZO00MOn9MoUji6uusugwVWwgXOwnqS59oybngl0oTOipQR3y86eOnLiD+kGo/0MuXps+Zj4hVglBzZEKEL4Z8l+DgER4shO4gszLcj+SNkuVnePxUcPUeiIB0F/d7V1zlQNN6+vf2E6kLm1+v/WLE3/z0w=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BLAPR10MB5251.namprd10.prod.outlook.com (2603:10b6:208:332::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 12 Aug
 2022 01:34:37 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd%4]) with mapi id 15.20.5525.010; Fri, 12 Aug 2022
 01:34:37 +0000
Message-ID: <ac641c57-2153-b2a3-a48b-0433dc6102da@oracle.com>
Date:   Thu, 11 Aug 2022 18:34:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: help with nfsd kernel oops
Content-Language: en-US
To:     Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
References: <CAN-5tyFLDrUMaTTi8ECTrKkAxxSdXGPEweGj8sQk5yW-vkmJ5g@mail.gmail.com>
From:   dai.ngo@oracle.com
In-Reply-To: <CAN-5tyFLDrUMaTTi8ECTrKkAxxSdXGPEweGj8sQk5yW-vkmJ5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::35) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fae2935-70e2-4e96-4c5e-08da7c02d15d
X-MS-TrafficTypeDiagnostic: BLAPR10MB5251:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aw/idonkVDkWnkMChvFeIbQisHp4S3yD5hpJ9k/ydQwJedMjiCbj8AonluhwcztBNcSsNmjTHPEnlOZi4DL4eMQGvP1DPSdV4CYKhniRbk9XtrI2TVY9KCsDRbvuQWn3HrpZuE5zW/tT7zdbXuTWW+glSifl6a5CKeluZGNtj0e4TgQXi+kqqkLC9MXEySa20ZzT4hiUYyKuNLBGDU+X3sDGvEGlenS0TOPqAE8PShFhrIZ+djcHE2M8uQOVq7bTc7yXX5n3xo3BE1JEWJadu0UymlpHJtojtMwSZNYuJDRaX032IL8WJwmR0f2y2KwCfirsgAclgyMqITnyPrhIjuFCX65210fgD9Y4lTSJNsOhbUgpeKu1OpL+TsedopLUChl6o2F+KR95vX18rc9XGpO1FoIPrR18IYK4xPUenHAKkayhJm2TLNNTDS7JQlflVmbsAisCffJl8ki/zeCLXG6gTZSGfXVfD9gvER61Dqb4or9grHINUhqEWHk6aRgUNbdFt4mO/tTYdSm4os1vW9wboCq7ArS8iB9HPSafNWEvhE0SvBHXl15vO5gMeIplF4gsIkGRZzmOnuB/PmET6dybr/NjXAyJrx/sBTwJ56AHvIC3cfn6A0neqYZySbNTEDJQaq6PhaCeZ+eZSUqAwFdZ7YucbryXQlsH08d7+ddwQ5JnWf6hrW6tA2+CYzPK0HEGx577tSRvGhBTAx1IZbcRutASFhg2nbOutYSX777pC8iiNG8zEYFQxjtFocRB9T+KxMxJQVVoKQDvef4lz0c7Q45Yp2kDj+fRVguhlh6P6eHihFkVK5AHmnHt9bUzepLaz3ERrHedUtUwPetwBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(136003)(346002)(39860400002)(396003)(26005)(6486002)(41300700001)(478600001)(316002)(4326008)(2906002)(38100700002)(66556008)(110136005)(8676002)(66946007)(66476007)(8936002)(5660300002)(31686004)(36756003)(86362001)(53546011)(31696002)(2616005)(6506007)(186003)(83380400001)(6666004)(9686003)(6512007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFVEQVJ2Tm9LQ1gxNnhlVFIzUTdyM0czNGdBU0I3azFhMENKRTRNZ1BjZm1X?=
 =?utf-8?B?SnNnTUEzaXpxQWtXUFd4dldPZjh2ZGtxa0JoUmVxQVVjWFhIa3Jqd1NKSk40?=
 =?utf-8?B?akR1b3I2VEJCWm1ERXExc2RFNi9Mc1M4aFdGWEJOWkswU1dwMUdKTVJMSkJS?=
 =?utf-8?B?OWNYMy9Xb2hpSkZCRzdBdXdmcXg3UU5NcTNzOWFLcnJxRXd1ZDhtbTBva2ty?=
 =?utf-8?B?WXR0WmFzbmtueW9ZelFnb0FRL29JY2FlWU9xMXlBTzQ5bWpNVFQzWHBMRFEy?=
 =?utf-8?B?N3lJQ2tEZ0M1VFVLQnEzWWM5aDgxUW81d3dveFYxeEVqc0ZGWWhhaGJNQXZk?=
 =?utf-8?B?NnEvbG10QXJBaG9kYmF3LzhtNDVlWU9JRTFmdnpWVllHSEk3SjlxMERmWWxQ?=
 =?utf-8?B?cjU1Wm0yTExRbmEzTFc4VEg5d1lzemJYL2tUY21vOEV2UWlxbDhKMExpcjht?=
 =?utf-8?B?OGcxQzYvVXJLZ1ZoMWxLeXhrVmRReDJSbk5ONHZFc3l5WEl1dlpoS0RNTUxv?=
 =?utf-8?B?Rld3ZytsMWdnbGFwL3hSMjM1YWV3ZkZDUnF3L2Zydm1MbVF1anF3OWU2Z2hX?=
 =?utf-8?B?OWNGQWRrdUZKQU1UMVRRNytOamV4YUluVW5BOEQwb1l5R0dPbG42R3ZIN25u?=
 =?utf-8?B?b08vRDNjSnlwQno2OGZSMWZFM2lpeDJ4M2lKVVdZWjh5dWsxZVZGeUFCMnc1?=
 =?utf-8?B?aHdWNkZrSGd0dEIySFdPY1MrcXg3MVVpcWNibzUwQm90SWlidThhMlVXMCth?=
 =?utf-8?B?bm90RjRIRXQ3bUVRZzR3amMwVjg2WWg1cnY5Smt2SXUzZDFOazY5dTM4TzY2?=
 =?utf-8?B?V0s5RDhjSUFFRWhpcEhnblVuTURkVHVNOWdDQ01NTGcyVUVaZ0RBQ1FnQk8x?=
 =?utf-8?B?Tlh3ZVp4VGVMMk5zcnlUTTczUHAybnRIQkRNYVpFMCs3UVlsdnZ4ZXFtSGNw?=
 =?utf-8?B?cS92S2lLUktvbjNlNVRMSURhR0F4Z0dGK2JHYndFT09TZEFJdXFJbDFaVG5s?=
 =?utf-8?B?UGF4bzZXMzkxNytVQVRRMXdDaFhCQ1dUWUVMVGFRb2RIU1pzL01WOXZxbXR6?=
 =?utf-8?B?WTlTRU9EQ0VkQU5CMEZQZWYyUmJCTlAzK1BHYnlFSkQ4TnBNUGZ1QjEvTGhP?=
 =?utf-8?B?T2dtMXJ1RFlvWXNuRkExVzFObDV5VnlPbURHYzg2SDBucVM4MjBMdmpkNG13?=
 =?utf-8?B?cThPRDBtZ29HM1lZM0ZQUmZBRFFQL2hZTFo5dDY5cDF6ZVVHSDZ4QXR5Rlgv?=
 =?utf-8?B?d3cwYUZvRUZkaE1JbThienRRVWZ3NlkyK1pFM3J4NkNJUzVSWGdtd1BkWU5r?=
 =?utf-8?B?bG9PR2JMM3FXMHdPeWxEelhCdGtuR3hJY3dZR2FxMVdPaE5sT3l3dTZxRHdK?=
 =?utf-8?B?OVpGZ05lT0tWTXVIcmhxZ1JMTUgxZjZFYjF6Si90RFNyVnNudmg4Nkc2aExv?=
 =?utf-8?B?QkhIanE1OHpwcVpGVkdLUkt4VVV1ejhmS3pWaFMwaUNrcHhaTWgxT1ZUaUVG?=
 =?utf-8?B?dlE2cXJaYWNJTFpxRUxjUGUyaXJaMTdKa2VTUmVoVEdqWFdicFlIT0tSVEQw?=
 =?utf-8?B?cmFnclR3azBVMkdNRWVLcUhPOUF2UkM2YmpiMTVLLzVTUEN0M2N2Uyt1Z0d6?=
 =?utf-8?B?Q0ZkbzU0RFJ0TWhWckR4cDRRWTgwU3pGWExFdjh3eW9SR1grMGZEMFNqeUI5?=
 =?utf-8?B?RDgyNU40N05LRUM0UklZMjErVmxiYkpKNVVPMnZWYXRzTlZCZGVDOTVTNDls?=
 =?utf-8?B?VktENUkvSitUWlZYb0s3UHFYV1FEdTBkdHJTZGR3eC95VG1UTU50RnpVTy9o?=
 =?utf-8?B?cFJnNDhnOE5aZXF5NWdFUnIvYUhBYkNFc2ZYL3VRNzJVV3lSSC9QYjV6QjVu?=
 =?utf-8?B?T3NxMkpBbVlvMzZkMkxCcEZLcDNUeGR5QzJNZkovSVNUK0JxS1luWWxkajRz?=
 =?utf-8?B?WGhaRUJhd0poMGV5UWg3ck5FdHNNVHFTeTBlc2RUYzZjYi8xcVkvWlhQbUZN?=
 =?utf-8?B?cUdxZE0xd29idUx6dVNrMHN4OC9ZRitmWGNHWElNdDh4WUpkR3hjdmpKYXJt?=
 =?utf-8?B?bFlrcXpMcG1OZi9Qc1Y2UzhHWTFJSWppblpKSFkvMDBPQi9HRURISmtXMFlx?=
 =?utf-8?Q?cvS3q2UfDaNY5aL9L7jWyF8S5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3hktgf0nhsKOwHMS2eCv1jsOItsxZcmHuFTD024D7ZgiHat3qlrblyZoOmCorxLWcnsJYL0+1oMrkhPHRCrZjPuR5HJD5hFyGUI2nCaog5pz6qOT8SICDSZ4uMDSogaw7RTSE8AdlY6zWQuU4m/sIUJBwO6cdsVxKTrNiw3fkHQnsb0n0JR4/vjan78mf4l8VryYrCaRpHo280Q1TT6m9MVA2Fi9kUAHgMwPPjU1OtfY50BgmzutVK022LbruXief76IV+Qc0glDpMpmKWdlu/csI0C9lCMyMfcnJa8RzV0TO2eBktDq6K5wL0mccWSMTBJYqVI4zDrMt2ficzijNWHOfsmJX30urQaTpPbZ6OvyyrkY+ijsv1ArTnBEM2YKgaBhDfQCJt3zeupOYIPDdjU1wZdRYNqwBlTxd8Irckm45Dlo2EN8ZTy1WPPRo+HZcfzPUmv3oPwgecxStff1z8TtMxTZVVoS807ReEatK7xXf0rnkdaBVJBIPOTtvtWvRO5DLbiwlB+D7MGVNMtWzS+3+pQsjwfGeRV1id9N4rpILx55XG/W7koTx0IqoZNAjsIfn8D/c4f2hCXKyijbBGeM53oc9S/YeUHKsOhyOfDTz6NqQNaALH2f7oj1+5zhnCQp1fmwjdl3Ei6/6NuJzaWRClV8HTAGTTCOHS7IuCGxtNSrWl63KHf59G23INauUkMcJuf9N35HYc25CtFtNhQh5SqxORzOh0ArBp2WraF7xsJ3PeHrES+bTcIyb3+fyt+dK/zt4wUri5+YV/z0jOPoI2+fY2z+AwXce19w0rK295RZoy0+dR1Nv3+qe1y6
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fae2935-70e2-4e96-4c5e-08da7c02d15d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 01:34:37.2083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xl3I+IiDPig5Kge/LgwvmkbnSVXjbTbFhNE+sDWdiUBjXUjm0D4Q4UCCdRSYwpwC2GuZuyqrfcU9AeMz/Wu3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_01,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120003
X-Proofpoint-GUID: 6wTPDE4MRH2lTHcS4lLD0sRsdY2_dtZI
X-Proofpoint-ORIG-GUID: 6wTPDE4MRH2lTHcS4lLD0sRsdY2_dtZI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 8/10/22 5:50 PM, Olga Kornievskaia wrote:
> Hi folks (Chuck/Jeff specifically),
>
> We've had this outstanding kernel oops that happens (infrequently) in
> copy_offload testing (stack trace in the end). I've been trying to
> debug it for a while, added printks and such. I can hand-wavey explain
> what I'm seeing but I need help (a) nailing down exactly the problem
> and (b) get a helpful hint how to address it?
>
> Ok so what happens. Test case: source file is opened, locked,
> (blah-blah destination file), copy_notify to the source server, copy
> is done (src dest), source file unlocked (etc dest file), files
> closed. Copy/Copy_notify, uses a locking stateid.
>
> When unlocking happens it triggers LOCKU and FREE_STATEID. Copy_notify
> stateid is associated with the locking stateid on the server. When the
> last reference on the locking stateid goes nfs4_put_stateid() also
> calls nfs4_free_cpntf_statelist() which deals with cleaning up the
> copy_notify stateid.
>
> In the laundry thread, there is a failsafe that if for some reason the
> copy_notify state was not cleaned up/expired, then it would be deleted
> there.
>
> However in the failing case, where everything should be cleaned up as
> it's supposed to be, instead I see calling to put_ol_stateid_locked()
> (before FREE_STATEID is processed) which cleans up the parent but
> doesn't touch the copy_notify stateids so instead the laundry thread
> runs and walks the copy_notify list (since it's not empty) and tries
> to free the entries but that leads to this oops (since part of the
> memory was freed by put_ol_stateid_locked() and parent stateid)?.
>
> Perhaps the fix is to add the  nfs4_free_cpntf_statelist() to
> put_ol_stateid_locked() which I tried and it seems to work. But I'm
> not confident about it.
>
> Thoughts?
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index fa67ecd5fe63..b988d3c4e5fd 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1408,6 +1408,7 @@ static void put_ol_stateid_locked(struct
> nfs4_ol_stateid *stp,
>          }
>
>          idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
> +       nfs4_free_cpntf_statelist(clp->net, s);
>          list_add(&stp->st_locks, reaplist);
>   }
>
>
In the use-after-free scenario, the copy_state is inserted on the
sc_cp_list of the lock state.

So when put_ol_stateid_locked is called from nfsd4_close_open_stateid,
with your proposed patch, nfs4_free_cpntf_statelist does not remove
any copy_state since 's' is the open state.

Also put_ol_stateid_locked can return without calling idr_remove
and nfs4_free_cpntf_statelist (your proposed fix).

-Dai

>
>
> [  338.681529] ------------[ cut here ]------------
> [  338.683090] kernel BUG at lib/list_debug.c:53!
> [  338.684372] invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> [  338.685977] CPU: 1 PID: 493 Comm: kworker/u256:27 Tainted: G    B
>            5.19.0-rc6+ #104
> [  338.688266] Hardware name: VMware, Inc. VMware Virtual
> Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> [  338.691019] Workqueue: nfsd4 laundromat_main [nfsd]
> [  338.692224] RIP: 0010:__list_del_entry_valid.cold.3+0x3d/0x53
> [  338.693626] Code: 0b 4c 89 e1 4c 89 ee 48 c7 c7 e0 1a e3 8f e8 5b
> 60 fe ff 0f 0b 48 89 e9 4c 89 ea 48 89 de 48 c7 c7 60 1a e3 8f e8 44
> 60 fe ff <0f> 0b 48 89 ea 48 89 de 48 c7 c7 00 1a e3 8f e8 30 60 fe ff
> 0f 0b
> [  338.697651] RSP: 0018:ffff88800d03fc68 EFLAGS: 00010286
> [  338.698762] RAX: 000000000000006d RBX: ffff888028a14798 RCX: 0000000000000000
> [  338.700442] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffffffff917e9240
> [  338.702257] RBP: ffff88801bb0ae90 R08: ffffed100a795f0e R09: ffffed100a795f0e
> [  338.704016] R10: ffff888053caf86b R11: ffffed100a795f0d R12: ffff88801bb0ae90
> [  338.705703] R13: d9c0013300000a39 R14: 000000000000005a R15: ffff88801b9f5800
> [  338.707510] FS:  0000000000000000(0000) GS:ffff888053c80000(0000)
> knlGS:0000000000000000
> [  338.709319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  338.710715] CR2: 00005640baab74d0 CR3: 0000000017574005 CR4: 00000000001706e0
> [  338.712282] Call Trace:
> [  338.712898]  <TASK>
> [  338.713430]  _free_cpntf_state_locked+0x6b/0x120 [nfsd]
> [  338.714806]  nfs4_laundromat+0x8ef/0xf30 [nfsd]
> [  338.716013]  ? dequeue_entity+0x18b/0x6c0
> [  338.716970]  ? release_lock_stateid+0x60/0x60 [nfsd]
> [  338.718169]  ? _raw_spin_unlock+0x15/0x30
> [  338.719064]  ? __switch_to+0x2fa/0x690
> [  338.719879]  ? __schedule+0x67d/0xf20
> [  338.720678]  laundromat_main+0x15/0x40 [nfsd]
> [  338.721760]  process_one_work+0x3b4/0x6b0
> [  338.722629]  worker_thread+0x5a/0x640
> [  338.723425]  ? process_one_work+0x6b0/0x6b0
> [  338.724324]  kthread+0x162/0x190
> [  338.725030]  ? kthread_complete_and_exit+0x20/0x20
> [  338.726074]  ret_from_fork+0x22/0x30
> [  338.726856]  </TASK>
