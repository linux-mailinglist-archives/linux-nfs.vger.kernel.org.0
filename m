Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D116E6B39
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Apr 2023 19:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjDRRkY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Apr 2023 13:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjDRRkX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Apr 2023 13:40:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFEE40C6
        for <linux-nfs@vger.kernel.org>; Tue, 18 Apr 2023 10:40:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IEwvYu002236;
        Tue, 18 Apr 2023 17:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Ar8pgMleniUwKpF5OIxIWgYbCV0JDiFl4JH2TRW3TtY=;
 b=vXgXfAfEerC8UgZsGrrdPC5OHIecnzNJTWNdeAwabmW+KTYRq4aXuXj/oE2XlL6Dexoq
 71Op9vOMS4RLlb1pTwXmyj7AF3MhOzhzVSfZPgtkaKIxKziCSkNT8i2l5hWlzWKRAS2b
 wDeWy6iwLArKDtug4Jaby2TEvcpOxtHNxVdE8uPQGP6ndMv70kps7aGRaE9MblJSeVdx
 sWk0ORdA/WoCqm9FfNQjamOOgbZ1yknyamAgRKrZnqse5dCRpAbbNvDXVgOljTMgn3hi
 LmMFNOuCfFdJC5CGu8JkGEI2KRlsPuWJlOgll58K9dDbWOg2VyHV1yrUw8o3L7yu+GuR Ow== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykhtxa3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 17:40:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33IH16mX026350;
        Tue, 18 Apr 2023 17:40:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcc4t7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 17:40:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNWXjh/3KbpTLbxNgKI0nGy58w7aqtNixKJJL+DK9d0K2uCKPBKEeBcLnIzE4c+6GFwCg8S4MsWZbA4jGx7CqISU46s83yMEOHexclF+zlg6JHC6V/dBIQtptOzmlhSRbAfNz2Gvi6vnle0ckqmA0TRZdO80C8JzG9fkarA3gksaTci8kOBLWNRaA2+mLwB7CVlvyKqlkhi6wMonZJ2l+gFiC9p+seBetgsT7TxiEK6pNmKt6zF3nc255txO5mBv7rJ0n3LBTqooyMOqKVYdnY4x8/ln2czgCPudEgpMCRr3t77tJsk7Y797KEMUkblEOEzdSGa+Azt7pq5+Qb5wWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ar8pgMleniUwKpF5OIxIWgYbCV0JDiFl4JH2TRW3TtY=;
 b=WOq4dAjRf/4XFBmsbljPkD+vifMYuB9njbPXFSXrlTlejYb51PuxELQoC9k66lmmTGvkodgYGvVhpWXQ7HkAhMmTKljv4OG+5eWEO4GzHuuvvRzp5xYvfZjq2aYTT3ObiPqCclHwI3t/fFJbVBEkHtmHY4dpRbawxYKdrkfL3MsBhAZIuLa8J7uALxOPJ4caanU+nvstkMCkPgtK7Bm0kPJYjjsuH6z11QgMjPjSi81hJsB7G+Qa5ZxxqmFCKtcnyJaZjeAxg11v6i1JU0LlsxuwsRUnE0HwFRP8CfRyf66JCkutwyfXVU7PkFC2R1DLzBrbwQoQ+h59Hpjq5x80oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ar8pgMleniUwKpF5OIxIWgYbCV0JDiFl4JH2TRW3TtY=;
 b=p0BbW1ql5Uz40KANyH+mA7s316Pz9W1TJ3XNt0Q2CRKbhrgSL3JV3EVS13i/uSzBuHZXz7Cub4EJmKMBwiwXnzXEi50lFA7lfsIVICraJVyrwJaSM20k2Vf1KHzC9evKhIdq7wVfb7lp3jlHWuRRo52AKdGfrXZM/0aYrg6RYbs=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DM6PR10MB4137.namprd10.prod.outlook.com (2603:10b6:5:217::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 17:40:13 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%6]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 17:40:13 +0000
Message-ID: <501ff5e3-298b-8b1c-d5d1-e6e2f0466e27@oracle.com>
Date:   Tue, 18 Apr 2023 10:40:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
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
 <00fe5d5a-43b8-0f0e-2afe-ae68367f822d@oracle.com>
 <d16f1877626966d854db8c5f82cc37e5b665c5af.camel@hammerspace.com>
 <ce2dbad5-cbbf-4173-0eb2-5113227837b5@oracle.com>
 <d0f7600702ba073aad1056fbf93306adccf2ae9c.camel@hammerspace.com>
