Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDF76787CF
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jan 2023 21:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjAWUcy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Jan 2023 15:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjAWUcx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Jan 2023 15:32:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30282526F
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 12:32:50 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NKEGn7024162;
        Mon, 23 Jan 2023 20:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QBfefzQNvOTeIXhtExd5S+nM6RZrQijCn4oCbjxp8+g=;
 b=SlNh7hJLv5Ot0eWpW4XWUINv25XGt098gfWWmxDn3zbn/XovacmGybsYyk+bdi3iljLv
 4ThHtQqYevgBAxt+M/QSjTk+KR0Uk9+e6QtiTFwPdTnbnFkfmKwEDjVtgNNnlWrlCdmi
 dBwKF1VOrmRL+y9qqZH57VMo/N9ScWJjVEyGhJE6CuRCOgA+h3oLPJt0UXI5VdeP1ZKk
 OmTNTMdrP2pWUV7TOFCk7uLDROlIS+8X4F0ft7MnuHBftlk1rux/P7/VegcnfkVk12uo
 ui3CctojqwCZrCWTSf3gQdDH2D9HM/mSr2Penu83b6Y6TaAyWQLVAsbOhOLgZOZkwQbT uQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86ybbv16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 20:32:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30NKSlwZ023151;
        Mon, 23 Jan 2023 20:32:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g426tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 20:32:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXvhiCtwVi6l92EMixqFFCha4TQ2HucKd3A7s3WsL+CgcCrU3zXAOo840zbDWIVsSAbvYLxKRlOOizw0XH5xtIRbEGTa1VjMbHi1OqxYDT68/OU01EPU66O01gJVdqbHJ+VOu9oIY+Ybgdi29cf4AbP0xn1rbrDrH3ZjH6CgPQ3NtH93NAaojyXc1nYoFq7NMfHiR/QeEgpxpIHp7hPoQbQsNGmSHn0ZqqF63ToIU2gGIEKuOuqmHzoLoDokFeX5bN/CFIZ5UjThMyrCNMq8NDt4LjuTXxZnz5U2ZKyCiQfbANDWYdFj1oRoTZAs9hMFwmhQ7aZ34W6RVrQmWIllwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBfefzQNvOTeIXhtExd5S+nM6RZrQijCn4oCbjxp8+g=;
 b=OTf032ab4csZDF14UCMETfpEqhkC3Jx+r9FSjwk2rhkFdh+T2Ro5nXGhmtOdxh1YJa4gM++mMdLjOSwU21nOg4p7+2cSfiLjVeYsjWB3v1wWw738X7r+9XgzCq5LvNBGA1+7Dgh2MZ0QiN8FkBo1/JfXy5pi4HC19iO0hXhyHDk3XCZClFz6mVkPptG5A3RGKcx8p8kLmaPR1+Uo1kRyP8LNWDOQdSqUacKLxjtwVF7JzJFWKHaSIiOtkVhs8bQ/Q33BN4Bqqg+Yi2IqNMJ+9cbu1jyH1OncZMi1xGhlkpcyRX7glc/PCHYzJ7CZLKrDj8N72k9LSvX++v/HZ8b9ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBfefzQNvOTeIXhtExd5S+nM6RZrQijCn4oCbjxp8+g=;
 b=FIkKRz+uU7OSFF9gRZutcItMgf0uLwjg0/hMefS6KI63syTBADn42Z7yGvL/pGWMOestF7lzlRQ7A8iAG6fjdfwJABq7lG3dwhiVwPP6+JGcDHThT+y2StiaPv7ISmDRNp4GLccpzmqoEwM0O8LvkuRGGALqoueyiMt0i3N93Ic=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH0PR10MB7028.namprd10.prod.outlook.com (2603:10b6:510:281::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.13; Mon, 23 Jan
 2023 20:32:37 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%6]) with mapi id 15.20.6043.016; Mon, 23 Jan 2023
 20:32:37 +0000
