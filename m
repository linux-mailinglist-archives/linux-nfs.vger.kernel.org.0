Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A525ABFF2
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Sep 2022 19:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiICRD1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Sep 2022 13:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiICRD0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Sep 2022 13:03:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31084DF24
        for <linux-nfs@vger.kernel.org>; Sat,  3 Sep 2022 10:03:24 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 283B5ImF008743;
        Sat, 3 Sep 2022 17:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+WGFYJ5eyIWIC6DY/U4kLdHrE7k3RAwR6sobHcLCt9w=;
 b=Wdwle30OKCM1DFVNN51afA4i/yaHqHJlffeC+6vvNd6WQui7vDdJNED+HUqW9NzLQp61
 lPn6t34uXobRkAJmmwKQTXVNangXgLxl4rR+1IAzAaeh5Q+jwUtA/PquaxTZQTeSdxS2
 GGfMSiqQM5dY/7diQL1d5rJScE+v10IOotheSQXwn4NdL7Q3jN1IgpHPAFQE7VeDPp7D
 1uX7L9Mb1VhueNcDlyNw1RbVHYAzTRZ8vr8nDznmVj5bA6+ztW72wtc9pcKEAHJlGSHD
 nMgAnuZM+vTsyrf0iSBGASPj0bK0/qklJGPd6bd5ZFQzTNp2m2CxVuVlGAekHB3VHZOU Tg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftgs33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Sep 2022 17:03:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2838Uax1017143;
        Sat, 3 Sep 2022 17:03:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc6tst8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Sep 2022 17:03:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvL4APnbTj4lbIJM6ver34dDKxISQr5SRarjmtJ3dGZdLL2LQIKMj/giyClOSW/xq5s29NyV9K+LtQtmAFm9INjkm/Ve7gbrG47yl4wgcLQbOghT33UzdI6EcDx+iho/Z9kRD1GZEC7aMkKq0bhfp6E9mH6DhFUXcmR0XXpFAqda4zcs+xT/QQawLOGsInfHbM/d0XkR306cVSM+sMC78PgMMcz8IO7AQT5eTMzH6P6To0+qvuxXOrJ6cc71dnQ+xkh54kWrHsuUggd3TbhUfTzicNo+WvfJaoQBIWmKhYcMt0l80R6w+PuNcfp/+MZPQX5EvY3rVwMW1hIfC3kD/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WGFYJ5eyIWIC6DY/U4kLdHrE7k3RAwR6sobHcLCt9w=;
 b=nFgZyj5TSuIrB3NgSb262qHVkr1Wvgy3EZUkic9w1ytfKmoy6DVmlcp3KYc2rYxXH/DkEE44V8JSG439RC7g1FISKJmvacacrf/upxtbFsfBwF3LPw2L56CyrBKVcSNCiiylt9bRTsgXPrwWJC2/My9IB5sh5XtQEgL6nLjBAqnminnRTg8E2gMQgOKJNw1mordW7VPWGDXdyGkeeVpDCtOLPGQnV/VIBKwgLtwb5CXFWibfV0QWqhsQzL8kwwR778lScBu5uChIRjQHxwi0C7AC74PZhxTxrdpFnkMHtIIu5eSbf1pcD3pu2zmzOQHjGWrbrzFkPYElQv053YB4Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WGFYJ5eyIWIC6DY/U4kLdHrE7k3RAwR6sobHcLCt9w=;
 b=eZUG82Grd+qZVw/TnTUJoU2dlQxmbiOLRlIWpPlzwk74Dq2a30aoYZiSXQNkgeoomfP8psksdAN11lFif9fYN3b7+D5nj6vzejfhlI7G1YB9xULbkhbJ0MmYu5CVGVvR02OtMzsYhXxfb5GfcXY/AKLO67tmz+8r3I4EgZHKkow=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB5786.namprd10.prod.outlook.com (2603:10b6:a03:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Sat, 3 Sep
 2022 17:03:17 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::803:3bcf:a1ee:9e1c]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::803:3bcf:a1ee:9e1c%5]) with mapi id 15.20.5588.010; Sat, 3 Sep 2022
 17:03:17 +0000
