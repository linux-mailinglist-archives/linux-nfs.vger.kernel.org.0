Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0BE5AA558
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Sep 2022 03:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiIBB4Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 21:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiIBB4X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 21:56:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6AEA286E
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 18:56:22 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281KRjWE030942;
        Fri, 2 Sep 2022 01:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Z29htRFKsZ+BLs5LGViIGYq9xHrJhGWC8tRgaBx6AAs=;
 b=vmwjqfjElApGkCkDE6omxxbs3J8UO1AY66Lhcm6jl5t8xqzFtrdOmUAKM55bPNZkR4F7
 Fjj1BJrv6aqsBzDBP/noO50BT+aVT9azettB5IbZ1erimoOAtJlONmHENREMdV+CRTpn
 ZgRrVESW7wxondslvHnzFLgTWzrUBJaEBPmsbRYrcjgZPSC2JPY5pbzNAGemY3XBHKjB
 CoCk30VmcqblGr3kzz4BLhD4t66FC9i576V4iC7thfu28p0YG6kEQ4f8vfl7VBFAJysM
 3/BcCR7wuVY30EftSwNwDaHp8DbuRQ7Ln1bUVI2jc7UaKF+GPyHVltlM0Hy7ukstQAWF 7Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7b5a5pud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 01:56:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2820TWKo027863;
        Fri, 2 Sep 2022 01:56:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q6v3ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 01:56:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LX6W0zNECTTZf6C3090V0VqR6IO/9LEwBF5SrhNzubEDSqpahEFiigG2Ou6OVTXcjtl8lZ/DklWi9CbslrO3KLKoVh2nXRBVhjV2LZ4llZx9TnqPGG0wBKLba84gkxqGdCkzM+iNrPenp6PgkRb1AvHv1D2zEDZ3tPaOmlKMsnpHuYblDNcsloQ0+vkfyWw2sIjB8j5p3HgkmULKbYlExfV+nLb8s9Nx3iw2QgzeA759XD6xprFGzO15HfHrG88p9l15fAWjYsgqw85e2KQ2uUaLfVKt0qifPtWkSIov61gjQvFA+sAoXMe5md/u5Fg0oMlGB1tUqusCoQaen1APBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z29htRFKsZ+BLs5LGViIGYq9xHrJhGWC8tRgaBx6AAs=;
 b=TesAG7G9cnM5S5w+DuTEmp1Zjl26/qdOEqT7hk+r4FoAdvVqRzhv8Hx/VT4sC6nghwucL9/gpsBQTQsn3rvOoXusO32ZNFBy2gGBwLGxOs+s6TkcLldD3Ipu9pKbUt6Jzvu+PEIbJSNnI54HO4l4f9pTpp6MukekOzbtu3POSaJ0Sw8+omI1Xn2uYX2fw7Md2yut5PRt66jQi++N60FB7ltebF3UQvQPPNnGdV3j3SSuznnU6La0GNdlxRn1wvDkfrqBP3o4voszZlCbD96FS1jsh7AhYjmwVle9osaz20+7OUeQhrNQiB6MRIC/vamIER5q6fagYhBeCA2eWyKMdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z29htRFKsZ+BLs5LGViIGYq9xHrJhGWC8tRgaBx6AAs=;
 b=hxYyoHBBAP8/FuTwdi+2aUaOeG9jWUJKvzzjvXtXcwumD5lqunBKYgATORzEp6Zq9m5rkOLgONLgPkRGWsknnEiWh+SJIxQ06tPvJBKDCrBaTvM0lt0phmszVnQsN0nZ9mMH9U1ooklAPEnrvDxB7u7NPH4cNuMgYGdH3cY4wKg=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SA2PR10MB4585.namprd10.prod.outlook.com (2603:10b6:806:11c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Fri, 2 Sep
 2022 01:56:15 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::803:3bcf:a1ee:9e1c]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::803:3bcf:a1ee:9e1c%5]) with mapi id 15.20.5588.010; Fri, 2 Sep 2022
 01:56:15 +0000
Message-ID: <2df6f1fe-c8eb-d5a1-0a11-2fd965555a33@oracle.com>
Date:   Thu, 1 Sep 2022 18:56:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v4 2/2] NFSD: add shrinker to reap courtesy clients on low
 memory condition
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1661896113-8013-1-git-send-email-dai.ngo@oracle.com>
 <1661896113-8013-3-git-send-email-dai.ngo@oracle.com>
 <FA83E721-C874-4A47-87BA-54B13E0B12A3@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <FA83E721-C874-4A47-87BA-54B13E0B12A3@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:805:66::30) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3eb06967-d6ac-4c69-ea59-08da8c86520e
