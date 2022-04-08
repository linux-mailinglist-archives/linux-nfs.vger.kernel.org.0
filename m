Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDB84F9E83
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Apr 2022 23:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbiDHVDO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Apr 2022 17:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbiDHVDN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Apr 2022 17:03:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBF95AEE2
        for <linux-nfs@vger.kernel.org>; Fri,  8 Apr 2022 14:01:05 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238I0wMe004957;
        Fri, 8 Apr 2022 21:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KcSM5gRfJ0SkPPW3MMzMj9xy4hkXDBsL9UGgfSq+ftA=;
 b=yMFi5I1acWQaB0HW64VvPOOn2XJcs3IIOBWnDRLMsEFbK+BEdgOWYN+/PczC4/YvqTYe
 g7Y/P07Gj7CSSYAQqRMeTuA+GCcH4vBpanuFENmnJhclpqzfje7+geyZOSdEISEcK6vc
 DJXTi0WQaW6R46J2izYCSMxe/76af4xk/6nFMbYVAINHQxp1von8J2SqsSYbHyWWrBCH
 2wTzJBGxpF2USesTWDA500o4Aak68I4uCiMyxwfcA4i6BZDCsR6dhRbXtqh/jwMN+iRN
 gwKmgB8OOr+3BvBsHPA//PwtiennMgYHpC9jU/73CzrgZGd/p/mlB12mP+T1rbTfOkyJ ew== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d9387jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 21:01:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 238L0kKt020218;
        Fri, 8 Apr 2022 21:01:02 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9805r0nt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 21:01:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORVi9yKTYUMIVv742vso7WR+GIYdF/HYfunscj3IcDScl69+uwyVW3mL2cOicaUkBAb+ZJBgoMrhekIeIlia5AEndOEM9YIbV5V52kJe6rquaI07981MUi2UCx6NQyaF9UwW1wWq9yAIZfJNb9MqESG8vi/mDbWz1clHUV4qPHVxBJaM0PDAA93qfh/4zPJrQM49ONc1Ywe/cockQWlUjIKR9CoCqQZG7VixTNwP577hvimGTlZzthZJvaygcexb6im+A5RuEIGyq4sjHASsldTVrcNqW8tJ9Bn991yMi+oRV/LNMtUwqrYbZgGzNr4rVRi/edqndvyD9jtVSZFaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcSM5gRfJ0SkPPW3MMzMj9xy4hkXDBsL9UGgfSq+ftA=;
 b=S0mIQekYuRzXixKZOzPgHU/hN4gOtGHEVR3UbcpJzk2Fx6gw9G7zdO/uFDKQp+bucoi/CZxEQw5NW6opZSnT2MRkLY56GTnwyVlCn81ACWGhh/tJbmNSx2JB6R1G1vDm21TFqpdLSYF1v2hx2henv4/BNtrE+YbJqGo1DtROBoxsnXj5e3VEI8fElRH9IXhRVciCeJug9KSFjJ77xf1//aLWbgCAMx18F49v0GuHZVMExP+rXT7A+AdmUJXxV6vyerAovoTMAkC8o9Rl39cb/aK86VmTMj3RquDeFTzobsNQrst3n3va0q12pubUF9idYSIz0H5qTPVUUuigMf4puQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcSM5gRfJ0SkPPW3MMzMj9xy4hkXDBsL9UGgfSq+ftA=;
 b=uH05qZ958Cm4IJxdzW+xEYGxiKbW8dLpE7VFVswRa9PK3lsRN7lGj/QHUFkxMhL4vtn8SOBhU5Tw4R3LhwFFEs8RILUG/sljjnxGNkwwugyUY58fpSLRgkdeRJoweAjZXZtldzajIPd9OOsibXYfFHX+mLji49vHColTnnwUxHM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN6PR1001MB2291.namprd10.prod.outlook.com (2603:10b6:405:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Fri, 8 Apr
 2022 21:00:58 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::856b:6a4a:7f60:df74]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::856b:6a4a:7f60:df74%7]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 21:00:58 +0000