Content-Language: en-US
From:   dai.ngo@oracle.com
In-Reply-To: <d0f7600702ba073aad1056fbf93306adccf2ae9c.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SCZP152CA0006.LAMP152.PROD.OUTLOOK.COM
 (2603:10d6:300:53::13) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|DM6PR10MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf280e5-bd32-44c4-5548-08db4033f6f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0AD/cYmtrbHSeSAa0hajpRw20QkH/BKGUAcWWC4NBXpbA2lX84SwpguaDyudkLIxL8Jc60HKgXzrefA7iofcoCCQsxFXM0TDFPVsd3BpbrKCIGVOXGWPsI9ulUzaB58DEAJgQNdZJugL7xa/cdWxHuKkz21O62x8OsqC14rjtBve8ERxvMFWHSEkKPH7/zY5QNIGN1rNY7dvpsXxO7nktk+rUhTZZzKknNl2udERYyMVI4JBOW1Wc4MuaBU+dRDhAL+fWpuDuMNDF5iTBAdPV2s7zwks/8oFczyjVdHqLCgT/f/09GxM+5xhM5isM9QNeUFjb1lKyvkNKndV78KVLh8rFRiwOtRuk5vMpjFhvgdO9ZdS+ftW3kqYgCZV/PL5XywPQnK54dJWUIBz6yj+0OhP3yLjU/B5FCcwPgDWzywVdB5XziyEC3uFf06cF/u3NT1fEQlCDP9CvEC89z5Ui4OSHbhjoueFcGODPMZ1pxRndEHZvVMTSAeg2blt5hJYHrTy3e0ESp6x/wyrjadzXkToEZOTLxed0BZ4DlFPtm5AhmKnUGxwY2+RFUzeUthWOubYQgJ8ENH7ckCNgBJPjWoQJJCo6UT+2WPGRfcmWQ3HCzqB04DAKG04h0rp74o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199021)(110136005)(54906003)(31686004)(38100700002)(31696002)(86362001)(478600001)(66946007)(66556008)(66476007)(4326008)(316002)(83380400001)(41300700001)(6666004)(2616005)(2906002)(53546011)(6512007)(9686003)(6506007)(8676002)(36756003)(8936002)(6486002)(186003)(26005)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVBqWWNFQVFKbUp0NkZDOEFsSTdFdzFvM3Q3eFpBdTAwUUV3V2VFbnFnVWhs?=
 =?utf-8?B?aVQ4QjBMczVKZjZCS2V4eE92MzRISzY5K0xkck9tS0N0NTBMZHdHenZoeGZ6?=
 =?utf-8?B?R3F6cnhiVlVjY1I0T1ZJbjRNdTN5QzV6VE1OSlRtZHFiUGpvUkh1eXRXVGxB?=
 =?utf-8?B?dzI5b1Foai9Xbmc4VHhQZWNiZ1NMcWdFaG9tYUtSREFKVXpjTnFtUzlHZ1Av?=
 =?utf-8?B?ZWVYRDVqV2ZsK2lEMXk0dENtZE4rOTRsZDVqdjNaMEhiV0phMmJsZEZWc0p4?=
 =?utf-8?B?bGRySzdjSHhJMjROZUtJOWdFZnZpTVcxM2JzMlBNdTVzRm1nc0FkV01halhB?=
 =?utf-8?B?OFBXZmRuREVrT3RpRlhYSWFCUExUZGgrOWp4RWUwN2J6ZjBZcDRsYjVOYk4y?=
 =?utf-8?B?U3djWUErZDRIQ3NvVGdiKzdTK1FqWnBtK2JGTG1SVHAyWk5HZWY4WjFlekRN?=
 =?utf-8?B?aTY3VjBFMVhCaFRBZXdUQjlOKzE3TmZnSVVVTk1JcUpncEVxOXRIRlRheFlt?=
 =?utf-8?B?R1k5M2k3YzIzWk0yN3pKakRuV3lDOE5tdEJ1c3h3bWJRdy9uWStmMTc3TDB0?=
 =?utf-8?B?NkxYSzI0Mk52Z0ZkZE9YUkxJZUUxaUhHSVZIU0FrbkVWeUthTk5iMml3Q2NS?=
 =?utf-8?B?M3kxNnpuaC9KWkhIdFpDVnd4cnlwN3hmajRrQm9sTnJyM1RNdFJhNFdTZUZz?=
 =?utf-8?B?c3Z1RmdLTitCZHJ5cExsZUZoOGxPQ3pGa1lmeGcyd2VTdVB2bUxCVTFYUkEw?=
 =?utf-8?B?U3Z5MkhVTFJ5VENLT2dlUU9rdVVBZzVSTUk4ZmJ3M2J3Y1JzZjlyeDBUa0dV?=
 =?utf-8?B?Z1ZUQUlwNHV2QU01WE5qNjMwQWxKSm1YTXhKMmxWcU04dC9FMkZIZFVXVlRv?=
 =?utf-8?B?QVU1cGNSWlFoa0pTY0c5SFp2eTUzdThGOHFuTm4yTVZUZnlPZmh2RXA0SURo?=
 =?utf-8?B?Qmp2UmxMU3E3R2VlZVkveU5hMXczNFF4SjdHZ2F5Y0w4MXRaL1IrR1Blamdq?=
 =?utf-8?B?cnZnUElOUUdzNGwvZUdDN1BLY2R0RllWTHVSNkk2UmZhQzFDc1Q0OTEwMis2?=
 =?utf-8?B?Y0VLQ0M1SUQ1dkU3QWJvWU1RWlRwUjQxVjZkdURrRWI2UmV6OVl6V1ZiaHpo?=
 =?utf-8?B?MGpXQkw0dXBsYUFHZVI3MnRJZWZlcWEzUVRkM3JPQlNpdStkeG9aRUJwTFlj?=
 =?utf-8?B?cWpaVkJkWjkvMHUrUEU0eVI2VXlKRUlrVlhWVkl5ZTV6eWlPZWdVRkEvWXZx?=
 =?utf-8?B?a2tIdHNHMUlvcW5aMDI4MkNaQVhRbUN2OW9rWlJWREZ0ZlQrajgxbXB5WDJH?=
 =?utf-8?B?ZEZLSis3VWdCVmkyalFGT01NcmJrWmdwditsVWhwMGJYSis0aEtHa0FTSHo0?=
 =?utf-8?B?amVSaEFFYmMyMHF6M0pEZFB2ZnlYalBNMUs1UmFGbktHb3EzZXc2ZG1laU9w?=
 =?utf-8?B?T2NYN1EwVSsxVEFSaWhFYVNQUlRBaG1TWUZMK2RYWVpWUmZVZ2l0M0hVYk44?=
 =?utf-8?B?clEzY0VtVzMvQ3dZbkljYnhITEg1dkpjMGNWZlFJdlJINHhPb0xMN2F1OWdD?=
 =?utf-8?B?bFNncUJsVjk1SWQ2YzlQajQvbEEzSEZEcHhaUkJEckVscWdKK2Z0TGJDTVZv?=
 =?utf-8?B?eWxUZjdyNmRDRCtRN0FtU0N4VnRhRHlKMHJqSnd5S1ZhUTI2bzhQMzRLN2NT?=
 =?utf-8?B?eHF5aHlBT3FqZ2F2TnJCMG9UWWJvbi9oV0FCSHNHblVTeGpKYUg2cXVBWDJ2?=
 =?utf-8?B?RXhIRVNQSlNoRFNiSlJBMlZuL3B4VkxPelVZU2dTWCtWcjhtc0pLQ0svcnly?=
 =?utf-8?B?RWVOVS9DNzBOSTFhQlNHSTFoNEQ3OEdyMisyMmw1NmJaSW9jejJlZk5pU0JC?=
 =?utf-8?B?TGRJcXY2RmdINU1DclNmdFRvL2dZeDZSaEVSY2JjbnJtb2pJZ2w2Q2NsbEVF?=
 =?utf-8?B?OHcrbnlJdzhjSGRDYXFCSXVjaEVrVFpVYWZGRWI0clFPMm4xNE1DaFordTZD?=
 =?utf-8?B?KzRjay85MmJJVUdVZUs5b0YxQ0t4ZUFXYWVXRzlZNGJvcTRBZktySnhRYmRX?=
 =?utf-8?B?MjVWdVBiSVVpRUZJWjRvTjZwVndKRnplbmwxRFYvZ3diRDJOVW9vOHRIUGF6?=
 =?utf-8?Q?//vEH4RZwBNQZ71kAn3j0TcL2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6xwsy2RWLgylQriivt0WWptYQ5WkE9W9Vjb1W3sPYDAJHUQkwFlmJfMsupX3JQo8G9Y5BtVizoq9YuYuMUOXSHtALaZznMkFoqK5BuIk8oAfSvPr/itQL89751fzJeDrJCX4OhSiOM4tbE+/P2CQ4DfQfRmfgBKi27M5mBt0eLBdsgsz5SkeOA7VGwmY3QGvzDUBtdtWFUycBO9CvkwVM634/pG7dXC4G84Q0UjPssG4TR5JMcqb7j+aw3tjZrZCzwaR8WLn4pzASbdnAQi2+1f3omqqJOPW/TDWY/vYydUM0XFO+78q9sVx5mOxMF07I9cU9obzR6gP9vCNBV/JODJJKwe4XMdm7wvePLRtYFA9nHOf5whls5wW/CgCZN39l4Ic/RhDOTA6Zw8OUvXR+yY0lc+8hAn9o911kyYXg3Ix86e7eeg9sR8cxqKDPwA7KsfhYweE9GZCI70ZXRZXw7V0YmSp+CaJygTHmgbmswxHmY08EOL9n/va9IULZ4QJERNF48Pvhw0jpZU2eLvrpJaLFuSSYG2gxvrKIYCNKO547SWmiBB22RPdTKSDMnw+Hl1mv9wp6vnJ1GnD/RkiTVejEoCx1j220IRMS8vhlfBwbhUP1qKtPjZBqvQmb/jIkrgLKFhNKy0j+Gf7llwcvkq4kk165Jx3vSWPlPGGOFwt2zs6GSJHQSPTznVmZMOWUERsoRrFeY/SS+3PjBTL3/sQkClm37/7DsNQYVwMjAJd4Y/BpyNXdJa7YxWN8iVooY5NGMjh7yVcTwbZ7nDvRl8ibxS2AinQAE1XhxBJbR74JxN4nQTjOQAPFrhpKOu+ZVxG37Vd2qwm2QauOI8Ctw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf280e5-bd32-44c4-5548-08db4033f6f3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 17:40:13.6554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ncqnb7tM97dwOCGvImJYHXL9GI0mG21d2jkhLA9q1PpHuHV6s3099+nlqbvF0xZRCp+XDk4on1eLEqezWYMjwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_13,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180145
