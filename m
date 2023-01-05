Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB0465F4E4
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 21:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbjAEUA3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 15:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbjAEUA1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 15:00:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3136C1A203
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 12:00:25 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IUMd7002739;
        Thu, 5 Jan 2023 20:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BLUZsWADk9U9X4CaGHT/hGNvoQKKJ5CVfU+Hk0VfwjQ=;
 b=zCU+NSloT6eX93hwqNDoAUfzmefktIA4f0ys4Xs/vGrW9XXHU0GbAzBwF13qY2F5yjtg
 ecxPStWIMyphAhIwJKScBxTW0YCH1ldUZVratSuNI18K8a9bVVx+MImaxLCgFh5Ns5zx
 fe8JJfWZPADQd58YytPHabNMLzOZaNV3M2GeKtkPSUwBmvpgI7c1RQZwCGoHymZBlO9W
 /s23sNW4DPmUOyJlen7To62eK/K502d+ohnqaXYRTFEG3K3C/w7X0WnggprlVTVoM6B7
 zgEnuXGFKLxpikJQaaMZgYhiv0urteSQoMmkK8ninx0WkWsTyXslIUp6RRngwxZQaV/E kQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbp11t7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 20:00:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I5Vwb012059;
        Thu, 5 Jan 2023 20:00:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdf0vt0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 20:00:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZERlKLQHuteo1DQHfD8BCN372RZHuH7VYghe4HiPdM9QjjHx4ycHhKo/sf0rLW2cRAuJQvazMjAmjChvkZEUaQkMMb5IZj+ySjRk2eid3/3qEskW9E7xy+F3Ef7vSVaIRWwUbtEClOT7nKLMr92pM7u8OI9pHcOaRd2oC0+vE+kOeVrbe18XoC31A0s8qDcvPuA8KnJ6YNFkU+qx7non/XsZ16y7godUuVtDgncYbPNbkBC78BvlHjkxMm/rONfl6aq0cw3gU2A4yC95AXi/VSvbgvT7ebKJQhCz86Kwjzic3DgsFBBMDgKVycuaV2ww1UBw+XVpnQ6S9sp5RPoMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLUZsWADk9U9X4CaGHT/hGNvoQKKJ5CVfU+Hk0VfwjQ=;
 b=HsK0IAsszFeNQmSEOFFBuvg/5h1d41BIDOZIJAdbewg1OTqAZCr4aj6iYYKwmlp9beBttOZBP+NNl47yfjtdQKClZ6Mt2a+GDIRYvh8g32PNyAJs5t/er8TZy5ClG8GltfQvW54QjWcqHCw+hqrjrrXFxRWf/h3iwCQmOt5YluU1p6U+7fmw4KQJ21kdKosiYesUhZBgkwHwqn2V89NNCNmgBQZuuRYtHVWUn2pOEYa8xpwSryERzdb4tyXgwuIBxl2xveIl2JPY1bANADbbeYwzbV8xR5vKyqTMCRhWAtRvAnTFt+1rMeejTT7JaE/9f0FRqLrGF9fie2k8C8VR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLUZsWADk9U9X4CaGHT/hGNvoQKKJ5CVfU+Hk0VfwjQ=;
 b=bPED711kUO3+xSTPsAgcuMa2j7DISkZQgXVmr+30U+2y4JafSzn/w+sRLthgt38v8lXx9A9TascdJBvbkccuImTt6rxd+7SIygy7OdEOvouJbluNv0bmauRxEdJHAD6bh8sQ8wZXd4BhiUx5alauk2VnyfaPihJfgEmDD88PRm0=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BLAPR10MB4915.namprd10.prod.outlook.com (2603:10b6:208:330::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 20:00:10 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%7]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 20:00:10 +0000
Message-ID: <e46fdd1c-3a61-9849-e06a-f7df8dd78622@oracle.com>
Date:   Thu, 5 Jan 2023 12:00:07 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/1] NFSD: enhance inter-server copy cleanup
Content-Language: en-US
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
References: <1671411353-31165-1-git-send-email-dai.ngo@oracle.com>
 <28572446-B32A-461F-A9C1-E60F79B985D3@oracle.com>
 <CAN-5tyEL1FvvCMgg=NWrHcAvLdXFKZQ_p1T8gRhH9hUoD3jPhA@mail.gmail.com>