Message-ID: <2b9549f8-58ec-be8a-1b15-3a6d7751a04f@oracle.com>
Date:   Sat, 3 Sep 2022 10:03:14 -0700
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
 <2df6f1fe-c8eb-d5a1-0a11-2fd965555a33@oracle.com>
 <7041D47D-ECB3-497E-9174-96E9E36FFBDE@oracle.com>
 <eb197dde-8758-7ef4-8a7b-989273e09abc@oracle.com>
 <3CD64E7F-8E81-4B37-AAF3-499B47B25D19@oracle.com>
 <fc5a3aa7-af8e-656d-a16e-c07c201ec62a@oracle.com>
 <44A716C4-3904-424D-A5D6-CE46FC9145F0@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <44A716C4-3904-424D-A5D6-CE46FC9145F0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0079.namprd11.prod.outlook.com
 (2603:10b6:806:d2::24) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a57137f-a7fb-4782-49ca-08da8dce3215
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5786:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X6T5cOoCpk7GGxyLXoxgEymwya313yGzUVJsWt/8n5VqOb/JPWsME/G3LM2NYkVfyQ08rBxK546jIPNnIq/dpxHNIZHxMIxU96TYuZxIG7BaR3GArc+/9u8APyceZuN4lPqAbCPacLm5tJiXTd11lwl7cIil4jmO4ROmtYab+fTFZ9bzqIbEbtFtJFVMtm5L8A91IQ6PBXgpPeqoARgVdkChnuF+bN4fFIo8F28FHW6Z1rqkW2m54iDttlbUtlrgA165SwMbkTCfg+Llll5TMrRCkLi2sV5mQjMAL/tui4LlNMhzDNfaR69Uw8M7sGzXLGcLjtM8m/mxm3h49IVteA+cUQHz0yF3DfherUyuUH0HHUxWYtTA0Qpb5qAhX3JZkp6QAim9re78w778RSZv8X1ujwH7XyVgGQEp7X7DBQ3iJeO/Oj1LEQmNaxkIYBwnBiq0FvbW9tyAxUAc8ZfH/vMLLpbJzPGZa65iQVxjBYlyX+963y3B6e5SCvUAXKNGlqR/P2KhpWJuaYmRSnl8Rx7sNWzouNRAx3/u1XH4gmwMRKj5a6YMrNgkFPAOTNDTgc3nuQvCFWLmDcpNIU93MjZzyTvW5Vb0MXGtFsclalp2PdgNTKzbrICzkAUJdSSumv7eEUCQ/vnfSN9h0Dqz80O80hmM/JT05nbXL4KXYUstM58oAaFBwrywOIzMUydl2KQxHML4qWAu12KAAbrp1fLP9V6SJh0gyJByN/9zOBdnrRP7hubYOMutDBQbGLAn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(346002)(376002)(39860400002)(136003)(83380400001)(478600001)(186003)(2616005)(66946007)(4326008)(8676002)(66476007)(66556008)(6506007)(31686004)(36756003)(41300700001)(26005)(53546011)(6512007)(9686003)(6666004)(6486002)(86362001)(31696002)(37006003)(54906003)(45080400002)(2906002)(5660300002)(6862004)(8936002)(38100700002)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dy94RFVyZ2cyRlQvdVNrZnRMSlF5aEJ2QnJaSWNYbC9ZL201d08xSWJpT0I3?=
 =?utf-8?B?TzhxYXYzL3lEVmxucXlBTGZnZVlVZlFIbkVCYzU0d00vWVNheGNaMEk0WEV1?=
 =?utf-8?B?ZG8zVGdvYlhPRzlJQVVYQStoWVZpK2VrTnphL0xMdXB6TTNLS0Y2NVlmT3o5?=
 =?utf-8?B?NnBEMkV5V3g1ZTBDSFNsRUV1ZnpRdm5mcGNJdDV0WnF6VldKVEhkL2xmcTVN?=
 =?utf-8?B?VDFUd25tLzM5eFF0Nndhd2VWalF0TU5FRFZnSm1sdDc5RWl2ZGFEUTIwL1BB?=
 =?utf-8?B?Q0tNN0UwdDBMMllCSmZ3M3hlZDZoQlphTStMRlRCUWR5NitvNUdwNnVJUjZ0?=
 =?utf-8?B?bzA4SzhjL2JKaGN3SHNUM1M0SEhmUkRZcWpWQ0ZzNit0U0tJR25lK3FKai9y?=
 =?utf-8?B?ZUw2a3lRWmM5RnFJVmVWRmdCT0owc3UrTEUxTXAzSStKZWl0d2VMMmlvTGpu?=
 =?utf-8?B?UlBEWlZnQnJmQWh0cjRob001VTQzNUR1VW95MmoxeW1YbmtqU202c3hiaHQr?=
 =?utf-8?B?U0k4ZWlJQktNUUh3eUFxaWFwbmRZajh1MTU0dGZRRW5jLzMxMk1aalgvZm5x?=
 =?utf-8?B?RFVjUTBFdno2aWJKTGVSMmRtbUZrWXRzckFabGpRaElZOGdWd0R0OXVYSURp?=
 =?utf-8?B?UnFrT3RlL3pNOE16bmhqbnUyTndwTjh1WVc5UlA2ektvc3pTUGVqV2NSL29M?=
 =?utf-8?B?b0NMREpodUFMc1JyOHduWUZzcHdXbnhDblIyNXowRFQ4Z2JDUzBkYytWNE9h?=
 =?utf-8?B?bkVpRHFBVTRYUjVIQi9PejQyTTZmcHpMd1RCb3lqWVhFVGt2c2wvUHhOUlNN?=
 =?utf-8?B?WFRyUjFURDllNGFnanBNTFhvZHM1alJJdFM2bFBVM0M5VEY5UmpvaFRtNmMy?=
 =?utf-8?B?ZTI5ZXEwT1RPVTJMOTNSZVRNQ1hxejIzWE9NSHZlbVZMYVN0bTRrd1ptcUJy?=
 =?utf-8?B?Smc5a2MxZHhxNmJTaXg2aVFWZVpaeDM4NkJ4QWVMODRTc0pFb014Y281amtK?=
 =?utf-8?B?S0tIdkx5TzFSZlZaQ1FNb1hDVlZtOUlXc2dPV3ZGRFo3b05xdE9jeEZFOU1r?=
 =?utf-8?B?dkU5TmhOV2p3Ukd3c3VZSkh6RThJdHU4Zk9FL1NvMWVSMk10elo1cWZUOGJN?=
 =?utf-8?B?a0d1bHVNNzY3N3ZqOUlGWTFKaDdXZ044V3ZLRWcrWjRaWXllcUhyVVBsb1B1?=
 =?utf-8?B?aW4yWGlzL0FoaHljQkQ5Q0NSRnNtRVE2MDE1dTg2MGsxUWtsU0FETmUwQ0VY?=
 =?utf-8?B?bTZNUnZRZUlDcnNXU1BrUFhRQzRKRkUrL085elpHY2huMmJWVlFST3lQbGZw?=
 =?utf-8?B?dGVQNUh1OG1pQ1ZEZUh2bVh2eDNGYTZNb1VSOGVBOTVEM1dHSGtVK1I3TEt4?=
 =?utf-8?B?ZnR4SmhTMWdLdmovT2srU0NBSkRnWmRxUFA1dWlKUStUS0RRNWNwaHJLQ3FH?=
 =?utf-8?B?MmJMS1ZPWW1HVTQyd1N2ZFhvMW9tVlB2MjFkWmVVRXRhYlFqR0N4bXdyQ0d2?=
 =?utf-8?B?Vk5tZW1IMUtmSGtld3B5a2l5d2oxemhzaHhBRWJSVnlVWDd2UXJEUkNDQ1ow?=
 =?utf-8?B?NDBMNUtLbDFCNkt1bmxFUDFqWm1PaENpRTlYUy84SHZVbDBqQ0k0RVo0UWNK?=
 =?utf-8?B?L05udHp1cEtQTzBFNGY2OERQL3E4NGVJbGlTTDlnWEliRHJsZ21XdGQxdWNF?=
 =?utf-8?B?NXZ5NkI3cCtxeWVZNysrTXJWeUtKWldPTUUxbjFHcWdzUVE0elpnY1hBbHdt?=
 =?utf-8?B?dWkyMW92Z2t5bndDMEI1NDhqQU9GUVhuTmVFWk9rY005TjN5TDEvQW5LRGZs?=
 =?utf-8?B?bHB2amNwNTg3R0xOQUZITFpXM2dZYWR3UnVFcitOUC96Qll6RCsrdytrcWNo?=
 =?utf-8?B?QytxUGlLWmhVT0p4UVdFWjV1UlVaSkNSOHh3b1Z2bys5SklCaGx2eUxCVGJW?=
 =?utf-8?B?NTVVd253QWg3cU91NlJ1c0cvNmVaU2Z6ZnpkUlBXTU42RlFETDhUM3dXcDFu?=
 =?utf-8?B?VW1RNkRXT3pXWEpnZGl5MktNN1k1eDdvUERTYWtrSHVGbW5aSXFWTGwxRXhW?=
 =?utf-8?B?TzJSUHYxejNLTGtHbFlUdHhldk5yWHN0ZWxPcERSVTNXSGluQ0FVNVBnOW9z?=
 =?utf-8?Q?uPYUPKNxFw8e2rnqaDCEVT0uL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a57137f-a7fb-4782-49ca-08da8dce3215
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2022 17:03:17.0787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7ejxaKZWuWmQ12IGgVJ/JACOKKqMrCYlm+DuItKPTY5zvsTDFIqFaAj1W5FW0CjwsZbuDMCvw3kwEh4QWuAGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5786
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-03_08,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209030087
X-Proofpoint-ORIG-GUID: l7XT-8Ac3xvZCot-yM_72JnLGKdm0gnv
X-Proofpoint-GUID: l7XT-8Ac3xvZCot-yM_72JnLGKdm0gnv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 9/2/22 6:26 PM, Chuck Lever III wrote:
>> On Sep 2, 2022, at 3:34 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> On 9/2/22 10:58 AM, Chuck Lever III wrote:
>>>>> Or, nfsd_courtesy_client_count() could return
>>>>> nfsd_couresy_client_count. nfsd_courtesy_client_scan() could
>>>>> then look something like this:
>>>>>
>>>>> 	if ((sc->gfp_mask & GFP_KERNEL) != GFP_KERNEL)
>>>>> 		return SHRINK_STOP;
>>>>>
>>>>> 	nfsd_get_client_reaplist(nn, reaplist, lt);
>>>>> 	list_for_each_safe(pos, next, &reaplist) {
>>>>> 		clp = list_entry(pos, struct nfs4_client, cl_lru);
>>>>> 		trace_nfsd_clid_purged(&clp->cl_clientid);
>>>>> 		list_del_init(&clp->cl_lru);
>>>>> 		expire_client(clp);
>>>>> 		count++;
>>>>> 	}
>>>>> 	return count;
>>>> This does not work, we cannot expire clients on the context of
>>>> scan callback due to deadlock problem.
>>> Correct, we don't want to start shrinker laundromat activity if
>>> the allocation request specified that it cannot wait. But are
>>> you sure it doesn't work if sc_gfp_flags is set to GFP_KERNEL?
>> It can be deadlock due to lock ordering problem:
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 5.19.0-rc2_sk+ #1 Not tainted
>> ------------------------------------------------------
>> lck/31847 is trying to acquire lock:
>> ffff88811d268850 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}, at: btrfs_inode_lock+0x38/0x70
>> #012but task is already holding lock:
>> ffffffffb41848c0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x506/0x1db0
>> #012which lock already depends on the new lock.
>> #012the existing dependency chain (in reverse order) is:
>>
>> #012-> #1 (fs_reclaim){+.+.}-{0:0}:
>>        fs_reclaim_acquire+0xc0/0x100
>>        __kmalloc+0x51/0x320
>>        btrfs_buffered_write+0x2eb/0xd90
>>        btrfs_do_write_iter+0x6bf/0x11c0
>>        do_iter_readv_writev+0x2bb/0x5a0
>>        do_iter_write+0x131/0x630
>>        nfsd_vfs_write+0x4da/0x1900 [nfsd]
>>        nfsd4_write+0x2ac/0x760 [nfsd]
>>        nfsd4_proc_compound+0xce8/0x23e0 [nfsd]
>>        nfsd_dispatch+0x4ed/0xc10 [nfsd]
>>        svc_process_common+0xd3f/0x1b00 [sunrpc]
>>        svc_process+0x361/0x4f0 [sunrpc]
>>        nfsd+0x2d6/0x570 [nfsd]
>>        kthread+0x2a1/0x340
>>        ret_from_fork+0x22/0x30
>>
>> #012-> #0 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}:
>>        __lock_acquire+0x318d/0x7830
>>        lock_acquire+0x1bb/0x500
>>        down_write+0x82/0x130
>>        btrfs_inode_lock+0x38/0x70
>>        btrfs_sync_file+0x280/0x1010
>>        nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
>>        nfsd_file_put+0xd4/0x110 [nfsd]
>>        release_all_access+0x13a/0x220 [nfsd]
>>        nfs4_free_ol_stateid+0x40/0x90 [nfsd]
>>        free_ol_stateid_reaplist+0x131/0x210 [nfsd]
>>        release_openowner+0xf7/0x160 [nfsd]
>>        __destroy_client+0x3cc/0x740 [nfsd]
>>        nfsd_cc_lru_scan+0x271/0x410 [nfsd]
>>        shrink_slab.constprop.0+0x31e/0x7d0
>>        shrink_node+0x54b/0xe50
>>        try_to_free_pages+0x394/0xba0
>>        __alloc_pages_slowpath.constprop.0+0x5d2/0x1db0
>>        __alloc_pages+0x4d6/0x580
>>        __handle_mm_fault+0xc25/0x2810
>>        handle_mm_fault+0x136/0x480
>>        do_user_addr_fault+0x3d8/0xec0
>>        exc_page_fault+0x5d/0xc0
>>        asm_exc_page_fault+0x27/0x30
> Is this deadlock possible only via the filecache close
> paths?