X-Proofpoint-GUID: cTEZh4nWnOisMzojWK0WjL8qfIdtfI66
X-Proofpoint-ORIG-GUID: cTEZh4nWnOisMzojWK0WjL8qfIdtfI66
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/18/23 9:02 AM, Trond Myklebust wrote:
> On Mon, 2023-04-17 at 18:04 -0700, dai.ngo@oracle.com wrote:
>> On 4/17/23 5:23 PM, Trond Myklebust wrote:
>>> task->tk_rebind_retry is _only_ changed if the rpcbind server is up
>>> and
>>> running, and returns an empty reply because the service we're
>>> looking
>>> up isn't registered.
>>> task->tk_rebind_retry isn't changed on any request timeout. It
>>> isn't
>>> changed on any connection failure. It isn't changed by any other
>>> code
>>> path in the RPC client.
>>>
>>> So none of this applies to the case of a dead server.
>> Sorry if I'm not clear. What I meant by a dead server is a dead NFS
>> server and not rpcbind service. So in this case we get EACCES from
>> rpcbind and we retry.
>>
>>> It applies to the case of a live server, where rpcbind is running
>>> and
>>> accessible to the client and where, for some reason or another, it
>>> is
>>> taking an exceptionally long time to register the service we are
>>> looking up the port for (either NLM or NFSv3).
>> Yes, this is the problem that I'm facing.
>>
>>> So where are you seeing this process take 90 seconds? Why do we
>>> need to
>>> wait for that long before we can finally conclude that the
>>> particular
>>> service in question is not going to come back up?
>> 90 secs wait is for when the NFS server never come up and we keep
>> getting
>> EACCES from rpcbind for this whole time.
>>
> OK, so the 90s is completely arbitrary then, and was only chosen
> because it fits your particular server?
>
> To me, that appears to invalidate the entire premise of commit
> 0b760113a3a1 that we can rely on rpcbind to tell us if the service is
> present or not.
> In that case, I'd rather rip out the task->tk_rebind_retry counter, and
> just rely on standard hard/soft task semantics.

Okay, I will resend the patch that relies on standard hard/soft task semantics.

Thanks,
-Dai