X-MS-TrafficTypeDiagnostic: SA2PR10MB4585:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jUf+uTxVTRyxa8r/eqiDwZsrybqkau/wDaBmIvpxOocrOP33pMOXA01dVKtvDWw3eBevq/uH9+8HKHOabJ5Eb0bU5J6RZ2Axn/G1e5U7aTf4GO+qRq99+HMOUMfTz5Z2WpojOux3wOozONGoAF/PG0anWRXy6wkv2OZwP3dNY+g2oCVRMNDbNtEDXkkD8K2PkhhokxjPHPGksrQF7CG3Ba9IQv0NlDgOuEPsrGBFeEew6hotp+zRWxsIXho5p054gJVks8+cI1pO019yEYjO8ZJ3zLK5kUAB0bmiJPqHkWU0sXqKAkeP3riYnG9IzYSOJ82gIpCckSMGPqDJwVUWUEGHHXh8Debw8U94vYSFtul3EhMBeJ3yKAEnUEMr9p/Kh2OxO4BUUUvXMNoWEorXFirCS1E1Qx8E2M36wDse0Pn5lCGER/4q9viR1tgAFv1M/b/vrLg3H8NlVmTqrTPI6715fH8v3dU4cWy+gv1fsV4U2n4t11rD9z8H8W2QZg2xtKDrdo5UjmCFDq52l6idbbSZ4YDJ72W/5LGttDZUENaI7ogLTY3HfUqqSkayQFvO4APl+UoXAL7HysBeJs9H7ZaHByAUJLed8rzsYC2RnJ6QxOIPns3M6l1WrkvyKqXsPihga7m4AnGf24Dhoa82Cv6CRlWMYQRKwGKWdjqp0HHOBglWXQt1spT4BZF0MUJjjWWKLWmZNrO07BTgudsYuA8SSLFPXfNLwlxYUQy89teDj9FPcjZxkNh2crl2mREh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(396003)(366004)(376002)(26005)(53546011)(9686003)(6512007)(2616005)(186003)(38100700002)(83380400001)(8936002)(5660300002)(6862004)(66476007)(66946007)(8676002)(66556008)(4326008)(36756003)(2906002)(4744005)(31696002)(478600001)(6486002)(6506007)(6666004)(41300700001)(31686004)(37006003)(54906003)(86362001)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnZ3bGkvRi82SUdiZWYvQTBDUXkzZFVhVEowOXF0RkNnLzNWSzVhcGo0a25H?=
 =?utf-8?B?UFhLTy91RkxNcTQ5V2NtK0toZTdLay9KclhROXFWdURxbGxOdVhualJUeG93?=
 =?utf-8?B?M0RRamg2amlvZ0hFZHBqS0w3NmlvTXdzbzF0RERqck9lbUFLZlZDTjRDeVlq?=
 =?utf-8?B?RE5iTENDa1dQZTFtMmtNQVJudEk4MUROazNqdjI5OUtDYnhyUHBJRzNuODhl?=
 =?utf-8?B?R25CTG9UZmRQbGtsUU4zVUFpSTVpVjNuek5CSFYralp6T2NHa3duTjJ2dWZk?=
 =?utf-8?B?aGhwWDAzWnVnVXpQc20xRTdmWkNZVitZVGJxNzNkaGVxa2hsbU92L3E1TlRy?=
 =?utf-8?B?SklYZVErbWVtYzFGTnpEZHBEQmJRQ09udmFGRXBhYytocXpGeVFyODlkOUg5?=
 =?utf-8?B?cGFuM0EwcXFKQVlpQ0JyR1ovd3JqM3RtTnIxK2RTTU4vMXl2UGttb1dUakk5?=
 =?utf-8?B?T3BwTi9CbExscTZPV2oyTkNBRmVRUnJVRmdjbWx0cC9RdXNBaXk0ZkpUeVE1?=
 =?utf-8?B?NjhRNzVjK1hsazBuVURYMXFQMDMvTjdUV1VTWWdWTWdKcUIwaXZxc2lsUWtk?=
 =?utf-8?B?Wjg2Vno0WDJ4MTZJN2xiWWdzL2c5S0NPQ1JycHRNN2ZXZHBuV242aEx3bUZp?=
 =?utf-8?B?aHA3WTFhOXpYbGFvRnhwcUhaQzBsZEJDa1VHb1lMRmMyMWZaL1dGUXR4TWVx?=
 =?utf-8?B?NnlCV3dqa1ZOUHZ0eHZwV3FHWnozYms1UzhUaSs3VTFCeGw1djl5bXBUTnA3?=
 =?utf-8?B?RWhpZnBBSzZZaUNFSTZCb2NoMEp3T3ZuNlh6MGpPSk5EczZUUjVTNFhGMVVx?=
 =?utf-8?B?OXN3Wkdqdlo1N0U4cFF0bVRQTGZwWEs2dlQvWkREVHo2YTZKQXp3V0lhMXFJ?=
 =?utf-8?B?ZStxSzNQNUlkZjJBVm1kSlZGNS9IVEQ5TXdLUktZM25vc0h2ZnQyK1o5K3Ro?=
 =?utf-8?B?cENvc1dqRWhqTy9vUlJlWk4xUUtYS09PRE1xREF0YWkxMXRwK3hFYnVqMXc4?=
 =?utf-8?B?U1BJMGJuaGk0QVBYVFdHSWJxenRsMmswUEhYNGhiU2hqWmxMcENIZUZVVEZm?=
 =?utf-8?B?cXNOV1ExUE8xTkxkM1RCcmVzVTA0eXQ1UWNjOHZIcmZiUHdaOXhFSmFwaTln?=
 =?utf-8?B?VkVJUmhZcWhGYmhQdnEraERoa0xINDVzYVZMNVhmSUdDWFdOcWJFSmZPbzFS?=
 =?utf-8?B?QzdSYTUwaE1QTWNVNzJHU0VGbGVSZVNXa0F3VHhRUTFQNDBESk9tWDZFOXZ6?=
 =?utf-8?B?Tk1qNldQcW9oeUp1V2dmT1dnOGo2dGtZcGtmM2p4SnhaN2Y5UTAvekE4OGgw?=
 =?utf-8?B?UjliTzk5SnBrd2pnQmJpTThoTVlzWFhIK2E4OTBRVEQxQ2N3cXhaeHJvbk5M?=
 =?utf-8?B?SG9RcHM5MFpKT3licDNQd3BpRjhjY1Exa3FzM1c0R1U1dXJGeDdCYWppaGdG?=
 =?utf-8?B?WlY2ZFN3RmxrSjVRaHVxL0JKVE1vOHVXTWdVbnREVmJ3M3MrbE9xbVhIeEtk?=
 =?utf-8?B?SEFPVytNRldvY1lNVUZhbWo2bUN5ZEs5TVlHQU54QnNwdDEvaktjTFRPdEsx?=
 =?utf-8?B?RzVNOGdPWWNXZTNHaWlnbGZtOWEwUWUvRmN5ZzI4bFJWZmEzY1hOcHdYdE8w?=
 =?utf-8?B?OFJtdGlNRyt5TnNibDlsZ2FyUFZMQVV4czh4QTUwTW9VMW0vNGpscTNXQVpT?=
 =?utf-8?B?MkdWNEV5dlltbUVtaUFFWHZrWUJPQVRIbDNPbUdiREdRa3ZGTzUvQithR2U3?=
 =?utf-8?B?enRzV0lSSmZmMnM2M1JDQ2hwdDVXTE5QenJpVmRiMVE4bS9RODlQMzVXV2M2?=
 =?utf-8?B?WEc4eDkvcUxPYWFUQkZVNWh6akg5dVpsWlh0MG5kMm15VnR3KzVWZytiQ3g3?=
 =?utf-8?B?K0ZGRVlNRk94MkphMVVFYjlvVlR4VzF5N04wVGcrS2gybzgzcFhQYmJmbzVO?=
 =?utf-8?B?YjFMZURRSk84SnVpTTJvTVN2NnlJcHVnQnlDSE9UZTYwRXpJTTVpYjBaWUNI?=
 =?utf-8?B?NHcvZTBUNFp2VVc4c3l0dm94YmpqRWNHeDh0Y3BoVnd0NWlhZVh3QlpwUTNX?=
 =?utf-8?B?bEdtNll3d3ZYR1E0TlRGYmpPR3pnVEdFUGxpZ1V0YXJxU216am1hdERUY1Fp?=
 =?utf-8?Q?a3qfIdEYOFRBxSGLKNxTTbWgK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb06967-d6ac-4c69-ea59-08da8c86520e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 01:56:15.7811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUffodk2ZEQfiE1hL00t2WZnVIqLPOKAAxYOTmbPanZLkFIjrfCWhScm9bT0dkiC3tSCrqHHxOZymqKxp7nKZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4585
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209020007
X-Proofpoint-ORIG-GUID: Gey5WWugZ8uSZC4I4EPQ96eFoSXRL5yg
X-Proofpoint-GUID: Gey5WWugZ8uSZC4I4EPQ96eFoSXRL5yg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

On 8/31/22 7:30 AM, Chuck Lever III wrote:
>> 	struct list_head *pos, *next;
>> 	struct nfs4_client *clp;
>>
>> -	maxreap = (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients) ?
>> -			NFSD_CLIENT_MAX_TRIM_PER_RUN : 0;
>> +	cb_cnt = atomic_read(&nn->nfsd_client_shrinker_cb_count);
>> +	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients ||
>> +							cb_cnt) {
>> +		maxreap = NFSD_CLIENT_MAX_TRIM_PER_RUN;
>> +		atomic_set(&nn->nfsd_client_shrinker_cb_count, 0);
>> +	}
> I'm not terribly happy with this, but I don't have a better suggestion
> at the moment. Let me think about it.

Do you have any suggestion to improve this, I want to incorporate it
before sending out v5?

Thanks,
-Dai