From:   dai.ngo@oracle.com
In-Reply-To: <CAN-5tyEL1FvvCMgg=NWrHcAvLdXFKZQ_p1T8gRhH9hUoD3jPhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::22) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|BLAPR10MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: 1707106d-8449-421f-96cb-08daef577381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lPhs4iram1hXLaiuyjcEhC9l3Cgm00H7AzkYMnGhs5je5n/fVZs0K1Oh/B1K+8ggbh7sRQBoUn/EOuUPCrSuU8AcAsDjde3SN+HVEtfHMajLNMiTGngWhOUCjQ810LDX9JCaqb2EcYR4TkMYwgryixrSgF7CVvkYXwHKNflLgQdX+juNcyc2N59tb+D/XJDFFVwwVI4drpz01yiHWWLayvPsK7J9q8Q7qqvlfYa+zVHASQXeQNf4ijPrhuiIJ3tlXiHDlTUD5IBNbKxx8C+kFAN47+m5Dzfw4jeRiF5aF1YOfkd6ErfFNq5uB/ivn6IFaeVddDmzEwi2RoKAIUOxOsin3JhxWZuAeEeSWZ7F48Aj2a5jJzKJ/gZOd2HG3zEzaj2D+TNtK/yE2ACgTFsDM4TGEM+qyjH+JbdqCfyFtErbBeBzTEc5It+XESchrwLBk8A7/zNJPfgFvwdBSqI+ukgDqpi87GR71SEueYuH9ND+2OCqEbysuyjwvq/bQygHv6Bb5OsKZc2kDy6zadJLkgcxltHLI8g7YApjXzn2vmofZGO/QEl4I+mg1Pd9SfN/Dh0huTuIKh8/3FhrX5AIubrgdSAbNP8MkaF8Jo9H5T58GI+tOmpuYqlVGbCMSKfEY61gOHjyMFx7tXey65Df1nFJuASZx2Q5cLi2ohdXdaaGVt0i/Ab7d9vIeDtzeg90
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199015)(83380400001)(66476007)(2616005)(31696002)(86362001)(8676002)(38100700002)(8936002)(36756003)(66556008)(54906003)(2906002)(4326008)(5660300002)(30864003)(107886003)(31686004)(66946007)(6916009)(316002)(6512007)(53546011)(6506007)(186003)(26005)(41300700001)(9686003)(6666004)(6486002)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGRyM0NNV09GM0RpVG4wS2lRSGxkcXFRZ2FOa0c2TFdhbi8reHlhVk0xaWph?=
 =?utf-8?B?K1hyZmpBUWJCYkVIZlBvZ2pZWWxmZFRvNXAzTWdhcjFRdzltRUEwMERhcjgx?=
 =?utf-8?B?enNVZmhpZks4eTlvNnFya1JPbEFLT0hjcnVkWEpWZW9DMHFjZlB6cFV6dEZh?=
 =?utf-8?B?TkllWGE5T1VPc1NMNG0rMmVteHFTRGdHYXBxczI5RWc4ZmkyVTBaRWcyVndS?=
 =?utf-8?B?bE9YOEFBQUpmVnhXMmRZSnBQSkNvRy9RMEtPNGRGdExrdENCR2NLTXdSZ0RN?=
 =?utf-8?B?MTJRZE1MR2NKRHhPOUZXdnJOaTZ2cGlSUGh1dHBydlpSQllXeHhNb01sSkYx?=
 =?utf-8?B?bUxMalMzY0xrNEd0NTJ1ckxFWGVXRVJ5ZVNhOUJVOERFMFkzQlZoQWxjblk4?=
 =?utf-8?B?aVFBVTBZaDU5alBlLzhJMFJ3UTNYSlJEQWhqQVpvdUdoRzl4TlF4TTlFZTBY?=
 =?utf-8?B?T3hJRVBoWFYraTFzN0pnMXE0OVlxdkRmRVl3NHEwM2dQVUlsaEF4aTduaTBX?=
 =?utf-8?B?QlNFOUsvTHRtV3hDUCtEa1ZFVjNiYXJTRDdSY2oyS3dveXFCZlhNMUhDYWRz?=
 =?utf-8?B?RHJPdXVoZndVdy9hL1ppR3l5ZE45WERJdTVIb3Z1TDhoL0p1cTd6NG9IR3Iv?=
 =?utf-8?B?RUVzWXgydXNURFJLY013Nm1HZ1RQdVRHd3RKSGVFMUVpeGF3bERSTHdOY2pj?=
 =?utf-8?B?L1I4Z3FWS2FTWG01bG01L2RycUNWQ1ZkSUpwK1NKaXNSQ2tuUnJzR0lhT3V1?=
 =?utf-8?B?TVhFb0FDamFkRzBMbE9FNTFYZWxJc1ZQcVF6NVBrUjYwTVRma20ySVhvL3lB?=
 =?utf-8?B?ci96SGZJdHF2dGFmYTNHZDRuVzRXSFZ1MFg4dHVXOWw5eEY4U1MyZ042QkRt?=
 =?utf-8?B?cjdIOTRnbjFYeVJQSmtOY2huMmxuRi9oV1hQQVh5cm5QWC8wa2JRQ2tvdVQ3?=
 =?utf-8?B?U3lpcVNnTERNbjBmdnQ2MmVRVkNXYUpjRFJLVDNrOU93R09XeHZCeVRtNnFz?=
 =?utf-8?B?TnFaNCtEdlZIU2dub2p2Umo5Z3RYMDdkK3FxaVJ3RXBMamZKdVlCYWJmK09O?=
 =?utf-8?B?eUczN2hhREJvd3FRNWZ4RlVRVzdFZ01DemVNbWJqN08wV2lnZXZTRzQ0cysx?=
 =?utf-8?B?d1MzNnBzRWFIRlJwcFI4QUxWZzNIVFFxdGJZUTd2SW8weEhSK0VtMHhQQ2Fa?=
 =?utf-8?B?eGxTNWtJT3NDRWpSdnkwRnM2cGFIVERNR2xNUGZCYWlKNkV0NjVBcllGV3Y5?=
 =?utf-8?B?ZWkyTUlFcUNwSlUxRzU2bVBBQjJkMnRVOUFxVk9zUkRub2NqcGZLZTlzVU1I?=
 =?utf-8?B?aHA5ajIrb0hLQnhFYWdLRVV6NGJFYkMrM0MwSUloY1NtbFB1WmRzV3J6MS9p?=
 =?utf-8?B?anFxRW13VStIZ012bjBrbG1PajNTZzhCaXZtNWZjSXJkMURQN1ZZSUxJUXcw?=
 =?utf-8?B?TnBFMklPMThveStPd2JEU2E5WWdvVUZTVGFtSmF5RzlGQURxa1pBNExsaU5W?=
 =?utf-8?B?U1ptbGhEY2Y3ZzhMeUFRNXhwQWpmOFBRWVM1UlNZejBvMzliK0tlSzNMc1JB?=
 =?utf-8?B?OGtzRGw3ZGd6SE5LZzRjbUt0TnROVGtWdFFVTlIrV3loZHpSVHZjWnBSejZl?=
 =?utf-8?B?aGZMR2dYYmFOU3dGQzViT0hTWnFuQytheDlkYVhjTnczWk1rMDBNRndtNnNz?=
 =?utf-8?B?VTQ0bnRERi9JK0xuMzhVV281WWNhZHNvL05ydVRHdXVhckhDemtQTVlpdlpM?=
 =?utf-8?B?SlA3WkdNVSs2QThXcFlJVmtzRnhZVjFPRS9oQnVNL2FtMTgrSTdYYWIzTkFs?=
 =?utf-8?B?dEVxNzNhVEN0MHlVcDJwNWo1eXp5MHcyQlYwSHU5cis5clJFNTFMazZNRjhz?=
 =?utf-8?B?cnJmNXZXeElPTWYxaERHTUllcWZwbStDQ3BCU0lyczlWbVNpQTNINlhBeGN0?=
 =?utf-8?B?T01oUGxWNmhpeVo0VHBxZHZjRkJvSnJvbkpHV2xsMW5aZ3ZYRjBDeHRrZmpM?=
 =?utf-8?B?TXMwa3hGN25sbWYwTkZEdlM1M0tQTmhnWUNYRWdoK3VjNmd6d3F6NnlRWHpU?=
 =?utf-8?B?S28wMWQ1R0hiamNVMTQ0blNBc0hIaUNaaUlSeHJYNk5ZcllNWWprcmVZNlRz?=
 =?utf-8?Q?CBnMZXG1INAgBHPnnQKmDjPkq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mf7qnP6bqf0O8/AxF40SErv1hjV4dgAxiB9+iZLgRQmCMj/zE7MJKkTbQ8kstKBveMQPyhVK0oUFEPIAHtkGXfgbknu6dekDCccEKmdHV77DlNsNN6DiH1Qp4sIPAh5Ru64P2hT+A8JdMtqOWglyYP7/YuqLlgBbPDAUeBkibZys8ecH9b3Qmk5Oh9tJaYg5fKba3RDX2IkSPdTTYa6QGtXhyVQJbcYjLu2vRRjwvw518i9DE5iSSNeLwwhLXPSZR5JJfQMFKX8FeAhUddLnHzCj3NuydHfpvWS+DmAo8Kd9+chghDrKbERVbYQD+ncFAcTNyz9GYitekI/saQ5yeB7xgDQuNDu+b0sNsxzI/X/RQwiKDPOOLY2+Er3KfB48Kfb64GWGV75lHTwUsYbdAtXyr06PWmeayD/I3Wg55s5tMKzvpwBKYUit4ZVgyNTehUGG/v7hF/B6SziShhLQsxyzrwralht331C+3vYz9Ywe7D3UihEr8CfQss12h5uGGIy1DZlXdQ+HxO7PLskxsGUkdo7eC1GaEqgtYMpMJEPAG1i4cY0UwQlR7ga10aMcKlnhW0lsa8DGtu9aX5Z9+sO6mMAZZwFzPVT0Y/7GscFlWRcJd+1skUc1AnL4OwqRdC5xsxyBi5QBQw6qJoTfSEwdzOWO9mqJXhE91IWaMnL82Pgg0/UDr5JvKvVOFOqsks7B9q5xMEN0X6Ul8E1XJQjq8I5PD2peP/aJWOv2OFc5FvmV4xQOhuaoSI+JkmOZql7t5FsMfkBDJJYc8XKkxUi945rXBCUB3A0whUaw0xcaiEbHEE3HcWppKfHcsWLW
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1707106d-8449-421f-96cb-08daef577381
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 20:00:10.7165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgtQJCuHJM8oPM2grnwcyVRl9gR7A2qQ6/W9+y6KFdiSmvLeCJHDTdMgaTahynkIAUfUEuVkoEnljEmvKpSh8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4915
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050157
X-Proofpoint-GUID: BYO7ZgkkBmy40lc4MQOZem25b8duvceT
X-Proofpoint-ORIG-GUID: BYO7ZgkkBmy40lc4MQOZem25b8duvceT
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga,