Message-ID: <eb1f4a5b-ec4b-94dd-9e91-58350e2d143a@oracle.com>
Date:   Mon, 23 Jan 2023 12:32:34 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks in
 COPY codepath
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>
References: <20230117193831.75201-1-jlayton@kernel.org>
 <20230117193831.75201-3-jlayton@kernel.org>
 <9bff17d4-c305-1918-5079-d2e9cf291bc7@oracle.com>
 <eb5a9fa65a8c2bcc257101c96f7fbbe18a3b74ff.camel@kernel.org>
 <3ff5458c-88ab-18ab-ebfe-98ba8050fd84@oracle.com>
 <3a910faf64ab6442fd089f17a0f7834dbf24cd41.camel@kernel.org>
 <68e2bff9-bf02-4b19-3707-be88b77d8072@oracle.com>
 <4577f120-9191-c138-299f-eeddc3652e8b@oracle.com>
 <80fd3e68dd5ed457bf38f4ff0a6086d568cc3cee.camel@kernel.org>
 <D14F7839-3E42-4592-BF11-4A19905D5AA4@oracle.com>
 <f52f1cbf-aed4-b0f3-2066-9aa67e2a6003@oracle.com>
 <71DC929D-D10B-4721-8327-301A7E65312F@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <71DC929D-D10B-4721-8327-301A7E65312F@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:806:24::20) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH0PR10MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd8fe85-a5de-4c39-c04e-08dafd80f75a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jdybZovCIdr37uiZceG2Gdxkm48IawKXFUOLK2WbqPbkzIGwfZV4nmzsEx5F0XWF9wBQPSoEvrTUoNcWaruFzn46tFDMO5u/1ijx450ArtZcLdj8K0aWtaoyMuhA72CRR0FHujvgZpZiNEangzKOSPG/+o+Vnvr/2BodDjU9z1csqnDSV7HbHZCmkK/JTgwWRyLq2OgYZP8dBF4USIomenScm1A0UKv9/KIceQGhwDtRCztQqy0EM2DM0dz/ZUzWNDr4/Q/5X5iSoENvfG0ebMf2kAiMVUl+yI55rsaEMUKi/CKER7JtCxPp6XjL3M+ETr0yL6If5soqXArt/W1ivrzQb8TMFHk7NpQGNA22EOa9arOw58SzVjZsHVAeKh6k/7F+oevidYYBE7XaoQgo68PbhRCdSJXiKWXz61UmMk6eEUqdNsydBeQ9eo8qtndbtLGi3aVPelZTv6/G60taZkHsdZKZKAsCWSncqm3V1vPXt/UHTlJiiYHz8CjJdjBhETrXXrrCaFMhnf9iQetnZNeLsLIxeWs5ugEo08Y8LBC7CobEBRtMRP44jUOSyQGlB7g4RoxB68Azdts953A2A4ShRhnhETbkg1hnvOmN34KSVKn1NzaWj0eQh36xAWIjp7azv5ZJWsTTBxBafS2ZDSfOBZyD0JQRKaXcp5lIHWYGgkRIvWj/rBzlKSpAF7hx3B3rMxOLoIm63guPvNmIwWLxSpzEcrjG5P0057bu3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199015)(2616005)(83380400001)(6666004)(6512007)(9686003)(6506007)(26005)(53546011)(86362001)(186003)(31696002)(36756003)(38100700002)(31686004)(41300700001)(2906002)(5660300002)(6862004)(30864003)(8936002)(478600001)(6486002)(966005)(316002)(4326008)(66556008)(66946007)(37006003)(8676002)(66476007)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y29TVVh4WUZQd3loRGVUaXd2RUJhU1RyS3dOOG1DZWJ6RUZsMGlUK0tnMVBF?=
 =?utf-8?B?VTdzVy8rNUh5ZmlHQ2lzZXkrQzBqQ0NobmU0cXJJbHRzbG01bEpwNGpsbTFB?=
 =?utf-8?B?QlcrYjBuNXpjd1dhUFR1Qk9HM05EQjF1SXgrUTc4U1crWW1lS2FpdnI5NXIw?=
 =?utf-8?B?eU9LQ0ZIQkR6MUVFYXZlSTNreTVFQVBpWUJzc0VqVWJiVTFkWGZERVR2NVR1?=
 =?utf-8?B?cm9vN3l3ZWQ3c21nSE1UY1BUaUxPQlNiRG5WM3d0YWdvd0hXLzI4dEl2Tm9Q?=
 =?utf-8?B?MFhWR0p0Y1ZWUTdjS1NTTU1vVCtFVnhJVkZZdjJ3RWFrM1VISzBwQmZPVUFp?=
 =?utf-8?B?cnhGeFQrM29jeUxsUkJYSnNpdzJRYUdkWXFTTTVlcGNCM1hKUHBOZzdvYVd5?=
 =?utf-8?B?OXBWV0QxVjRKcjNVWTlZOXhybjR6U1pkYVM1alhESHlGRCttV1BjN3lkN3RY?=
 =?utf-8?B?V3IwdWZlSUFOVnh4a1FqTHR1WFZUamhxVHMxdVNCbEs4a1RWcks2a09qVnZH?=
 =?utf-8?B?cStlZWZoMGFXNnViOG5RYlFObDRCVGQybWJueDBCNXdBQk50VWc2d21ydCty?=
 =?utf-8?B?VTNqNjhEcmxHUTJ6VmpUU0MvRFpoUTZZM25US3UzVGJJNFMxdHY3TUFEVDJG?=
 =?utf-8?B?TGxOSEVwQThUZHducjJ1N0xzVHY4ZWRUcUFEeGNKYzlLY3gyODhTYzZ5TUN3?=
 =?utf-8?B?QURYeGpBOTFnaFBnaFlFUW9SMnplN2FwWHd4QlYzWTJTUmxsYzRueXpDcCtL?=
 =?utf-8?B?SVlvZlE1QzlHbG8vWUh5NDZRR2J0b2lHNnNBVjZBQ2QyMzRJMzduYUR3bGl6?=
 =?utf-8?B?Q1RmSndXQWhISU5BUmJXQ3NQY3FPYnRrUHJyNGZvcHNwbEU0aDNtYnR4QXFx?=
 =?utf-8?B?aFZaOGxwUzFBUU0zRThFZ1RiM0RIRkN2SC9JdzZDQ2xsTWZKS1oyNENsZE1l?=
 =?utf-8?B?bllYL3kzYnBZOCsya3hYOTRkSVM1T3BNQS9rb2hCQktKVXBIWFBMUmIzU2p5?=
 =?utf-8?B?TDdxeWJDYXIvTjRtc1VxcGxMQjhFY1kySVB5L3hYQTRxTk5nek9SZlFtSUpI?=
 =?utf-8?B?RlhkU1h5SE9JL2ozVmFZMmQwMDI3WHRlc1pTdW1FWDg1WXJWbUxLUzJMaTA3?=
 =?utf-8?B?Y3BBR1lCSXI5ZnY3SW9lT0x1amxmWjBZZXlkUm9GYlloM1hIcUV0dHJnQ3JZ?=
 =?utf-8?B?NTFSbHJjNG1lLzh1WnF3V3JhY2wvZXJVenNtV1BSbmJQSkdDUjBBZCtWYXEr?=
 =?utf-8?B?N2s0MHh0TERjL2VJQU5raC9BbGVRSzROTFJ1NWNET0Z6RlNwVzZFak5IejZj?=
 =?utf-8?B?MVlZY1lZS1lWQ3J4RHByeGVoNGFKMDhia2h2T0dtdTlWTjd6VmRLbTFkOExF?=
 =?utf-8?B?V0VGQkVTSFZrUFM1TDQzZWxOV2hsWE40cXpuMFdWdnNLai9naStoemhjclVU?=
 =?utf-8?B?OE5XbnlPbU9Fai9DODhvVEtYSEYyVlg0M01WZTBzS0RVMWhMU2hkNGdLdWpB?=
 =?utf-8?B?QVlYTUsveXBEOUtoYXZVenprV0ZObWtXKzVyNS9YRkFScjkzcmFIR0dvT3lt?=
 =?utf-8?B?cHRDWGxYeVVDZWphOCs1d2pEY3RocmhsQkZNSFZOemlxWEh2WGtXSkw2djRu?=
 =?utf-8?B?USs0MkVtUDZvSkdtMVVKSmxBTVlBM05jdVZKL0M4NWpsMWZuK3BXSyt4bkx3?=
 =?utf-8?B?OERFR3gxR0Z4b0JqcGJoTStPdnlXTzZGZDU5TUM5VXBhcHJ5cmRkVERrME9p?=
 =?utf-8?B?Sy9RNmViVkF3QUg2bks1Qkplc205cm9nNitvN0FUdHNFTmVvUlk5UW9zWGlQ?=
 =?utf-8?B?aFdaRFdsdWloOHdQUzU3Yk4vMDVjeUFBVDd3dGk5cDlMQUtVMVY2NHRJVGN4?=
 =?utf-8?B?cExMb2VnWXJSMkh6SjAzazkwcnY3M3IraFM3M0c2anVueXNlZ2Nwd2FnUmgx?=
 =?utf-8?B?a00rRkt5dUFrWk9Ydk16WTV0eGYrV1E3UlVNa2t1TjROcXA3bFdqVEhUT2lv?=
 =?utf-8?B?d3RTemhFdHZ0dlZtY3dwcllxQ0JuTlFnWjBYVWlTeEdRdktOUk9Kb1hnQmdS?=
 =?utf-8?B?WDRPdms3QjFEak5YbE9zSGF4bXBzcXdmVVhIK0QzTGgzeCtDTDJxSVNLQTFw?=
 =?utf-8?Q?trbhwYdNjd5OossMp9J8QByoZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cmoUKJt6RRWW4tt1ivJjfwH0gBjNVn1llnzOHda4qE8HSzaTQsBs33aSqmCGCDxbxVNz4ssus32Ay95tYul5fV0IiCppM30PFkw+qs2IW8OwLvS2Q/uiyw+A8eAdtVFrjCMCuqTJnwRERXnwdKPixUXZ/v0fFVH2hOM59pwiIQt8zP7AyVhezmjHzrftfrUY+axZsRub0vQTFBgjLV720dXCGTt6KTG8A5XK4Z1bZsEYNVYWFDBgvEjfcmkMYkHVHhAJNHGOS2ukBTfPMACyMnMUc8AuY8rNCVj4hkceLa1sHqXTxjkCNjQ3Arizb7uEbPX5W8VX/XxVjzmoROHEuErMiGF9gF6yDCqiyuEGTleM/cZGL9jQUM4QlJ+IPmHm5QiN/mvqSdC4JlqHB88OWRgb16eZnvnvWVIjIuFRc8mygShM4w1qesFQ44bpnpTd1SYUtauDI2Si0rLsEMX2Ydh/N+vbXZLsrPcpXCxNlpLyvaN8MBLUrz29afvQLbxFmcVuCf6usnJ0QxCldnbV6BNTg0U0CUWQkG2FIdLJtL4X7Rd3o7aDFLgszqFRp7C5R8JFuzWx3NhEKv5n548G5AJtAyqPw/OcE3rWeWWQ9gZdr9/ILJUDsAPOjRosRYautHUn4pCGGyYtx05ikAFx2a6oSanKOEnt0QwSWay7lfUHR9WuEwgIinEWTULEeLAMmk+kCQw+64LZ/DJkERZVMzxGKnpM/gmX4+s58WYmt0g+P+zqqN+YLvNIk2jRRi/4QADPZfRpIAmnpO7NXvI5b3gXoDRkUrtpGp25pxyRvtdNSIGPLzr1W9L+9j2J7LLf
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd8fe85-a5de-4c39-c04e-08dafd80f75a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 20:32:37.5938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDmkIfZS9teWat7V8ZDhFnaxy54qeszI7mhdJcL6Oub0i//w/2ckePee0HOA6ndp8Pv/vPkz7LRYycO7iqqd6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7028
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230195
X-Proofpoint-GUID: TYmx0hVk9w-YvOLYh5WO88hFay7LcsXv
X-Proofpoint-ORIG-GUID: TYmx0hVk9w-YvOLYh5WO88hFay7LcsXv
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 1/22/23 8:45 AM, Chuck Lever III wrote:
>
>> On Jan 21, 2023, at 4:28 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>>
>> On 1/21/23 12:12 PM, Chuck Lever III wrote:
>>>> On Jan 21, 2023, at 3:05 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>
>>>> On Sat, 2023-01-21 at 11:50 -0800, dai.ngo@oracle.com wrote:
>>>>> On 1/21/23 10:56 AM, dai.ngo@oracle.com wrote:
>>>>>> On 1/20/23 3:43 AM, Jeff Layton wrote:
>>>>>>> On Thu, 2023-01-19 at 10:38 -0800, dai.ngo@oracle.com wrote:
>>>>>>>> On 1/19/23 2:56 AM, Jeff Layton wrote:
>>>>>>>>> On Wed, 2023-01-18 at 21:05 -0800, dai.ngo@oracle.com wrote:
>>>>>>>>>> On 1/17/23 11:38 AM, Jeff Layton wrote:
>>>>>>>>>>> There are two different flavors of the nfsd4_copy struct. One is
>>>>>>>>>>> embedded in the compound and is used directly in synchronous
>>>>>>>>>>> copies. The
>>>>>>>>>>> other is dynamically allocated, refcounted and tracked in the client
>>>>>>>>>>> struture. For the embedded one, the cleanup just involves
>>>>>>>>>>> releasing any
>>>>>>>>>>> nfsd_files held on its behalf. For the async one, the cleanup is
>>>>>>>>>>> a bit
>>>>>>>>>>> more involved, and we need to dequeue it from lists, unhash it, etc.
>>>>>>>>>>>
>>>>>>>>>>> There is at least one potential refcount leak in this code now.
>>>>>>>>>>> If the
>>>>>>>>>>> kthread_create call fails, then both the src and dst nfsd_files
>>>>>>>>>>> in the
>>>>>>>>>>> original nfsd4_copy object are leaked.
>>>>>>>>>>>
>>>>>>>>>>> The cleanup in this codepath is also sort of weird. In the async
>>>>>>>>>>> copy
>>>>>>>>>>> case, we'll have up to four nfsd_file references (src and dst for
>>>>>>>>>>> both
>>>>>>>>>>> flavors of copy structure). They are both put at the end of
>>>>>>>>>>> nfsd4_do_async_copy, even though the ones held on behalf of the
>>>>>>>>>>> embedded
>>>>>>>>>>> one outlive that structure.
>>>>>>>>>>>
>>>>>>>>>>> Change it so that we always clean up the nfsd_file refs held by the
>>>>>>>>>>> embedded copy structure before nfsd4_copy returns. Rework
>>>>>>>>>>> cleanup_async_copy to handle both inter and intra copies. Eliminate
>>>>>>>>>>> nfsd4_cleanup_intra_ssc since it now becomes a no-op.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>>>>>>> ---
>>>>>>>>>>>      fs/nfsd/nfs4proc.c | 23 ++++++++++-------------
>>>>>>>>>>>      1 file changed, 10 insertions(+), 13 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>>>>>>> index 37a9cc8ae7ae..62b9d6c1b18b 100644
>>>>>>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>>>>>>> @@ -1512,7 +1512,6 @@ nfsd4_cleanup_inter_ssc(struct
>>>>>>>>>>> nfsd4_ssc_umount_item *nsui, struct file *filp,
>>>>>>>>>>>          long timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>>>>>>>>>>>              nfs42_ssc_close(filp);
>>>>>>>>>>> -    nfsd_file_put(dst);
>>>>>>>>>> I think we still need this, in addition to release_copy_files called
>>>>>>>>>> from cleanup_async_copy. For async inter-copy, there are 2 reference
>>>>>>>>>> count added to the destination file, one from nfsd4_setup_inter_ssc
>>>>>>>>>> and the other one from dup_copy_fields. The above nfsd_file_put is
>>>>>>>>>> for
>>>>>>>>>> the count added by dup_copy_fields.
>>>>>>>>>>
>>>>>>>>> With this patch, the references held by the original copy structure
>>>>>>>>> are
>>>>>>>>> put by the call to release_copy_files at the end of nfsd4_copy. That
>>>>>>>>> means that the kthread task is only responsible for putting the
>>>>>>>>> references held by the (kmalloc'ed) async_copy structure. So, I think
>>>>>>>>> this gets the nfsd_file refcounting right.
>>>>>>>> Yes, I see. One refcount is decremented by release_copy_files at end
>>>>>>>> of nfsd4_copy and another is decremented by release_copy_files in
>>>>>>>> cleanup_async_copy.
>>>>>>>>
>>>>>>>>>>>          fput(filp);
>>>>>>>>>>>              spin_lock(&nn->nfsd_ssc_lock);
>>>>>>>>>>> @@ -1562,13 +1561,6 @@ nfsd4_setup_intra_ssc(struct svc_rqst *rqstp,
>>>>>>>>>>>                       &copy->nf_dst);
>>>>>>>>>>>      }
>>>>>>>>>>>      -static void
>>>>>>>>>>> -nfsd4_cleanup_intra_ssc(struct nfsd_file *src, struct nfsd_file
>>>>>>>>>>> *dst)
>>>>>>>>>>> -{
>>>>>>>>>>> -    nfsd_file_put(src);
>>>>>>>>>>> -    nfsd_file_put(dst);
>>>>>>>>>>> -}
>>>>>>>>>>> -
>>>>>>>>>>>      static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
>>>>>>>>>>>      {
>>>>>>>>>>>          struct nfsd4_cb_offload *cbo =
>>>>>>>>>>> @@ -1683,12 +1675,18 @@ static void dup_copy_fields(struct
>>>>>>>>>>> nfsd4_copy *src, struct nfsd4_copy *dst)
>>>>>>>>>>>          dst->ss_nsui = src->ss_nsui;
>>>>>>>>>>>      }
>>>>>>>>>>>      +static void release_copy_files(struct nfsd4_copy *copy)
>>>>>>>>>>> +{
>>>>>>>>>>> +    if (copy->nf_src)
>>>>>>>>>>> +        nfsd_file_put(copy->nf_src);
>>>>>>>>>>> +    if (copy->nf_dst)
>>>>>>>>>>> +        nfsd_file_put(copy->nf_dst);
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>>      static void cleanup_async_copy(struct nfsd4_copy *copy)
>>>>>>>>>>>      {
>>>>>>>>>>>          nfs4_free_copy_state(copy);
>>>>>>>>>>> -    nfsd_file_put(copy->nf_dst);
>>>>>>>>>>> -    if (!nfsd4_ssc_is_inter(copy))
>>>>>>>>>>> -        nfsd_file_put(copy->nf_src);
>>>>>>>>>>> +    release_copy_files(copy);
>>>>>>>>>>>          spin_lock(&copy->cp_clp->async_lock);
>>>>>>>>>>>          list_del(&copy->copies);
>>>>>>>>>>> spin_unlock(&copy->cp_clp->async_lock);
>>>>>>>>>>> @@ -1748,7 +1746,6 @@ static int nfsd4_do_async_copy(void *data)
>>>>>>>>>>>          } else {
>>>>>>>>>>>              nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
>>>>>>>>>>>                             copy->nf_dst->nf_file, false);
>>>>>>>>>>> -        nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
>>>>>>>>>>>          }
>>>>>>>>>>>          do_callback:
>>>>>>>>>>> @@ -1811,9 +1808,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct
>>>>>>>>>>> nfsd4_compound_state *cstate,
>>>>>>>>>>>          } else {
>>>>>>>>>>>              status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
>>>>>>>>>>>                             copy->nf_dst->nf_file, true);
>>>>>>>>>>> -        nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
>>>>>>>>>>>          }
>>>>>>>>>>>      out:
>>>>>>>>>>> +    release_copy_files(copy);
>>>>>>>>>>>          return status;
>>>>>>>>>>>      out_err:
>>>>>>>>>> This is unrelated to the reference count issue.
>>>>>>>>>>
>>>>>>>>>> Here if this is an inter-copy then we need to decrement the reference
>>>>>>>>>> count of the nfsd4_ssc_umount_item so that the vfsmount can be
>>>>>>>>>> unmounted
>>>>>>>>>> later.
>>>>>>>>>>
>>>>>>>>> Oh, I think I see what you mean. Maybe something like the (untested)
>>>>>>>>> patch below on top of the original patch would fix that?
>>>>>>>>>
>>>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>>>>> index c9057462b973..7475c593553c 100644
>>>>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>>>>> @@ -1511,8 +1511,10 @@ nfsd4_cleanup_inter_ssc(struct
>>>>>>>>> nfsd4_ssc_umount_item *nsui, struct file *filp,
>>>>>>>>>            struct nfsd_net *nn = net_generic(dst->nf_net, nfsd_net_id);
>>>>>>>>>            long timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>>>>>>>>>     -       nfs42_ssc_close(filp);
>>>>>>>>> -       fput(filp);
>>>>>>>>> +       if (filp) {
>>>>>>>>> +               nfs42_ssc_close(filp);
>>>>>>>>> +               fput(filp);
>>>>>>>>> +       }
>>>>>>>>>               spin_lock(&nn->nfsd_ssc_lo
>>>>>>>>>            list_del(&nsui->nsui_list);
>>>>>>>>> @@ -1813,8 +1815,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct
>>>>>>>>> nfsd4_compound_state *cstate,
>>>>>>>>>            release_copy_files(copy);
>>>>>>>>>            return status;
>>>>>>>>>     out_err:
>>>>>>>>> -       if (async_copy)
>>>>>>>>> +       if (async_copy) {
>>>>>>>>>                    cleanup_async_copy(async_copy);
>>>>>>>>> +               if (nfsd4_ssc_is_inter(async_copy))
>>>>>>>> We don't need to call nfsd4_cleanup_inter_ssc since the thread
>>>>>>>> nfsd4_do_async_copy has not started yet so the file is not opened.
>>>>>>>> We just need to do refcount_dec(&copy->ss_nsui->nsui_refcnt), unless
>>>>>>>> you want to change nfsd4_cleanup_inter_ssc to detect this error
>>>>>>>> condition and only decrement the reference count.
>>>>>>>>
>>>>>>> Oh yeah, and this would break anyway since the nsui_list head is not
>>>>>>> being initialized. Dai, would you mind spinning up a patch for this
>>>>>>> since you're more familiar with the cleanup here?
>>>>>> Will do. My patch will only fix the unmount issue. Your patch does
>>>>>> the clean up potential nfsd_file refcount leaks in COPY codepath.
>>>>> Or do you want me to merge your patch and mine into one?
>>>>>
>>>> It probably is best to merge them, since backporters will probably want
>>>> both patches anyway.
>>> Unless these two changes are somehow interdependent, I'd like to keep
>>> them separate. They address two separate issues, yes?
>> Yes.
>>
>>> And -- narrow fixes need to go to nfsd-fixes, but clean-ups can wait
>>> for nfsd-next. I'd rather not mix the two types of change.
>> Ok. Can we do this:
>>
>> 1. Jeff's patch goes to nfsd-fixes since it has the fix for missing
>> reference count.
> To make sure I haven't lost track of anything:
>
> The patch you refer to here is this one:
>
> https://lore.kernel.org/linux-nfs/20230117193831.75201-3-jlayton@kernel.org/
>
> Correct?
>
> (I was waiting for Jeff and Olga to come to consensus, and I think
> they have, so I can apply it to nfsd-fixes now).
>
>
>> 2. My fix for the cleanup of allocated memory goes to nfsd-fixes.
> And this one hasn't been posted yet, right? Or did I miss it?

I will post this patch soon.

>
>
>> 3. I will do the optimization Jeff proposed about list_head and
>> nfsd4_compound in a separate patch that goes into nfsd-next.
> That should be fine.

Thanks,
-Dai

>
>
>> -Dai
>>
>>>> Just make yourself the patch author and keep my S-o-b line.
>>>>
>>>>> I think we need a bit more cleanup in addition to your patch. When
>>>>> kmalloc(sizeof(*async_copy->cp_src), ..) or nfs4_init_copy_state
>>>>> fails, the async_copy is not initialized yet so calling cleanup_async_copy
>>>>> can be a problem.
>>>>>
>>>> Yeah.
>>>>
>>>> It may even be best to ensure that the list_head and such are fully
>>>> initialized for both allocated and embedded struct nfsd4_copy's. You
>>>> might shave off a few cpu cycles by not doing that, but it makes things
>>>> more fragile.
>>>>
>>>> Even better, we really ought to split a lot of the fields in nfsd4_copy
>>>> into a different structure (maybe nfsd4_async_copy). Trimming down
>>>> struct nfsd4_copy would cut down the size of nfsd4_compound as well
>>>> since it has a union that contains it. I was planning on doing that
>>>> eventually, but if you want to take that on, then that would be fine
>>>> too.
>>>>
>>>> -- 
>>>> Jeff Layton <jlayton@kernel.org>
>>> --
>>> Chuck Lever
> --
> Chuck Lever
>
>
>