I'm not sure, but there is another back trace below that shows
another problem.

>   I can't think of a reason the laundromat has to
> wait for each file to be flushed and closed -- the
> laundromat should be able to "put" these files and allow
> the filecache LRU to flush and close in the background.

ok, what should we do here, enhancing the laundromat to behave
as you describe?

Here is another stack trace of problem with calling expire_client
from 'scan' callback:
Sep  3 09:07:35 nfsvmf24 kernel: ------------[ cut here ]------------
Sep  3 09:07:35 nfsvmf24 kernel: workqueue: PF_MEMALLOC task 3525(gmain) is flushing !WQ_MEM_RECLAIM nfsd4_callbacks:0x0
Sep  3 09:07:35 nfsvmf24 kernel: WARNING: CPU: 0 PID: 3525 at kernel/workqueue.c:2625 check_flush_dependency+0x17a/0x350
Sep  3 09:07:35 nfsvmf24 kernel: Modules linked in: rpcsec_gss_krb5 nfsd nfs_acl lockd grace auth_rpcgss sunrpc
Sep  3 09:07:35 nfsvmf24 kernel: CPU: 0 PID: 3525 Comm: gmain Kdump: loaded Not tainted 6.0.0-rc3+ #1
Sep  3 09:07:35 nfsvmf24 kernel: Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
Sep  3 09:07:35 nfsvmf24 kernel: RIP: 0010:check_flush_dependency+0x17a/0x350
Sep  3 09:07:35 nfsvmf24 kernel: Code: 48 c1 ee 03 0f b6 04 06 84 c0 74 08 3c 03 0f 8e b8 01 00 00 41 8b b5 90 05 00 00 49 89 e8 48 c7 c7 c0 4d 06 9a e8 c6 a4 7f 02 <0f> 0b eb 4d 65 4c 8b 2c 25 c0 6e 02 00 4c 89 ef e8 71 65 01 00 49
Sep  3 09:07:35 nfsvmf24 kernel: RSP: 0018:ffff88810c73f4e8 EFLAGS: 00010282
Sep  3 09:07:35 nfsvmf24 kernel: RAX: 0000000000000000 RBX: ffff88811129a800 RCX: 0000000000000000
Sep  3 09:07:35 nfsvmf24 kernel: RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffed10218e7e93
Sep  3 09:07:35 nfsvmf24 kernel: RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed103afc6ed2
Sep  3 09:07:35 nfsvmf24 kernel: R10: ffff8881d7e3768b R11: ffffed103afc6ed1 R12: 0000000000000000
Sep  3 09:07:35 nfsvmf24 kernel: R13: ffff88810d14cac0 R14: 000000000000000d R15: 000000000000000c
Sep  3 09:07:35 nfsvmf24 kernel: FS:  00007fa9a696c700(0000) GS:ffff8881d7e00000(0000) knlGS:0000000000000000
Sep  3 09:07:35 nfsvmf24 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Sep  3 09:07:35 nfsvmf24 kernel: CR2: 00007fe922689c50 CR3: 000000010bdd8000 CR4: 00000000000406f0
Sep  3 09:07:35 nfsvmf24 kernel: Call Trace:
Sep  3 09:07:35 nfsvmf24 kernel: <TASK>
Sep  3 09:07:35 nfsvmf24 kernel: __flush_workqueue+0x32c/0x1350
Sep  3 09:07:35 nfsvmf24 kernel: ? lock_downgrade+0x680/0x680
Sep  3 09:07:35 nfsvmf24 kernel: ? rcu_read_lock_held_common+0xe/0xa0
Sep  3 09:07:35 nfsvmf24 kernel: ? check_flush_dependency+0x350/0x350
Sep  3 09:07:35 nfsvmf24 kernel: ? lock_release+0x485/0x720
Sep  3 09:07:35 nfsvmf24 kernel: ? __queue_work+0x3cc/0xe10
Sep  3 09:07:35 nfsvmf24 kernel: ? trace_hardirqs_on+0x2d/0x110
Sep  3 09:07:35 nfsvmf24 kernel: ? nfsd4_shutdown_callback+0xc5/0x3d0 [nfsd]
Sep  3 09:07:35 nfsvmf24 kernel: nfsd4_shutdown_callback+0xc5/0x3d0 [nfsd]
Sep  3 09:07:35 nfsvmf24 kernel: ? lock_release+0x485/0x720
Sep  3 09:07:35 nfsvmf24 kernel: ? nfsd4_probe_callback_sync+0x20/0x20 [nfsd]
Sep  3 09:07:35 nfsvmf24 kernel: ? lock_downgrade+0x680/0x680
Sep  3 09:07:35 nfsvmf24 kernel: __destroy_client+0x5ec/0xa60 [nfsd]
Sep  3 09:07:35 nfsvmf24 kernel: ? nfsd4_cb_recall_release+0x20/0x20 [nfsd]
Sep  3 09:07:35 nfsvmf24 kernel: nfsd_courtesy_client_scan+0x39f/0x850 [nfsd]
Sep  3 09:07:35 nfsvmf24 kernel: ? preempt_schedule_notrace+0x74/0xe0
Sep  3 09:07:35 nfsvmf24 kernel: ? client_ctl_write+0x7c0/0x7c0 [nfsd]
Sep  3 09:07:35 nfsvmf24 kernel: ? preempt_schedule_notrace_thunk+0x16/0x18
Sep  3 09:07:35 nfsvmf24 kernel: shrink_slab.constprop.0+0x30b/0x7b0
Sep  3 09:07:35 nfsvmf24 kernel: ? unregister_shrinker+0x270/0x270
Sep  3 09:07:35 nfsvmf24 kernel: shrink_node+0x54b/0xe50
Sep  3 09:07:35 nfsvmf24 kernel: try_to_free_pages+0x394/0xba0
Sep  3 09:07:35 nfsvmf24 kernel: ? reclaim_pages+0x3b0/0x3b0
Sep  3 09:07:35 nfsvmf24 kernel: __alloc_pages_slowpath.constprop.0+0x636/0x1f30
Sep  3 09:07:35 nfsvmf24 kernel: ? warn_alloc+0x120/0x120
Sep  3 09:07:35 nfsvmf24 kernel: ? __zone_watermark_ok+0x2d0/0x2d0
Sep  3 09:07:35 nfsvmf24 kernel: __alloc_pages+0x4d6/0x580
Sep  3 09:07:35 nfsvmf24 kernel: ? __alloc_pages_slowpath.constprop.0+0x1f30/0x1f30
Sep  3 09:07:35 nfsvmf24 kernel: ? find_held_lock+0x2c/0x110
Sep  3 09:07:35 nfsvmf24 kernel: ? lockdep_hardirqs_on_prepare+0x17b/0x410
Sep  3 09:07:35 nfsvmf24 kernel: ____cache_alloc.part.0+0x586/0x760
Sep  3 09:07:35 nfsvmf24 kernel: ? kmem_cache_alloc+0x193/0x290
Sep  3 09:07:35 nfsvmf24 kernel: kmem_cache_alloc+0x22f/0x290
Sep  3 09:07:35 nfsvmf24 kernel: getname_flags+0xbe/0x4e0
Sep  3 09:07:35 nfsvmf24 kernel: user_path_at_empty+0x23/0x50
Sep  3 09:07:35 nfsvmf24 kernel: inotify_find_inode+0x28/0x120
Sep  3 09:07:35 nfsvmf24 kernel: ? __fget_light+0x19b/0x210
Sep  3 09:07:35 nfsvmf24 kernel: __x64_sys_inotify_add_watch+0x160/0x290
Sep  3 09:07:35 nfsvmf24 kernel: ? __ia32_sys_inotify_rm_watch+0x170/0x170
Sep  3 09:07:35 nfsvmf24 kernel: do_syscall_64+0x3d/0x90
Sep  3 09:07:35 nfsvmf24 kernel: entry_SYSCALL_64_after_hwframe+0x46/0xb0
Sep  3 09:07:35 nfsvmf24 kernel: RIP: 0033:0x7fa9b1a77f37
Sep  3 09:07:35 nfsvmf24 kernel: Code: f0 ff ff 73 01 c3 48 8b 0d 36 7f 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 fe 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 7f 2c 00 f7 d8 64 89 01 48
Sep  3 09:07:35 nfsvmf24 kernel: RSP: 002b:00007fa9a696bb28 EFLAGS: 00000202 ORIG_RAX: 00000000000000fe
Sep  3 09:07:35 nfsvmf24 kernel: RAX: ffffffffffffffda RBX: 00005638abf5adc0 RCX: 00007fa9b1a77f37
Sep  3 09:07:35 nfsvmf24 kernel: RDX: 0000000001002fce RSI: 00005638abf58080 RDI: 000000000000000d
Sep  3 09:07:35 nfsvmf24 kernel: RBP: 00007fa9a696bb54 R08: 00007ffe7f7f1080 R09: 0000000000000000
Sep  3 09:07:35 nfsvmf24 kernel: R10: 00000000002cf948 R11: 0000000000000202 R12: 0000000000000000
Sep  3 09:07:35 nfsvmf24 kernel: R13: 00007fa9b39710e0 R14: 00005638abf5adf0 R15: 00007fa9b317c940

Another behavior about the shrinker is that the 'count' and 'scan'
callbacks are not 1-to-1, meaning the 'scan' is not called after
every 'count' callback. Not sure what criteria the shrinker use to
do the 'scan' callback but it's very late, sometimes after dozens
of 'count' callback then there is a 'scan' callback. If we rely on
the 'scan' callback then I don't think we react in time to release
the courtesy clients.

-Dai

>
>
> --
> Chuck Lever
>
>
>