Message-ID: <b60da517-1179-1588-ee11-a9c60400da4a@oracle.com>
Date:   Fri, 8 Apr 2022 14:00:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v20 09/10] NFSD: Update laundromat to handle courtesy
 client
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
References: <1649285133-16765-1-git-send-email-dai.ngo@oracle.com>
 <1649285133-16765-10-git-send-email-dai.ngo@oracle.com>
 <20220408163135.GA6423@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220408163135.GA6423@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:5:80::43) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 368b68f9-70a3-4d76-b8b8-08da19a2e17b
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2291:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB229198CEACE6AEDCC47ACD3887E99@BN6PR1001MB2291.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aLxuyHHzIG2NbOF/ALxN9RGrj6wNhYDOI8XP/VToeBmzN0E9tOrgtZluHeMm0SAkeKLfJ9joTCbEV31C9nGD9k1DkbkrYEqNnHvale7C0UnsG6K3BGXC0c8AcApJ+V6O+qHhFhdzFVfYhfJbwFCLTEg4qptWsNm8DBHLqVkbmfURhjBxwY1GkB0vHdFctt0F3/hk27Ki+p/szZP+F4npKtdXtFXceXFJyJOYBrYdZew3uubobkZMd5RfbXjWIxUSgbg4TIcfZLxDnyChsmN22TcMK84a4B8duusWj9B2YRS2NP5C0CQSWSxN/3AI0pxe6vU0zl+Lrx64G75wMxe+F4RwS+I7qWK8DexGzPLLONFZQV1jzUk0h61vfmPlpJ6ZOs4Dx5W5ZEEHWL09F4iMABGxQyn5f4rbYOMH55CydAvNp8w5gguDZaanOaz6kx+W4tYtiO/xpeRtrziPHj8Yd+D8DtcqvL+qWOlWlVguzLeiryyXSnA5Vg6o0a5mWZei61ZyU4eL4kpJyKU10IaVYi+7x2bvoTKSPlOP1R/tHlY6Kz+3TX3fvCtUuKmYwK7e8c9rBr0bFWST2w9YSphKpiJUmAK61oC8GmSkwirUKn+q/+2TxRn4eoa00rnRvPlcPkZ3JdlAAT4XXlr/U/Jqn8zscSJjnuosioAokiYot//9LQVTVMPdk8RIJF5BwfQPYnFKBM9JwYFXtZ1gc18wIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(66476007)(66556008)(4326008)(8676002)(36756003)(53546011)(5660300002)(86362001)(66946007)(83380400001)(2616005)(31696002)(6512007)(26005)(186003)(6506007)(9686003)(38100700002)(6916009)(8936002)(31686004)(6486002)(6666004)(316002)(508600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmF0YWJtREF6aXFFYXRlSnVvZmgxbUF5ZWYzY2RQMS9XQmVnZXF1YkNXMUZp?=
 =?utf-8?B?TmMyZFV5eXlma01QSGRhMnZjRHdkVUxyazRWdXRubWtHaC81NXkvd3RNYXRY?=
 =?utf-8?B?UjJSQ2hYWC9lYTA4TklWUkJGZWk0VEd1TEtNRmxva2FGVExBK0Zwdkw2a1FG?=
 =?utf-8?B?UFZsM0JmNzU2WUZPcjFYVUprZ2UxblQ5OE9rTVZNa2ljZ24xR1RoSk9PbUF3?=
 =?utf-8?B?VmtFb2lFMVZqbjBWZ1hpd3lxai92dFVaSEdpbjZ1VGp3RjNLY0NxMXRIV0d3?=
 =?utf-8?B?enJKaHVBdjYrRXJIbFdyNUQvai9CbGlVc1FON1RtRzFXRlRuakJCNU9aRlRl?=
 =?utf-8?B?eXo1WVFJcU9maUF4RU4wT2xha0hzZkRmTCtEZ2lXVGlZeXMwQUMxSHNCUXlW?=
 =?utf-8?B?UWh3ZmFGMHdvT0JyRkhxUXFmMy9mZVdmcGFyYWoraUFIcjZrc01qMlF0QWJx?=
 =?utf-8?B?eTMyZ0l4VEJKamF1WXFWUnNYUnAwNHVVa0drd2M0d0REKyt6UERVZGVDeGxk?=
 =?utf-8?B?Zyt5eEtiR29NbEdTcjg2czBIVy9oQmk5Yjd6RGxENm9VSXZabFh2UEx3bTNy?=
 =?utf-8?B?cjR4WjhnUk0wcVk1N2JYejJFUU1JSkRBTDRUTXZmbUt2QVJDMFpuMEhhQnNN?=
 =?utf-8?B?RkJaSkdtczRhQXA1RkZ1R0pSMmhBMGFpZjRHemtWZXZyRmtNQkZ4UCs1Z3J0?=
 =?utf-8?B?aTFoR1VMdjFNVVU3d1dwSzNNSDdQcXAxV2tVdmszQlA2eThjSThDckY4aGJn?=
 =?utf-8?B?aFUzV1NERHFJamFJMXI2NEVCdW00YnpNK0M2V083NUU3RUVXNTcyRVlFSExT?=
 =?utf-8?B?SStaRTlES0FEQ0lGUElHR0wyMmpaaFFvVk1WTmpKaHNscXl0bHQxVmlLRngz?=
 =?utf-8?B?TDk0TXlXMUlaUkNORDg1L1U0N1NmQWkwVFRLbWpad0hhbUVkbXZsUmZPUTJp?=
 =?utf-8?B?UWYxeVIySWZRY0RNNWdvaE93NUMwTENjMlV1QU1wYk81K0FpOUZnaDBDbWd2?=
 =?utf-8?B?MzFWMmFTSURpbUVrY05qb25zb2g4SXo3RC8zakJWdkJ0cld3QlBJK0UwQ1c3?=
 =?utf-8?B?OVZLMUNSSEVYeVV5aHNCVzdmNlRTRHRBd2haNnA4Mk84VGRQZk1jS0pROFNl?=
 =?utf-8?B?dGM0QWlOQS9pSnhlUFdaNjhrMkJQRXFQWitZbVpHVjlOVXlzcWpiNkt3dEFE?=
 =?utf-8?B?NDFreGVNNDZDeEZRV1liQm45VTFKdGdBWStMVmg1R2lCd2NtSnFxK1AwZHBL?=
 =?utf-8?B?UzBHZEN2cVZYUzdjUWxkakt6Nm9Gc01iaTVGbXUwWEVSKzRZL2JMK0pxTmJm?=
 =?utf-8?B?NFVyQll2N0NLaGYwRnlFc002OUROSDh1RWNTNXVEOWI4bWlFWXZBMTg3UFFr?=
 =?utf-8?B?U25ybVYyb2NwTVFwdm5rTWJCTmlLeVB3VlNQZ2RQV3VQNG1KWHlMaURBMnZj?=
 =?utf-8?B?WG5zSnpsdnF1eE5maURvRzAvNjg1VHVpMFltN0NUdEVFYktabnZZMEZaNk9T?=
 =?utf-8?B?c2cxVjBHeisrL0VGNVNXeWVBak1lNmMrakIyRy9RaXB3R0RiNzNIRmZJT09j?=
 =?utf-8?B?MUVJVTV5Q1pwN1FoSHAyTmxaTzVqNlk4M2pmV0pDMUNxTStxVHVXMFBZTVpJ?=
 =?utf-8?B?NUtmTm85QmRGMmxOWncyekVxaC81NVZVdFBWVVVZS0dma09SUzVZRFZGS0Zq?=
 =?utf-8?B?dkRCWCtaSlpQTGhkekxtcjdWTHRYdXZycTQvQm5KVm9KT2FvRks4UEd2YVp1?=
 =?utf-8?B?d1hGNEM5cWl5U1BrczUrc1FjV052b1lOVjdBTFBvY2R4UXpET24zL0w4U1Ri?=
 =?utf-8?B?dzlkd0ErZ1gzZktnWk9ma1pLU0p6eGtuUWxJZnp1MHMrLzdxTHE3RFdsWHJ1?=
 =?utf-8?B?L3JoaVZ3M1B5Z2lhUG41SmxSWDJpb0lHM0dPV0ljNzkyWEZ4SldwUCtiRUhF?=
 =?utf-8?B?SzdGVE5vWmVXNHpvZXoySy93T01hVDVPaERBakJwUXVOTml1UkQ4Q0Q0N0Q2?=
 =?utf-8?B?bXRPY1cyUmJMMVBpMUhsamx3QXpydkJLblpKMUpoK0tsdnVuKzQwVE1sem4z?=
 =?utf-8?B?SDc5VUNlNmEvbEFxOHpzRDltcUkySlJPUUNXR2VxNWxPQXNnTXpGSzdtc081?=
 =?utf-8?B?UjVaTkhUMWpucEZkMk8va1ZNUklJOURzS1RzNXhKRlJmYnNtM3MzUFowbnVp?=
 =?utf-8?B?cGpPb0NEZmU0ZGl0WlBwelE5L21HNlFKTUZFTmlnL0t5S3hMYUtTYmk1Q3hT?=
 =?utf-8?B?ZExrNFFYYjlFT0tYQ0VwTVR1aVFIdk9ETFJValBUQUJ6dnVUa2lLc1NxSjNt?=
 =?utf-8?B?WU4vcFBRMWs0bjk1cHlteGRMMWgzZklOeGJsVlk4RGY5eW9IN0xIUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368b68f9-70a3-4d76-b8b8-08da19a2e17b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 21:00:58.6143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LAGk9lI+b67J9x6tKsQXURMkLlaJvqakA6B3wjkMKvAxEQeJXS7Zn0wygjeqgSDWr+K+ztr85p+KheWU3f3ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2291
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-08_08:2022-04-08,2022-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204080107
X-Proofpoint-ORIG-GUID: _NQv6va7OvOKUm0C8QLdwmKss3zZi2YT
X-Proofpoint-GUID: _NQv6va7OvOKUm0C8QLdwmKss3zZi2YT
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/8/22 9:31 AM, J. Bruce Fields wrote:
> On Wed, Apr 06, 2022 at 03:45:32PM -0700, Dai Ngo wrote:
>>   static void
>>   nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>>   				struct laundry_time *lt)
>>   {
>>   	struct list_head *pos, *next;
>>   	struct nfs4_client *clp;
>> +	bool cour;
>> +	struct list_head cslist;
>>   
>>   	INIT_LIST_HEAD(reaplist);
>> +	INIT_LIST_HEAD(&cslist);
>>   	spin_lock(&nn->client_lock);
>>   	list_for_each_safe(pos, next, &nn->client_lru) {
>>   		clp = list_entry(pos, struct nfs4_client, cl_lru);
>>   		if (!state_expired(lt, clp->cl_time))
>>   			break;
>> -		if (mark_client_expired_locked(clp))
>> +
>> +		if (!client_has_state(clp))
>> +			goto exp_client;
>> +
>> +		if (clp->cl_cs_client_state == NFSD4_CLIENT_EXPIRED)
>> +			goto exp_client;
>> +		cour = (clp->cl_cs_client_state == NFSD4_CLIENT_COURTESY);
>> +		if (cour && ktime_get_boottime_seconds() >=
>> +				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
>> +			goto exp_client;
>> +		if (nfs4_anylock_blockers(clp)) {
>> +exp_client:
>> +			if (mark_client_expired_locked(clp))
>> +				continue;
>> +			list_add(&clp->cl_lru, reaplist);
>>   			continue;
>> -		list_add(&clp->cl_lru, reaplist);
>> +		}
>> +		if (!cour) {
>> +			spin_lock(&clp->cl_cs_lock);
>> +			clp->cl_cs_client_state = NFSD4_CLIENT_COURTESY;
>> +			spin_unlock(&clp->cl_cs_lock);
>> +			list_add(&clp->cl_cs_list, &cslist);
>> +		}
>>   	}
>>   	spin_unlock(&nn->client_lock);
>> +
>> +	while (!list_empty(&cslist)) {
>> +		clp = list_first_entry(&cslist, struct nfs4_client, cl_cs_list);
>> +		list_del_init(&clp->cl_cs_list);
>> +		spin_lock(&clp->cl_cs_lock);
>> +		/*
>> +		 * Client might have re-connected. Make sure it's
>> +		 * still in courtesy state before removing its record.
>> +		 */
> Good to be careful, but, then....
>
>> +		if (clp->cl_cs_client_state != NFSD4_CLIENT_COURTESY) {
>> +			spin_unlock(&clp->cl_cs_lock);
>> +			continue;
>> +		}
>> +		spin_unlock(&clp->cl_cs_lock);
> .... I'm not seeing what prevents a client from reconnecting right here,
> after we drop cl_cs_lock but before we call
> nfsd4_client_record_remove().

Thanks Bruce for pointing this out. I will fix it with a wait lock
in the next patch. This seems heavy but I have not been able to
fix it without the wait lock. This is should be a rare condition so
it would not cause much overhead.

>
>> +		nfsd4_client_record_remove(clp);
>> +	}
>>   }
>>   
>>   static time64_t
>> @@ -5794,6 +5876,13 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
>>   		if (!state_expired(&lt, dp->dl_time))
>>   			break;
>> +		spin_lock(&clp->cl_cs_lock);
>> +		if (clp->cl_cs_client_state == NFSD4_CLIENT_COURTESY) {
>> +			clp->cl_cs_client_state = NFSD4_CLIENT_EXPIRED;
>> +			spin_unlock(&clp->cl_cs_lock);
> In an earlier patch you set the client to EXPIRED as soon as we got a
> lease break,

I don't understand, we only set EXPIRED when we want to expire the
courtesy client.

> so isn't this unnecessary?

When the client is checked to see if it it can be in COURTESY_CLIENT
state, we did not check if there is any delegation recall callback is
pending, we only check for lock blockers) so that is why we check it
here and expire it.
Maybe I did not give the right answer since I'm not clear of the
question yet.

>
> I guess there could be a case like:
>
> 	1. lease break comes in
> 	2. client fails to renew, transitions to courtesy
> 	3. delegation callback times out
>
> though it'd seem better to catch that at step 2 if we can.

I will wait for the above issue to be resolved first to better
understand your concern here.

Thanks,
-Dai

> --b.
>
>> +			continue;
>> +		}
>> +		spin_unlock(&clp->cl_cs_lock);
>>   		WARN_ON(!unhash_delegation_locked(dp));
>>   		list_add(&dp->dl_recall_lru, &reaplist);
>>   	}
>> -- 
>> 2.9.5
