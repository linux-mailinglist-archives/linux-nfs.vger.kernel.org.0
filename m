Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0E252246E
	for <lists+linux-nfs@lfdr.de>; Tue, 10 May 2022 20:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiEJS4a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 May 2022 14:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349140AbiEJS4Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 May 2022 14:56:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EBEBE01
        for <linux-nfs@vger.kernel.org>; Tue, 10 May 2022 11:56:22 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AGDctq032663;
        Tue, 10 May 2022 18:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Zt3ihi4JZVAjWpbOKxgLkeRy81Ht69HjOYhqt+XMr6k=;
 b=m9rTBcr3VsodZUJ6LfPi57k0tLqx7eC8dg5yaOHG+g/5MrXj6Nl1wEWnITHmGe9XaxLg
 H2g2LXk9bAFf7ILWWYy0GGEmN3Lsj/hT28yFclRi7LsuluJtd2PbQ+X+zDUWzN6/Uq8p
 eyF13Jn2G2kzCTV7djI3UARigcXfRyPxRN7yZ5hoe8UngPGcEtb2fOKC3+z8EyBUhGFw
 KrxkgqgAd9dF1LpCOffDA5xfCry46onjEAwMFCisT1LZGh0Pe72UdOAc8QqlFcLVnx8z
 YkCp/NxvMVXGsaFni6OJIY0h99py9cmjY6dJWH0cCTvM0uMdQ8SXSsbdbrWCuvYvq2ia Pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhatfnxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 18:56:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24AIZdsj024077;
        Tue, 10 May 2022 18:56:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf73dfdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 18:56:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGF8uwyIpv34YVRAwR2mj6tnH/H2HDdMzIpyoyX6RfaRIe1IG64sSlPp2GyfMiv7JsBorugrpjb2gnOEdzDnNVmoS5yvBaDBYHt4zNZU0NM0aQlEezn40fd4sstWXXX7jDKQffsMkqtssF+k4bcRHxPMEfFg3nOtyJ2VU++Gyk8pcGwkePueZa3oD/TsQKFvGAt83iy8L156Ji1VYTEnDUQlcWJR/b6JIcNXYleiCiB7wgQT2IKy25rRwNOLChenoR0Q7lGcqIfA1fE8d13JWRPgapDzwlzKzP1L8EcXh0VJ1/w34DCcYLA9fFaXAoA5akOJisyZoLZlWR81WEiKkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zt3ihi4JZVAjWpbOKxgLkeRy81Ht69HjOYhqt+XMr6k=;
 b=XEIy+9GLpUgAHd4cuiS41TKGgjOeY12aORxy1cPbl4+pZlaQZ8cE82O/71+81bgqP1NnhtWhxnd0kOuV4vaFBuZl+KxtNWjtysvdxtr5RePQt7l3ZzWO0IlLNALVSwHuTkv9eb/PA5HLeir8TFnouXp0kJGkKR45bm7TL4bgxocwY8HiU/52XB4ysph3Y9UsVZnqsNONJopAugKMPolDXIFkqHx0jskC9y8FzYtZKP+FvKnBEFETTvY7UK2GYbykM4Ga4+KYOvcOQL9ybGgAMBkW0KTbo36fboPIbYvBUyD5bk+bchi/8pA4n0jUHdpR03mESUPZMlGI7Fz2S0tt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zt3ihi4JZVAjWpbOKxgLkeRy81Ht69HjOYhqt+XMr6k=;
 b=FeYqaS/gJtuB2Rtb6W+963RVkMX8k1T8qd++5d7o3ruqx1no5/iqYkioYHj2yU0CyB1Z0kXIs+bxWsnKXLNUCMOHgArW9/iKQcedIXo1VWZk6E+CQoTyOmkIWasOaV0pn3iL2sK7IKrNrtOgPIrOUiuOvc7ddjSGvtRn2Hr65lg=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DM4PR10MB6064.namprd10.prod.outlook.com (2603:10b6:8:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Tue, 10 May
 2022 18:56:17 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::dd6d:626:3df8:680e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::dd6d:626:3df8:680e%2]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 18:56:17 +0000