On 1/5/23 8:10 AM, Olga Kornievskaia wrote:
> On Tue, Jan 3, 2023 at 11:14 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>>
>>
>>> On Dec 18, 2022, at 7:55 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>
>>> Currently nfsd4_setup_inter_ssc returns the vfsmount of the source
>>> server's export when the mount completes. After the copy is done
>>> nfsd4_cleanup_inter_ssc is called with the vfsmount of the source
>>> server and it searches nfsd_ssc_mount_list for a matching entry
>>> to do the clean up.
>>>
>>> The problems with this approach are (1) the need to search the
>>> nfsd_ssc_mount_list and (2) the code has to handle the case where
>>> the matching entry is not found which looks ugly.
>>>
>>> The enhancement is instead of nfsd4_setup_inter_ssc returning the
>>> vfsmount, it returns the nfsd4_ssc_umount_item which has the
>>> vfsmount embedded in it. When nfsd4_cleanup_inter_ssc is called
>>> it's passed with the nfsd4_ssc_umount_item directly to do the
>>> clean up so no searching is needed and there is no need to handle
>>> the 'not found' case.
>>>
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>> V2: fix compile error when CONFIG_NFSD_V4_2_INTER_SSC not defined.
>>>     Reported by kernel test robot.
>> Hello Dai - I've looked at this, nothing to comment on so far. I
>> plan to go over it again sometime this week.
>>
>> I'd like to hear from others before applying it.
> I have looked at it and logically it seems ok to me.

Thank you for reviewing the patch.

>   I have tested it
> (sorta. i'm rarely able to finish). But I keep running into the other
> problem (nfsd4_state_shrinker_count soft lockup that's been already
> reported). I find it interesting that only my destination server hits
> the problem (but not the source server). I don't believe this patch
> has anything to do with this problem, but I found it interesting that
> ssc testing seems to trigger it 100%.

It's strange that you and Mike keep having this problem, I've been trying
to reproduce the problem using Mike's procedure with no success.

 From Mike's report it seems that the struct delayed_work, part of the
nfsd_net, was freed when nfsd4_state_shrinker_count was called. I'm trying
to see why this could happen. Currently we call unregister_shrinker from
nfsd_exit_net. Perhaps there is another path that the nfsd_net can be
freed?

Can you share your test procedure so I can try?

Thanks,
-Dai

>
>
>
>
>
>
>
>
>
>
>>> fs/nfsd/nfs4proc.c      | 94 +++++++++++++++++++------------------------------
>>> fs/nfsd/xdr4.h          |  2 +-
>>> include/linux/nfs_ssc.h |  2 +-
>>> 3 files changed, 38 insertions(+), 60 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index b79ee65ae016..6515b00520bc 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -1295,15 +1295,15 @@ extern void nfs_sb_deactive(struct super_block *sb);
>>>   * setup a work entry in the ssc delayed unmount list.
>>>   */
>>> static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
>>> -             struct nfsd4_ssc_umount_item **retwork, struct vfsmount **ss_mnt)
>>> +             struct nfsd4_ssc_umount_item **nsui)
>>> {
>>>        struct nfsd4_ssc_umount_item *ni = NULL;
>>>        struct nfsd4_ssc_umount_item *work = NULL;
>>>        struct nfsd4_ssc_umount_item *tmp;
>>>        DEFINE_WAIT(wait);
>>> +     __be32 status = 0;
>>>
>>> -     *ss_mnt = NULL;
>>> -     *retwork = NULL;
>>> +     *nsui = NULL;
>>>        work = kzalloc(sizeof(*work), GFP_KERNEL);
>>> try_again:
>>>        spin_lock(&nn->nfsd_ssc_lock);
>>> @@ -1326,12 +1326,12 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
>>>                        finish_wait(&nn->nfsd_ssc_waitq, &wait);
>>>                        goto try_again;
>>>                }
>>> -             *ss_mnt = ni->nsui_vfsmount;
>>> +             *nsui = ni;
>>>                refcount_inc(&ni->nsui_refcnt);
>>>                spin_unlock(&nn->nfsd_ssc_lock);
>>>                kfree(work);
>>>
>>> -             /* return vfsmount in ss_mnt */
>>> +             /* return vfsmount in (*nsui)->nsui_vfsmount */
>>>                return 0;
>>>        }
>>>        if (work) {
>>> @@ -1339,10 +1339,11 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
>>>                refcount_set(&work->nsui_refcnt, 2);
>>>                work->nsui_busy = true;
>>>                list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);
>>> -             *retwork = work;
>>> -     }
>>> +             *nsui = work;
>>> +     } else
>>> +             status = nfserr_resource;
>>>        spin_unlock(&nn->nfsd_ssc_lock);
>>> -     return 0;
>>> +     return status;
>>> }
>>>
>>> static void nfsd4_ssc_update_dul_work(struct nfsd_net *nn,
>>> @@ -1371,7 +1372,7 @@ static void nfsd4_ssc_cancel_dul_work(struct nfsd_net *nn,
>>>   */
>>> static __be32
>>> nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>> -                    struct vfsmount **mount)
>>> +                     struct nfsd4_ssc_umount_item **nsui)
>>> {
>>>        struct file_system_type *type;
>>>        struct vfsmount *ss_mnt;
>>> @@ -1382,7 +1383,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>        char *ipaddr, *dev_name, *raw_data;
>>>        int len, raw_len;
>>>        __be32 status = nfserr_inval;
>>> -     struct nfsd4_ssc_umount_item *work = NULL;
>>>        struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>>>
>>>        naddr = &nss->u.nl4_addr;
>>> @@ -1390,6 +1390,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>                                         naddr->addr_len,
>>>                                         (struct sockaddr *)&tmp_addr,
>>>                                         sizeof(tmp_addr));
>>> +     *nsui = NULL;
>>>        if (tmp_addrlen == 0)
>>>                goto out_err;
>>>
>>> @@ -1432,10 +1433,10 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>                goto out_free_rawdata;
>>>        snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
>>>
>>> -     status = nfsd4_ssc_setup_dul(nn, ipaddr, &work, &ss_mnt);
>>> +     status = nfsd4_ssc_setup_dul(nn, ipaddr, nsui);
>>>        if (status)
>>>                goto out_free_devname;
>>> -     if (ss_mnt)
>>> +     if ((*nsui)->nsui_vfsmount)
>>>                goto out_done;
>>>
>>>        /* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
>>> @@ -1443,15 +1444,12 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>        module_put(type->owner);
>>>        if (IS_ERR(ss_mnt)) {
>>>                status = nfserr_nodev;
>>> -             if (work)
>>> -                     nfsd4_ssc_cancel_dul_work(nn, work);
>>> +             nfsd4_ssc_cancel_dul_work(nn, *nsui);
>>>                goto out_free_devname;
>>>        }
>>> -     if (work)
>>> -             nfsd4_ssc_update_dul_work(nn, work, ss_mnt);
>>> +     nfsd4_ssc_update_dul_work(nn, *nsui, ss_mnt);
>>> out_done:
>>>        status = 0;
>>> -     *mount = ss_mnt;
>>>
>>> out_free_devname:
>>>        kfree(dev_name);
>>> @@ -1474,8 +1472,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>   */
>>> static __be32
>>> nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>>> -                   struct nfsd4_compound_state *cstate,
>>> -                   struct nfsd4_copy *copy, struct vfsmount **mount)
>>> +             struct nfsd4_compound_state *cstate, struct nfsd4_copy *copy)
>>> {
>>>        struct svc_fh *s_fh = NULL;
>>>        stateid_t *s_stid = &copy->cp_src_stateid;
>>> @@ -1488,7 +1485,8 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>>>        if (status)
>>>                goto out;
>>>
>>> -     status = nfsd4_interssc_connect(copy->cp_src, rqstp, mount);
>>> +     status = nfsd4_interssc_connect(copy->cp_src, rqstp,
>>> +                             &copy->ss_nsui);
>>>        if (status)
>>>                goto out;
>>>
>>> @@ -1506,61 +1504,42 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>>> }
>>>
>>> static void
>>> -nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
>>> +nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *ni, struct file *filp,
>>>                        struct nfsd_file *dst)
>>> {
>>> -     bool found = false;
>>>        long timeout;
>>> -     struct nfsd4_ssc_umount_item *tmp;
>>> -     struct nfsd4_ssc_umount_item *ni = NULL;
>>>        struct nfsd_net *nn = net_generic(dst->nf_net, nfsd_net_id);
>>>
>>>        nfs42_ssc_close(filp);
>>>        nfsd_file_put(dst);
>>>        fput(filp);
>>>
>>> -     if (!nn) {
>>> -             mntput(ss_mnt);
>>> -             return;
>>> -     }
>>>        spin_lock(&nn->nfsd_ssc_lock);
>>>        timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>>> -     list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
>>> -             if (ni->nsui_vfsmount->mnt_sb == ss_mnt->mnt_sb) {
>>> -                     list_del(&ni->nsui_list);
>>> -                     /*
>>> -                      * vfsmount can be shared by multiple exports,
>>> -                      * decrement refcnt. If the count drops to 1 it
>>> -                      * will be unmounted when nsui_expire expires.
>>> -                      */
>>> -                     refcount_dec(&ni->nsui_refcnt);
>>> -                     ni->nsui_expire = jiffies + timeout;
>>> -                     list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount_list);
>>> -                     found = true;
>>> -                     break;
>>> -             }
>>> -     }
>>> +     list_del(&ni->nsui_list);
>>> +     /*
>>> +      * vfsmount can be shared by multiple exports,
>>> +      * decrement refcnt. If the count drops to 1 it
>>> +      * will be unmounted when nsui_expire expires.
>>> +      */
>>> +     refcount_dec(&ni->nsui_refcnt);
>>> +     ni->nsui_expire = jiffies + timeout;
>>> +     list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount_list);
>>>        spin_unlock(&nn->nfsd_ssc_lock);
>>> -     if (!found) {
>>> -             mntput(ss_mnt);
>>> -             return;
>>> -     }
>>> }
>>>
>>> #else /* CONFIG_NFSD_V4_2_INTER_SSC */
>>>
>>> static __be32
>>> nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>>> -                   struct nfsd4_compound_state *cstate,
>>> -                   struct nfsd4_copy *copy,
>>> -                   struct vfsmount **mount)
>>> +                     struct nfsd4_compound_state *cstate,
>>> +                     struct nfsd4_copy *copy)
>>> {
>>> -     *mount = NULL;
>>>        return nfserr_inval;
>>> }
>>>
>>> static void
>>> -nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
>>> +nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *ni, struct file *filp,
>>>                        struct nfsd_file *dst)
>>> {
>>> }
>>> @@ -1700,7 +1679,7 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
>>>        memcpy(dst->cp_src, src->cp_src, sizeof(struct nl4_server));
>>>        memcpy(&dst->stateid, &src->stateid, sizeof(src->stateid));
>>>        memcpy(&dst->c_fh, &src->c_fh, sizeof(src->c_fh));
>>> -     dst->ss_mnt = src->ss_mnt;
>>> +     dst->ss_nsui = src->ss_nsui;
>>> }
>>>
>>> static void cleanup_async_copy(struct nfsd4_copy *copy)
>>> @@ -1749,8 +1728,8 @@ static int nfsd4_do_async_copy(void *data)
>>>        if (nfsd4_ssc_is_inter(copy)) {
>>>                struct file *filp;
>>>
>>> -             filp = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
>>> -                                   &copy->stateid);
>>> +             filp = nfs42_ssc_open(copy->ss_nsui->nsui_vfsmount,
>>> +                             &copy->c_fh, &copy->stateid);
>>>                if (IS_ERR(filp)) {
>>>                        switch (PTR_ERR(filp)) {
>>>                        case -EBADF:
>>> @@ -1764,7 +1743,7 @@ static int nfsd4_do_async_copy(void *data)
>>>                }
>>>                nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
>>>                                       false);
>>> -             nfsd4_cleanup_inter_ssc(copy->ss_mnt, filp, copy->nf_dst);
>>> +             nfsd4_cleanup_inter_ssc(copy->ss_nsui, filp, copy->nf_dst);
>>>        } else {
>>>                nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
>>>                                       copy->nf_dst->nf_file, false);
>>> @@ -1790,8 +1769,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>                        status = nfserr_notsupp;
>>>                        goto out;
>>>                }
>>> -             status = nfsd4_setup_inter_ssc(rqstp, cstate, copy,
>>> -                             &copy->ss_mnt);
>>> +             status = nfsd4_setup_inter_ssc(rqstp, cstate, copy);
>>>                if (status)
>>>                        return nfserr_offload_denied;
>>>        } else {
>>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>>> index 0eb00105d845..36c3340c1d54 100644
>>> --- a/fs/nfsd/xdr4.h
>>> +++ b/fs/nfsd/xdr4.h
>>> @@ -571,7 +571,7 @@ struct nfsd4_copy {
>>>        struct task_struct      *copy_task;
>>>        refcount_t              refcount;
>>>
>>> -     struct vfsmount         *ss_mnt;
>>> +     struct nfsd4_ssc_umount_item *ss_nsui;
>>>        struct nfs_fh           c_fh;
>>>        nfs4_stateid            stateid;
>>> };
>>> diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
>>> index 75843c00f326..22265b1ff080 100644
>>> --- a/include/linux/nfs_ssc.h
>>> +++ b/include/linux/nfs_ssc.h
>>> @@ -53,6 +53,7 @@ static inline void nfs42_ssc_close(struct file *filep)
>>>        if (nfs_ssc_client_tbl.ssc_nfs4_ops)
>>>                (*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
>>> }
>>> +#endif
>>>
>>> struct nfsd4_ssc_umount_item {
>>>        struct list_head nsui_list;
>>> @@ -66,7 +67,6 @@ struct nfsd4_ssc_umount_item {
>>>        struct vfsmount *nsui_vfsmount;
>>>        char nsui_ipaddr[RPC_MAX_ADDRBUFLEN + 1];
>>> };
>>> -#endif
>>>
>>> /*
>>>   * NFS_FS
>>> --
>>> 2.9.5
>>>
>> --
>> Chuck Lever
>>
>>
>>