Message-ID: <8a8b284c-1fc9-07de-8dce-aade1c04bde2@oracle.com>
Date:   Tue, 10 May 2022 11:56:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [bug report] kernel 5.18.0-rc4 oops with invalid wait context
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <313fcd93-c3dd-35f2-ab59-2f1e913d015f@oracle.com>
 <ED29F5B7-9839-4BCB-AE97-AAF776D95B28@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <ED29F5B7-9839-4BCB-AE97-AAF776D95B28@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:a03:338::32) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1e339fe-7591-4ce5-bb17-08da32b6c3c4
X-MS-TrafficTypeDiagnostic: DM4PR10MB6064:EE_
X-Microsoft-Antispam-PRVS: <DM4PR10MB60643C0EEB8153C97B0F84AE87C99@DM4PR10MB6064.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09D/D+iOoxp0SSqgvKB4hIZkRl1RLrOalAMqDrj5KblwV0Ne/1jOgjgy9hyVNd5ppr6dxd204Cbm2us+gSDcXaDonQq9G8U7ndQdl+OOpuPnCUEyKz6eSmvKBxK1Mm/aQq214+DMgICmb2barYbC2Iu/8nyphJky667X8o08IwtwtnnyuiBVDy7hWr2RG+rwa7E35yyDCgxGsq0JkrZYeoD9E7rBMSPNLEwrfHMPn2Rj8UeGcI/2AcnLli0a24Aagtz4iGvVz9/KTz56vmb6fb5AfW5MNrlJjd/tIU0AzWxWKQ1FlsNlYpjWeUgIuLwjXCSPPG795RZqf8sFtxCLaeVvgBJsRxicf2v/k8zwxfZWAR2OP1KqAPcuv+htYDnjwleSr+LKas7TFaNFCc9Sv7yYNeqFCsirM8Tsr8EqiNyKpHVqi4iONUKpvLj9R85z6k0OIhYBJbpli9hBUMCXPT1JcdTyiEWvPGc7VK/VKekZy4eZOcg8EUUr0CVSVYqbr9HoasxQc+t9GSzZ21kF5EyC3YIsXyF3zbDeVRiX3WaPfaLVVoWktvfOfHXIHOtJoJDWrjjMcCHBtF5jw/KudfrAQmMn3Jo2xerEPevbx/bXcU8ivPEad7Ic8AehdiYEwKw/Yui3+XEQcZowraWmUyKapdHo0wU7vGJiUEfoOm5+7H37r/tmEd5SHnWey760gfXu70EGQt9Q1nPq+3nucw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(8936002)(5660300002)(53546011)(6506007)(9686003)(6512007)(2906002)(45080400002)(26005)(38100700002)(110136005)(31696002)(83380400001)(508600001)(86362001)(186003)(2616005)(66476007)(66556008)(4326008)(316002)(36756003)(66946007)(31686004)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWhWbklqbkRZRjdhZGxTQWR5cUxjN05sMmRBN29uVlRabWFtQzNGRmIzTERn?=
 =?utf-8?B?ZHJ1VVhCczk1aVFxSWVTNitVd0dMUnVFUEt0a3NuOG9Wb1Bud2VpaHB3cnRx?=
 =?utf-8?B?aXErTHFHWXErZXhQeldjTCttSVExNi9lUkowaXgyZmg0Sy9ZRmg0V0d3ZDk2?=
 =?utf-8?B?TkVFaU9sYXFaeWxXRTU1dEtQR05ubHJ5NzMwVlMyTUVOUVBQVjUvOEdDVGNH?=
 =?utf-8?B?cy9TNUo3OWZYaE14UnFYOERPRXpaNVpndi9Dc21tc1pQT3ZqeTBNeElnd2Vr?=
 =?utf-8?B?cXBsZ2NnSTE2Vkd6bi9tMHRwQTU2Y2hVUS9aUVBEUzRVK3VSN0xyYnlvNWdi?=
 =?utf-8?B?amwxakluZStXcXY2d2ZCQlNOTGhwRGxtTWtyTisrRDEvangvZFdTRUF5Q25T?=
 =?utf-8?B?WFdDTVc3cU5XVGcwTis4MlEybjRmRXJkY1dZYkNIVjZaamgxcFkxWDE1M2kx?=
 =?utf-8?B?THZ3RGk0V3NSQkpXS3N6Zm44dTdJQm8zWjB6SW1qY1BIN2ZHdjdnQWxON0g2?=
 =?utf-8?B?WVFhQ3VubmVqUklybUFFRlR0d20wemRNdTdZZ21xdEdHZzRQdTQvbXUybSty?=
 =?utf-8?B?V3lMT0ZzRFBFMVZLWU5hQndKczFKczBzd0JSampjVEFKelVaRXN3eis0TWRp?=
 =?utf-8?B?ZDdKY2JXcS84alFCZlZpd1A0Ym51WjU1Vmh1TUpjVGpzemYzam9QaXJWUlhJ?=
 =?utf-8?B?TkkyaVFYM3l1N01NcUJHVUpDbyt5Vy9kbmFiSnk5aVA3SmlxeVRxMUdYOENy?=
 =?utf-8?B?a3BsWmF6MDUyaDFLdXkvYmxpaG9Jc2s2MGR5Zk83V2RyejBacE1sT3dlNkx1?=
 =?utf-8?B?cEkrYXFTaW5iOXlQZjJGTTRrTmd6RlBFSnk3U3ZETGZGUy9RbC84cUhVc0Fm?=
 =?utf-8?B?eU94a3E0MytaWTlvYmNYcXNaWkp1WHZDNE42Y2hKbVVUOStUaTJwT01ud0pz?=
 =?utf-8?B?b3NMbzQzSUxUZkJpWG9jSFVUSkplUkZZb3JpeFpseHVuSWFubGVDQ3lBWEZI?=
 =?utf-8?B?N2tZZlRrd1crSTlYNXlvdG5lZUsvZ2NsY2JVQ1BNZ3JBa2VaN3NkYUZTSkQv?=
 =?utf-8?B?eFQ1TjNobmkxRGFGLzIyVmQ5MGxUTlVwWWxtbzJENjVDa0NMeFlxT0dHR2VB?=
 =?utf-8?B?S05mdHRVMS80T3JiYjU4ek9YUzRneUxWKzNnYm9ObGVibGl2TGtIcVZqVHVu?=
 =?utf-8?B?ajZmT0F1eWM3ZCt1dlZ0L2EwNVZiQWNrdkU0QTZ2TTlyYjhBV1duTFJKYnIv?=
 =?utf-8?B?U1hvRlBrVlR4cFA4cG5VREZOaGE5R2htcU11MmZmZTZLKzB4bGZSYVNJb2Nn?=
 =?utf-8?B?UjdMVVplcy9uNkQzblNqcy9MVXRDSWtHNFVhSlFsZEJMS3c0cG94bW9XZDJh?=
 =?utf-8?B?TjBSano4amNualY4SnI2T1dxM2RCUjMrL3hoYjZNOGlZUWtPSnBaRXhDMFlw?=
 =?utf-8?B?SDBLbk9HK2hsMENrelZ3d3hsdmtuc0hDNU11bkZrMndoMVRscUp4ay9nRGxq?=
 =?utf-8?B?bGlTYnNBNWpuS0M1WmRzbVdqNWJjSmlUZWJQcms1M0R1djBQK3Awb0tLUmdn?=
 =?utf-8?B?M3p2elhoSFBNeW1ud1NheU1SRHBwK2owYzVZaC9DanJBTVJWSStaNEdBWmpL?=
 =?utf-8?B?ZFdMNThXNlQyTklTK1owUnAvOTNxZ2RxdmZUMjJXN2IxRDhMUC9nYUVmMDFQ?=
 =?utf-8?B?bitQakJRRzVPZzlTNnc4Ym9Qc28vSGpIeFh2WkU2Y2NnajdTTXdIT3BFK2tM?=
 =?utf-8?B?R1VlRjBHUTQrcVRTL3ZrcjFEbWdqRTQ3OC9POGNINnJza0l2UWszbTl6bWhU?=
 =?utf-8?B?OHNpMnROYklMQTJvdFN3cE9SQmhYdG9mRFlraFJqV2xCM2dNVnJUQldZT2VH?=
 =?utf-8?B?UDA2ZUttWXptbzAremxOL2lZcExvTElYTGRjaWlKcjlSSWhEdlVjZWRuMjkw?=
 =?utf-8?B?NzN5Z3BGbWo1RzFVYk44STEwdEVkbzJwMlIvL213bWdPVUpTN0o3K0pIVTBa?=
 =?utf-8?B?Wno4czRMMVlhQTA4L2VRc2FHT2lheVlYZFRCbzdpMTl2ME9FeXNLb3p3NHo5?=
 =?utf-8?B?bzRBNnRreGNsS2U4WmJzTHBrZXIrOTMzcXczV21TYzRnUC9yZHlQUWgwUzFl?=
 =?utf-8?B?M1k4Qm41ZjFRUlE2WkhERWROM1kyY0E5dEM4SnVHY2s5dkFHNS8rc3cvVFNl?=
 =?utf-8?B?OFQ4ZlR0dzNsM2pBbUkzRmlmd0pSb3BGWFd1OHFTaXZPVzZvS1dpQ2dyUWZk?=
 =?utf-8?B?a2xSMmx2TStuWWpielJuQkVhOC9pOWJ4QlRTZE04YVNSOWhDNFVkeGliMmUz?=
 =?utf-8?B?aXB5clRiK2s1ZUtHK1FmQVc2a3JGSEEwZDRJcjJWdU5hSHVmUTFPQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e339fe-7591-4ce5-bb17-08da32b6c3c4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 18:56:17.8264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fXwxhWUNo3LAzh6s488l+CbY+42tr/1tSCgdS9vKFjOzR9wTqj7V1kaOKCmwlSHWPekCxQH/qcKCgG4RVvrRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6064
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-10_05:2022-05-09,2022-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100080
X-Proofpoint-GUID: fIl2yiF0jvKcv4hwtWXjRtsEPusb79qd
X-Proofpoint-ORIG-GUID: fIl2yiF0jvKcv4hwtWXjRtsEPusb79qd
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 5/10/22 7:24 AM, Chuck Lever III wrote:
>
>> On May 3, 2022, at 3:11 PM, dai.ngo@oracle.com wrote:
>>
>> Hi,
>>
>> I just noticed there were couple of oops in my Oracle6 in nfs4.dev network.
>> I'm not sure who ran which tests (be useful to know) that caused these oops.
>>
>> Here is the stack traces:
>>
>> [286123.154006] BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1585
>> [286123.155126] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3983, name: nfsd
>> [286123.155872] preempt_count: 1, expected: 0
>> [286123.156443] RCU nest depth: 0, expected: 0
>> [286123.156771] 1 lock held by nfsd/3983:
>> [286123.156786]  #0: ffff888006762520 (&clp->cl_lock){+.+.}-{2:2}, at: nfsd4_release_lockowner+0x306/0x850 [nfsd]
>> [286123.156949] Preemption disabled at:
>> [286123.156961] [<0000000000000000>] 0x0
>> [286123.157520] CPU: 1 PID: 3983 Comm: nfsd Kdump: loaded Not tainted 5.18.0-rc4+ #1
>> [286123.157539] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
>> [286123.157552] Call Trace:
>> [286123.157565]  <TASK>
>> [286123.157581]  dump_stack_lvl+0x57/0x7d
>> [286123.157609]  __might_resched.cold+0x222/0x26b
>> [286123.157644]  down_read_nested+0x68/0x420
>> [286123.157671]  ? down_write_nested+0x130/0x130
>> [286123.157686]  ? rwlock_bug.part.0+0x90/0x90
>> [286123.157705]  ? rcu_read_lock_sched_held+0x81/0xb0
>> [286123.157749]  xfs_file_fsync+0x3b9/0x820
>> [286123.157776]  ? lock_downgrade+0x680/0x680
>> [286123.157798]  ? xfs_filemap_pfn_mkwrite+0x10/0x10
>> [286123.157823]  ? nfsd_file_put+0x100/0x100 [nfsd]
>> [286123.157921]  nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
>> [286123.158007]  nfsd_file_put+0x79/0x100 [nfsd]
>> [286123.158088]  check_for_locks+0x152/0x200 [nfsd]
>> [286123.158191]  nfsd4_release_lockowner+0x4cf/0x850 [nfsd]
>> [286123.158393]  ? nfsd4_locku+0xd10/0xd10 [nfsd]
>> [286123.158488]  ? rcu_read_lock_bh_held+0x90/0x90
>> [286123.158525]  nfsd4_proc_compound+0xd15/0x25a0 [nfsd]
>> [286123.158699]  nfsd_dispatch+0x4ed/0xc30 [nfsd]
>> [286123.158974]  ? rcu_read_lock_bh_held+0x90/0x90
>> [286123.159010]  svc_process_common+0xd8e/0x1b20 [sunrpc]
>> [286123.159043]  ? svc_generic_rpcbind_set+0x450/0x450 [sunrpc]
>> [286123.159043]  ? nfsd_svc+0xc50/0xc50 [nfsd]
>> [286123.159043]  ? svc_sock_secure_port+0x27/0x40 [sunrpc]
>> [286123.159043]  ? svc_recv+0x1100/0x2390 [sunrpc]
>> [286123.159043]  svc_process+0x361/0x4f0 [sunrpc]
>> [286123.159043]  nfsd+0x2d6/0x570 [nfsd]
>> [286123.159043]  ? nfsd_shutdown_threads+0x2a0/0x2a0 [nfsd]
>> [286123.159043]  kthread+0x29f/0x340
>> [286123.159043]  ? kthread_complete_and_exit+0x20/0x20
>> [286123.159043]  ret_from_fork+0x22/0x30
>> [286123.159043]  </TASK>
>> [286123.187052] BUG: scheduling while atomic: nfsd/3983/0x00000002
>> [286123.187551] INFO: lockdep is turned off.
>> [286123.187918] Modules linked in: nfsd auth_rpcgss nfs_acl lockd grace sunrpc
>> [286123.188527] Preemption disabled at:
>> [286123.188535] [<0000000000000000>] 0x0
>> [286123.189255] CPU: 1 PID: 3983 Comm: nfsd Kdump: loaded Tainted: G        W         5.18.0-rc4+ #1
>> [286123.190233] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
>> [286123.190910] Call Trace:
>> [286123.190910]  <TASK>
>> [286123.190910]  dump_stack_lvl+0x57/0x7d
>> [286123.190910]  __schedule_bug.cold+0x133/0x143
>> [286123.190910]  __schedule+0x16c9/0x20a0
>> [286123.190910]  ? schedule_timeout+0x314/0x510
>> [286123.190910]  ? __sched_text_start+0x8/0x8
>> [286123.190910]  ? internal_add_timer+0xa4/0xe0
>> [286123.190910]  schedule+0xd7/0x1f0
>> [286123.190910]  schedule_timeout+0x319/0x510
>> [286123.190910]  ? rcu_read_lock_held_common+0xe/0xa0
>> [286123.190910]  ? usleep_range_state+0x150/0x150
>> [286123.190910]  ? lock_acquire+0x331/0x490
>> [286123.190910]  ? init_timer_on_stack_key+0x50/0x50
>> [286123.190910]  ? do_raw_spin_lock+0x116/0x260
>> [286123.190910]  ? rwlock_bug.part.0+0x90/0x90
>> [286123.190910]  io_schedule_timeout+0x26/0x80
>> [286123.190910]  wait_for_completion_io_timeout+0x16a/0x340
>> [286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
>> [286123.190910]  ? wait_for_completion+0x330/0x330
>> [286123.190910]  submit_bio_wait+0x135/0x1d0
>> [286123.190910]  ? submit_bio_wait_endio+0x40/0x40
>> [286123.190910]  ? xfs_iunlock+0xd5/0x300
>> [286123.190910]  ? bio_init+0x295/0x470
>> [286123.190910]  blkdev_issue_flush+0x69/0x80
>> [286123.190910]  ? blk_unregister_queue+0x1e0/0x1e0
>> [286123.190910]  ? bio_kmalloc+0x90/0x90
>> [286123.190910]  ? xfs_iunlock+0x1b4/0x300
>> [286123.190910]  xfs_file_fsync+0x354/0x820
>> [286123.190910]  ? lock_downgrade+0x680/0x680
>> [286123.190910]  ? xfs_filemap_pfn_mkwrite+0x10/0x10
>> [286123.190910]  ? nfsd_file_put+0x100/0x100 [nfsd]
>> [286123.190910]  nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
>> [286123.190910]  nfsd_file_put+0x79/0x100 [nfsd]
>> [286123.190910]  check_for_locks+0x152/0x200 [nfsd]
>> [286123.190910]  nfsd4_release_lockowner+0x4cf/0x850 [nfsd]
>> [286123.190910]  ? nfsd4_locku+0xd10/0xd10 [nfsd]
>> [286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
>> [286123.190910]  nfsd4_proc_compound+0xd15/0x25a0 [nfsd]
>> [286123.190910]  nfsd_dispatch+0x4ed/0xc30 [nfsd]
>> [286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
>> [286123.190910]  svc_process_common+0xd8e/0x1b20 [sunrpc]
>> [286123.190910]  ? svc_generic_rpcbind_set+0x450/0x450 [sunrpc]
>> [286123.190910]  ? nfsd_svc+0xc50/0xc50 [nfsd]
>> [286123.190910]  ? svc_sock_secure_port+0x27/0x40 [sunrpc]
>> [286123.190910]  ? svc_recv+0x1100/0x2390 [sunrpc]
>> [286123.190910]  svc_process+0x361/0x4f0 [sunrpc]
>> [286123.190910]  nfsd+0x2d6/0x570 [nfsd]
>> [286123.190910]  ? nfsd_shutdown_threads+0x2a0/0x2a0 [nfsd]
>> [286123.190910]  kthread+0x29f/0x340
>> [286123.190910]  ? kthread_complete_and_exit+0x20/0x20
>> [286123.190910]  ret_from_fork+0x22/0x30
>> [286123.190910]  </TASK>
>>
>> The problem is the process tries to sleep while holding the
>> cl_lock by nfsd4_release_lockowner. I think the problem was
>> introduced with the filemap_flush in nfsd_file_put since
>> 'b6669305d35a nfsd: Reduce the number of calls to nfsd_file_gc()'.
>> The filemap_flush is later replaced by nfsd_file_flush by
>> '6b8a94332ee4f nfsd: Fix a write performance regression'.
> That seems plausible, given the traces above.
>
> But it begs the question: why was a vfs_fsync() needed by
> RELEASE_LOCKOWNER in this case? I've tried to reproduce the
> problem, and even added a might_sleep() call in nfsd_file_flush()
> but haven't been able to reproduce.

I haven't found a way to force the NFSD_FILE_HASHED bit to be
cleared when the client sends RELEASE_LOCKOWNER so nfsd_file_flush
is called. But if you add might_sleep() to nfsd_file_put() and
run pynfs 4.0 RLOWN1 test, the problem will happen.

>
> Since this was 5.18-rc4, would you open a bug report on
> bugzilla.linux-nfs.org and copy in all this detail?

will do. Note that the kernel on Oracle6 is 5.18-rc4 with
Courteous server patches v24 but I don't think it's related
to this problem.

-Dai

>
>
> --
> Chuck Lever
>
>
>
