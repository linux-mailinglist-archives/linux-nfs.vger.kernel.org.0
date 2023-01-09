Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05A966309D
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jan 2023 20:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjAITmh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Jan 2023 14:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237627AbjAITmR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Jan 2023 14:42:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11D639FA6
        for <linux-nfs@vger.kernel.org>; Mon,  9 Jan 2023 11:42:15 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309JdM6u017439;
        Mon, 9 Jan 2023 19:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ezTApFCyV6HY5m5ESnRu2RHz3hcBq7Tn1iLom9r+aqg=;
 b=1RKxpc8KQ0aLKtdAploj7+ukVRmfoBe4H9hVzAsqixcsnGlgsdDNFFmluKUahnxC1FTT
 m7K4CSXcwpcTpfklEMqfbzKG9z4l5yE2NHxhgS0fQtd3MS7igjvfSItcIxJPjJojxWWP
 KDIsOPnr+MLP7DsJOMPICoL67cZtMiLv8oTdA8U7UfKgoogUZ5DGP1JyrdG8q5/LO+8P
 IsauULQ0FRv1RDTij8f6IzJo+LPhezIWgVgjFJgLjx47rf/hbAISqOn5tPrfBX87rXk/
 L/XIETSNysxvvdRxycu8yOEMdPx75Uh8mbsgHP7tDbCs44N/pqar6Tue9y3pKoia3nVt sg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n0s89809u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 19:42:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309I3egm004382;
        Mon, 9 Jan 2023 19:42:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy6afcmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 19:42:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMXKpYIy7anyQKCZtUWeT5Tuz9l+PQwFE2FdC3hz83bBSWydQGPCzLkTwchuVQoDlkxv4ARQsoBmhvwMbrPF+IC4jZA30g8iylnF4XOZVJogqzFrhTZcKAvdX97/2uhpV9Oy20KZon1fN3o6KLlg5yTpaZXj3hktKrPGIL/mUwFLe347Fq1eDkNK53tjIgGDdlfewh5LD8Qd7LeO7r7gZOI7uBAfPiEO5sYpKpbFyrkwvXOG6gLc4PHsZmsMNF2ZQLfXUuq+6NuPMBrM26i707sToOw0V/pTPLgLWZbqfpiVt+J2OgrhIOhJTFqmeydaeMH63djVP+GZ9plPACE3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezTApFCyV6HY5m5ESnRu2RHz3hcBq7Tn1iLom9r+aqg=;
 b=HeRcb86y7oSyK5Kz/ifvyy1Hpmv65KgQ1crOFUBH2Laraywwz4XwD2XcLwMojQZ2XHUyPlu2/1MTPn6DO1Ul2FN7JZP1QXq79clVoEEm8XQf4Ch6CMTrMzPu6q3PXx9USLHo1nqnIuOAKa6EWCB7JwiADgMp4gK02XOV42BcSxcBF761ORyJS3sVJiNKDkptDgM728dOGaXfOtZc7kBDaEebmjEYCQ1DSJfxRyUwg/KpptLSBNPSEnBId2mpAiychYG9GGpciERxheLnUnvFlv6EPC3hei7+CEtvKYT3UOtlwPRugPYcaNM4MI6Rd/QTjO8l8dphUjk68yp7/k7J6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezTApFCyV6HY5m5ESnRu2RHz3hcBq7Tn1iLom9r+aqg=;
 b=Vt3S9dgEhP6Gx4uWExfjNOz7dYPBsXPAy+9iHekuB2OcZ2VivgYSWQep3eFQFuQpYrB+nfxxsQmYEo8KKd90MB6bLRtUe43z1bGSrF2rt88T66tYd2LIiNf6NOymXKEDzMuMKdBARDTR5CkHm6hlA8pAZsUGzA/v4V8mbcjMW8o=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH8PR10MB6480.namprd10.prod.outlook.com (2603:10b6:510:22c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Mon, 9 Jan
 2023 19:42:02 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%8]) with mapi id 15.20.6002.011; Mon, 9 Jan 2023
 19:42:02 +0000
Message-ID: <53acdc8f-1913-1bcf-0f1d-267c6373ba18@oracle.com>
Date:   Mon, 9 Jan 2023 11:41:58 -0800
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
 <e46fdd1c-3a61-9849-e06a-f7df8dd78622@oracle.com>
 <CAN-5tyECjk5z8wsJ28GU_j0nL7eNwzv7Vt=dVc4UGvYgZqDYJg@mail.gmail.com>
 <CAN-5tyGdbhvNHXKRqxX48X3nvpUDPgfrM4++a2SPcuxJunkxmQ@mail.gmail.com>
 <85c49a4e-632a-dd5e-f56b-af28312dbb8b@oracle.com>
 <CAN-5tyEbbHVFGEBMN3o6UAqqimSL_KdtkGPfsotNW-WhXNj9XQ@mail.gmail.com>
From:   dai.ngo@oracle.com
In-Reply-To: <CAN-5tyEbbHVFGEBMN3o6UAqqimSL_KdtkGPfsotNW-WhXNj9XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:806:22::6) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH8PR10MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: bc244c2f-b93a-4f6c-7f1e-08daf279944e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BUhkMAbUgrEnw2wiOz2ncTK+IqMXKCPI1LL7XEunB/PA+OzrOhc/UWScZ4iZ0CNCAORym3sKq2TIw2o78ryNqmofbmNSQvraweAQ20UofZ510ZhyX9cjD3iac1sBJYWIS79ZIs/iPoyyRlsHyntH8/HoCun3q5MfwBfje8FHFbCoRAHJKYjkAKsyOA0psdn10r4Y4wExDB01aUjfquHbqtfKy5ECD+L0HTrqQqcNLYmrWGiVBdPNPvJRATsdsEu23WRXI4qrt8tiDSnVGIbkb1tkbBPltu3MItYaZZjPXEmL6ztBxrPss2ih/v82r6CpqMFUQdO5SYaDlXAvYjU5R3F3ECz1Siapqj9codZdpwan4aXAcXCuwFeMA6GzVJLbqvkLy8FggyV52ZTIsKuh8mi4G7GaWNLsAW2DkkKNEerqB17oi4unCbboN942R9kqdS4iKgF9i2eygPncuwxdiXDyRSdFbWQHRFYSq+9UAPjGgQuAtBIwb1qWVRiLNJJvZvV5M2KWP/YiphJUVeTIThsphEiZ9ipeDPz1gGdMJLt6Y6oOk8PKgMIW0npezRODpsCCC4Cv4mLkAh2UvJvNgXoqLmmKB56rWTor3G+UyBPp3zcJZW9vrsTWgAch+FJ7ciDV2rKmto1JVJLNXgOL7V1k8ONg1Ly/htPelJ3ko21Slbb3fFfUIAFfQYjRA5ih
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199015)(8676002)(6916009)(316002)(66946007)(66476007)(66556008)(4326008)(54906003)(30864003)(2906002)(5660300002)(8936002)(41300700001)(45080400002)(36756003)(31696002)(83380400001)(6666004)(107886003)(6506007)(6486002)(53546011)(478600001)(38100700002)(2616005)(9686003)(186003)(26005)(6512007)(86362001)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHl5cmFWMm81cDlYMStXYS9vOFVrbXB1Y2VZYkNCYlVwQ09rOHZvVzBmR05N?=
 =?utf-8?B?TXlBbTlpQ21oK1pXa0J1dy93WVU4MnY0VFRzaWpHR1dLUHBPNndXeWpmVkc0?=
 =?utf-8?B?L0NHcUhtT0VsQ2VPSWRGK0dHbUFaOElNNXVTZUk4MUljbldvVC9WREhrV21D?=
 =?utf-8?B?bU54WXhveVFLVFhNN3VwYlZFS1dVWWZTTkFlcUlsaDV6Qi9SR3NjNFJQWVJM?=
 =?utf-8?B?Si93VEE5UTdYblNoUEcvZC9kYlVhTzU1Rld4Q1ZYS002cDViMUhYK29qSjZl?=
 =?utf-8?B?MUR1Wlk2MzNleXhYUVg2dnBCNkdhc3F6NWszV2dVbDlrM25sVkJYSWdBdElq?=
 =?utf-8?B?OW5HazRBd0R0OWZkZTYvdlA1YXA4NXFVSWlQRTRyREtNVnFMR3pXZHpJeXJ6?=
 =?utf-8?B?Z3NCYm1mQkNWaWl4V3Z3djkxbzhidm95WlMwQ2c3ellpRjVUZ2dNb2JGR3cr?=
 =?utf-8?B?ZC9jYUM5eGw2YXc3K2dwMERDL2VMM3YvVlJ2My9MbE1KeE8rUUFDbHBpTzE2?=
 =?utf-8?B?bWlqVVlydkdjNVBtUHIvVE9qaEIzSWtVTUpIU0MvRkdUbWpqOG1xdThid1Q2?=
 =?utf-8?B?VS9qZzlvY2JGT0wxZ2FOczFWdVJEWWlzZWdqWTJpTFVOd0ZVTytFMnhVamlI?=
 =?utf-8?B?ZDFSZVRYM3J2cjdvMDhyeTBUSlA5Y25qblNsSWFCdlJJQVRBQ2dONTliUmRa?=
 =?utf-8?B?Z3BqTlRDMms4dEgwMEY0cDFHNXRIb1h3S21aNUt6dk90T3hiVW5PU3FRdTZw?=
 =?utf-8?B?VXN4Z2dnQkRIWjBGeUxBTFc4dVNqKzhiZjlVbFhrQVVxNVVVbnhDb2dYN2FW?=
 =?utf-8?B?OHNxQmNtTnNmWG1SYUJERjhvalRHV2NiNjVZbjZic1VrV0ZmREdEY3d2M29x?=
 =?utf-8?B?NnBML29oUDdkeTVXM1pHL0puaytXMHdkQ1RLQ3cxZkJEWjNMcUdhMnBjcWZK?=
 =?utf-8?B?MTRFb3dQbGtKK0k5L0NGbFVhTER6NVY1UDE0NzlDQlMwaHM2NktUQmRVakNZ?=
 =?utf-8?B?S28rSVBWNE4xeXRFbGtkTmtpL3BKSm42NHFwMEFHSGJVZXhNaCswOG5iaGRi?=
 =?utf-8?B?YUl5cUlJYzF0ZWdOeHVuQ1hCWldyRStsbVZWeWZIME1aRGZCMWUxUWd2ZVVx?=
 =?utf-8?B?cGltR3MreXVuZWpPampvVVQ3U0IrSW5ycHZuVHJDOGFkeHFVSDFiUFRVQ2Jt?=
 =?utf-8?B?RjkrTzBWRk4zVzB4R0tjRElOZnRPVndYaW8xeG1FMEE3RnFBTGJNR0UvbVNH?=
 =?utf-8?B?UTV0ZkxDMHNoNyswb1FqdFhITXNWZm1PV1ZUeUFlNzBxaVUrUEpQMk5Ba2hH?=
 =?utf-8?B?a3lXTHBhUU9wKzVXeWN3QS9ZMVhZMC93Tnh2c2JBUFBFYnJSd00yRENGRDE2?=
 =?utf-8?B?akk0T3BKbCtwWGhUQXI5U0lEL2wzVmRyeklEakRWOG03VGlTTGhQMStTZm8z?=
 =?utf-8?B?eGpiQ3dUOEVzSmczVXlZVXpDSjRsWVBZVFlybjVyUW5TUHQ3b292NTFuRi9V?=
 =?utf-8?B?UFc5R09ZTjVaNkViZWdpS1g4d09PT3Q3K005WUVTUjJzMk5zNmdRY3BjM1ZX?=
 =?utf-8?B?MkJKcnl5ZEN1bWQ2SlVRL09EQzNHN0I1SDBpQTV5aDFlRWZPZzRHSzNnT0sz?=
 =?utf-8?B?U2gvK3hiamYwNTdtQTBrd3NPR25nbmVYa1JFNW1qcnFWNCtOWHNoRStITkxE?=
 =?utf-8?B?UzFwcnJFNkxFVkdzVEtpMzQrVCtrc0c5RnZ2bUpEb3VTOHRUZW9WQnN2TWJ1?=
 =?utf-8?B?Z3dtNGNlZ1VPMEtaQTk1S2ZCanJWSlM3M25hZTZscDNHT0l3QWIrMHljVmRF?=
 =?utf-8?B?YnlEeUdNUDNTZ1FLT1g3ODc0Z3pvZy80Q28yKzd6YVJXSUhYZzRMUzI5SjIr?=
 =?utf-8?B?dzhxZ1FxeFpDTnVmaDV0T29LTXV2TG9GZkVnTHppKzNHcmRISzdCYUFzYXhM?=
 =?utf-8?B?eTlicjJERjJHbkdFVU5WNGxCS0JBcFI4d3VHTWdEdFdXT0k5d2swRHdXZ1VW?=
 =?utf-8?B?elYxdVFYbnF2TFVGb1BSTnFIQThnbHJPaExTdEV0MDR5eGtsR2UwbnRReWVN?=
 =?utf-8?B?eTJST3ovRGRUV2Q5ZWgxOGNmU2lWbUgzVmZNcXBWcTZmc1ZBTGV4Ymw1RXFn?=
 =?utf-8?Q?/yTOZP/15vyWGZIQLoJAHxJWb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lKGgUaErLLm+ug4wy3QWP0AlDxhnUXs3fK0okzOkW1REjb067MdqXiGlrM83b5ZgL9lUWqpf/rZkDb/l6OiVMiYr9iDI5B9gJ7tpvys7oqTWZmeIQmVRo11xAeityHrW/zD8Cbn2Ups9Q4xx8I3iLrMkaf8mc6aBIX0RCbDIZYXaP159rpXcaZaqTnth4IOwpgL/epwG4vI9iHywyiq5vCPbn1eumoyUJ7NiUDUW/Mk4C/wmfp/+vcrGS/yktorOO/7asRWZ5F+ZGw6c8hDHm55d55JWlJa13qjCwI+gbHUE65MZZQnVm2VqOtjdLUe2E5W354Vl1Ky7MmEjAmfpE7TeT+W3+JMCzMbDKJZdtEIORSjsZHSXyoPiIh8444KvkBjDw/ueK/fqko4pM03dSY1+vphns+QqkZaU68cnuRu9d19QdyOo5HrZMyFdIVbwt0wfCrUtK72PHkKeER01ndcLzrZeWXHC4wdLpKp0ZCaBHt8moF2RFfSqJ4c/cglTkSHLkgBMBjAm72fFa0/vf5gx/us23xThgsDKdID3yjiTgXMTEPduF1bGoQuTE56aykLyCphnouKISseoTa0U1h0SYz6xeBQP1a3GW8F6Q3hiE8jygaummbCYz2IZeQW29/V61mHdJZMayF6TvlveFxoEDVzRzTJp5+3tVVnb53pCTU6YbevLn9HkaHnZECxUnEAeV02O2v+o+5sIJfndXEG1LzGTdRbBt5DbIjFhh8BOoxDKhiBqewx/idcFdU+7A/SGzClJe/9MNiR+XpM7d5e58wuXsuRlsvxFhWBj3PtSOOakJTYZW4jE6DhAXC2k
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc244c2f-b93a-4f6c-7f1e-08daf279944e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 19:42:02.2764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3+ULUW+xPDsBvOFP99IpBaVmGQUJLbImTHeVp+FrUE0B8Y5SoMex0M2mSkXz7Ian/ywZd0F6BijLt0GvYMklQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6480
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_13,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090139
X-Proofpoint-GUID: eEzceRcrp2tSAZkDkRLBuiaFU7Worter
X-Proofpoint-ORIG-GUID: eEzceRcrp2tSAZkDkRLBuiaFU7Worter
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 1/9/23 7:59 AM, Olga Kornievskaia wrote:
> On Fri, Jan 6, 2023 at 4:23 PM <dai.ngo@oracle.com> wrote:
>>
>> On 1/6/23 12:11 PM, Olga Kornievskaia wrote:
>>> On Thu, Jan 5, 2023 at 4:11 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>>>> On Thu, Jan 5, 2023 at 3:00 PM <dai.ngo@oracle.com> wrote:
>>>>> Hi Olga,
>>>>>
>>>>> On 1/5/23 8:10 AM, Olga Kornievskaia wrote:
>>>>>> On Tue, Jan 3, 2023 at 11:14 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>>>>>>>> On Dec 18, 2022, at 7:55 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>>>>
>>>>>>>> Currently nfsd4_setup_inter_ssc returns the vfsmount of the source
>>>>>>>> server's export when the mount completes. After the copy is done
>>>>>>>> nfsd4_cleanup_inter_ssc is called with the vfsmount of the source
>>>>>>>> server and it searches nfsd_ssc_mount_list for a matching entry
>>>>>>>> to do the clean up.
>>>>>>>>
>>>>>>>> The problems with this approach are (1) the need to search the
>>>>>>>> nfsd_ssc_mount_list and (2) the code has to handle the case where
>>>>>>>> the matching entry is not found which looks ugly.
>>>>>>>>
>>>>>>>> The enhancement is instead of nfsd4_setup_inter_ssc returning the
>>>>>>>> vfsmount, it returns the nfsd4_ssc_umount_item which has the
>>>>>>>> vfsmount embedded in it. When nfsd4_cleanup_inter_ssc is called
>>>>>>>> it's passed with the nfsd4_ssc_umount_item directly to do the
>>>>>>>> clean up so no searching is needed and there is no need to handle
>>>>>>>> the 'not found' case.
>>>>>>>>
>>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>>> ---
>>>>>>>> V2: fix compile error when CONFIG_NFSD_V4_2_INTER_SSC not defined.
>>>>>>>>       Reported by kernel test robot.
>>>>>>> Hello Dai - I've looked at this, nothing to comment on so far. I
>>>>>>> plan to go over it again sometime this week.
>>>>>>>
>>>>>>> I'd like to hear from others before applying it.
>>>>>> I have looked at it and logically it seems ok to me.
>>>>> Thank you for reviewing the patch.
>>>>>
>>>>>>     I have tested it
>>>>>> (sorta. i'm rarely able to finish). But I keep running into the other
>>>>>> problem (nfsd4_state_shrinker_count soft lockup that's been already
>>>>>> reported). I find it interesting that only my destination server hits
>>>>>> the problem (but not the source server). I don't believe this patch
>>>>>> has anything to do with this problem, but I found it interesting that
>>>>>> ssc testing seems to trigger it 100%.
>>>>> It's strange that you and Mike keep having this problem, I've been trying
>>>>> to reproduce the problem using Mike's procedure with no success.
>>>>>
>>>>>    From Mike's report it seems that the struct delayed_work, part of the
>>>>> nfsd_net, was freed when nfsd4_state_shrinker_count was called. I'm trying
>>>>> to see why this could happen. Currently we call unregister_shrinker from
>>>>> nfsd_exit_net. Perhaps there is another path that the nfsd_net can be
>>>>> freed?
>>>>>
>>>>> Can you share your test procedure so I can try?
>>>> I have nothing special. I have 3 RHEL8 VMs running upstream kernels. 2
>>>> servers and 1 client. I'm just running nfstest_ssc --runtest inter01.
>>>> Given that the trace says it's kswapd that has this trace, doesn't it
>>>> mean my VM is stressed for memory perhaps. So perhaps see if you can
>>>> reduce your VM memsize? My VM has 2G of memory.
>>>>
>>>> I have reverted a1049eb47f20 commit but that didn't help.
>>> Ops. I reverted the wrong commit(s). Reverted 44df6f439a17,
>>> 3959066b697b, and the tracepoint one for cb_recall_any. I can run
>>> clean thru the ssc tests with this new patch.
>> Can you elaborate on the nfsd4_state_shrinker_count soft lockup
>> encountered when running the ssc tests with the above commits?
>> I'd like to make sure these are the same problems that Mike
>> reported.
> I do believe it's the same as Mike's:

Thank you Olga!

-Dai

>
> [ 3950.448053] watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [khugepaged:36]
> [ 3950.452509] Modules linked in: nfsv4 dns_resolver nfs nfsd lockd
> grace fuse xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> ipt_REJECT nf_reject_ipv4 nft_compat nf_tables nfnetlink tun bridge
> stp llc bnep vmw_vsock_vmci_transport vsock intel_rapl_msr
> intel_rapl_common crct10dif_pclmul crc32_pclmul vmw_balloon
> ghash_clmulni_intel snd_seq_midi snd_seq_midi_event joydev pcspkr
> snd_ens1371 snd_ac97_codec ac97_bus snd_seq btusb btrtl btbcm btintel
> snd_pcm bluetooth rfkill snd_timer ecdh_generic snd_rawmidi ecc
> snd_seq_device snd soundcore vmw_vmci i2c_piix4 auth_rpcgss sunrpc
> ip_tables xfs libcrc32c sr_mod cdrom sg crc32c_intel nvme ata_generic
> vmwgfx drm_ttm_helper ttm serio_raw drm_kms_helper syscopyarea
> nvme_core t10_pi sysfillrect sysimgblt fb_sys_fops ahci crc64_rocksoft
> crc64 libahci ata_piix vmxnet3 libata drm
> [ 3950.467923] CPU: 1 PID: 36 Comm: khugepaged Tainted: G        W
>       6.1.0-rc7+ #107
> [ 3950.469642] Hardware name: VMware, Inc. VMware Virtual
> Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> [ 3950.471890] RIP: 0010:try_to_grab_pending+0xf7/0x230
> [ 3950.472941] Code: 00 4d 3b 27 74 63 4c 89 e7 e8 65 f1 f2 00 e8 a0
> 23 0b 00 48 89 ef e8 08 c9 3a 00 48 8b 45 00 f6 c4 02 74 01 fb be 08
> 00 00 00 <48> 89 df e8 21 d5 3a 00 48 89 df e8 e9 c8 3a 00 48 8b 13 b8
> fe ff
> [ 3950.476751] RSP: 0018:ffff88805a6d71d8 EFLAGS: 00000202
> [ 3950.477839] RAX: 0000000000000296 RBX: ffff88801c701b58 RCX: ffffffff8a14d5b8
> [ 3950.479317] RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff88805a6d7238
> [ 3950.480799] RBP: ffff88805a6d7238 R08: ffffed10038e036c R09: ffffed10038e036c
> [ 3950.482319] R10: ffff88801c701b5f R11: ffffed10038e036b R12: ffff888057c3f6c0
> [ 3950.483847] R13: 0000000000000296 R14: 0000000000000000 R15: ffff88801c701b58
> [ 3950.485345] FS:  0000000000000000(0000) GS:ffff888057c80000(0000)
> knlGS:0000000000000000
> [ 3950.487056] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3950.488265] CR2: 0000563b65c0bcd8 CR3: 0000000024df4005 CR4: 00000000001706e0
> [ 3950.489802] Call Trace:
> [ 3950.490320]  <TASK>
> [ 3950.490826]  mod_delayed_work_on+0x7c/0xf0
> [ 3950.491692]  ? queue_delayed_work_on+0x70/0x70
> [ 3950.492645]  ? __rcu_read_unlock+0x4e/0x250
> [ 3950.493603]  ? list_lru_count_one+0x73/0xc0
> [ 3950.494539]  nfsd4_state_shrinker_count+0x3f/0x70 [nfsd]
> [ 3950.496149]  do_shrink_slab+0x49/0x490
> [ 3950.496971]  ? _find_next_bit+0x7c/0xc0
> [ 3950.497802]  shrink_slab+0x113/0x400
> [ 3950.498692]  ? cgroup_rstat_flush_locked+0x64/0x560
> [ 3950.499766]  ? set_shrinker_bit+0xb0/0xb0
> [ 3950.500589]  ? _raw_spin_unlock_irqrestore+0x40/0x40
> [ 3950.501673]  ? mem_cgroup_iter+0x14e/0x2f0
> [ 3950.502580]  shrink_node+0x556/0xd10
> [ 3950.503373]  do_try_to_free_pages+0x203/0x8c0
> [ 3950.504324]  ? shrink_node+0xd10/0xd10
> [ 3950.505109]  ? __isolate_free_page+0x240/0x240
> [ 3950.506104]  ? try_to_compact_pages+0x225/0x460
> [ 3950.507069]  try_to_free_pages+0x166/0x320
> [ 3950.507932]  ? reclaim_pages+0x2c0/0x2c0
> [ 3950.508756]  ? find_busiest_group+0x25f/0x590
> [ 3950.509710]  __alloc_pages_slowpath.constprop.120+0x59d/0x1250
> [ 3950.511047]  ? __next_zones_zonelist+0x6e/0xa0
> [ 3950.511997]  ? warn_alloc+0x140/0x140
> [ 3950.512773]  ? __isolate_free_page+0x240/0x240
> [ 3950.513787]  ? find_busiest_group+0x590/0x590
> [ 3950.514735]  __alloc_pages+0x43f/0x460
> [ 3950.515519]  ? __alloc_pages_slowpath.constprop.120+0x1250/0x1250
> [ 3950.516817]  ? __rcu_read_unlock+0x4e/0x250
> [ 3950.517763]  alloc_charge_hpage+0x138/0x310
> [ 3950.518681]  collapse_huge_page+0xfc/0xec0
> [ 3950.519575]  ? dequeue_entity+0x1fe/0x760
> [ 3950.520440]  ? __collapse_huge_page_isolate.isra.65+0xb80/0xb80
> [ 3950.521747]  ? _raw_spin_lock_irqsave+0x8d/0xf0
> [ 3950.522740]  ? _raw_spin_unlock_irqrestore+0x40/0x40
> [ 3950.523794]  ? __schedule+0x575/0xf70
> [ 3950.524620]  ? lock_timer_base+0x9c/0xc0
> [ 3950.525527]  ? detach_if_pending+0x22/0x190
> [ 3950.526500]  ? preempt_count_sub+0x14/0xc0
> [ 3950.527406]  ? _raw_spin_unlock_irqrestore+0x1e/0x40
> [ 3950.528506]  ? vm_normal_page+0xd7/0x1b0
> [ 3950.529378]  hpage_collapse_scan_pmd+0x8c5/0xad0
> [ 3950.530339]  ? collapse_huge_page+0xec0/0xec0
> [ 3950.531288]  ? hugepage_vma_check+0x276/0x2a0
> [ 3950.532266]  khugepaged+0x653/0xaf0
> [ 3950.533039]  ? collapse_pte_mapped_thp+0x7c0/0x7c0
> [ 3950.534069]  ? set_next_entity+0xb1/0x2b0
> [ 3950.534894]  ? __list_add_valid+0x3f/0x80
> [ 3950.535790]  ? preempt_count_sub+0x14/0xc0
> [ 3950.536681]  ? _raw_spin_unlock+0x15/0x30
> [ 3950.537529]  ? finish_task_switch+0xe5/0x3e0
> [ 3950.538481]  ? __switch_to+0x2fa/0x680
> [ 3950.539374]  ? add_wait_queue+0x110/0x110
> [ 3950.540284]  ? _raw_spin_lock_irqsave+0x8d/0xf0
> [ 3950.541246]  ? blake2s_compress_generic+0x741/0x1310
> [ 3950.542295]  ? collapse_pte_mapped_thp+0x7c0/0x7c0
> [ 3950.543353]  kthread+0x160/0x190
> [ 3950.544036]  ? kthread_complete_and_exit+0x20/0x20
> [ 3950.545051]  ret_from_fork+0x1f/0x30
> [ 3950.545836]  </TASK>
>
>
>> Thanks,
>> -Dai
>>
>>
>>>>> Thanks,
>>>>> -Dai
>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>>> fs/nfsd/nfs4proc.c      | 94 +++++++++++++++++++------------------------------
>>>>>>>> fs/nfsd/xdr4.h          |  2 +-
>>>>>>>> include/linux/nfs_ssc.h |  2 +-
>>>>>>>> 3 files changed, 38 insertions(+), 60 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>>>> index b79ee65ae016..6515b00520bc 100644
>>>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>>>> @@ -1295,15 +1295,15 @@ extern void nfs_sb_deactive(struct super_block *sb);
>>>>>>>>     * setup a work entry in the ssc delayed unmount list.
>>>>>>>>     */
>>>>>>>> static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
>>>>>>>> -             struct nfsd4_ssc_umount_item **retwork, struct vfsmount **ss_mnt)
>>>>>>>> +             struct nfsd4_ssc_umount_item **nsui)
>>>>>>>> {
>>>>>>>>          struct nfsd4_ssc_umount_item *ni = NULL;
>>>>>>>>          struct nfsd4_ssc_umount_item *work = NULL;
>>>>>>>>          struct nfsd4_ssc_umount_item *tmp;
>>>>>>>>          DEFINE_WAIT(wait);
>>>>>>>> +     __be32 status = 0;
>>>>>>>>
>>>>>>>> -     *ss_mnt = NULL;
>>>>>>>> -     *retwork = NULL;
>>>>>>>> +     *nsui = NULL;
>>>>>>>>          work = kzalloc(sizeof(*work), GFP_KERNEL);
>>>>>>>> try_again:
>>>>>>>>          spin_lock(&nn->nfsd_ssc_lock);
>>>>>>>> @@ -1326,12 +1326,12 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
>>>>>>>>                          finish_wait(&nn->nfsd_ssc_waitq, &wait);
>>>>>>>>                          goto try_again;
>>>>>>>>                  }
>>>>>>>> -             *ss_mnt = ni->nsui_vfsmount;
>>>>>>>> +             *nsui = ni;
>>>>>>>>                  refcount_inc(&ni->nsui_refcnt);
>>>>>>>>                  spin_unlock(&nn->nfsd_ssc_lock);
>>>>>>>>                  kfree(work);
>>>>>>>>
>>>>>>>> -             /* return vfsmount in ss_mnt */
>>>>>>>> +             /* return vfsmount in (*nsui)->nsui_vfsmount */
>>>>>>>>                  return 0;
>>>>>>>>          }
>>>>>>>>          if (work) {
>>>>>>>> @@ -1339,10 +1339,11 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
>>>>>>>>                  refcount_set(&work->nsui_refcnt, 2);
>>>>>>>>                  work->nsui_busy = true;
>>>>>>>>                  list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);
>>>>>>>> -             *retwork = work;
>>>>>>>> -     }
>>>>>>>> +             *nsui = work;
>>>>>>>> +     } else
>>>>>>>> +             status = nfserr_resource;
>>>>>>>>          spin_unlock(&nn->nfsd_ssc_lock);
>>>>>>>> -     return 0;
>>>>>>>> +     return status;
>>>>>>>> }
>>>>>>>>
>>>>>>>> static void nfsd4_ssc_update_dul_work(struct nfsd_net *nn,
>>>>>>>> @@ -1371,7 +1372,7 @@ static void nfsd4_ssc_cancel_dul_work(struct nfsd_net *nn,
>>>>>>>>     */
>>>>>>>> static __be32
>>>>>>>> nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>>>>>> -                    struct vfsmount **mount)
>>>>>>>> +                     struct nfsd4_ssc_umount_item **nsui)
>>>>>>>> {
>>>>>>>>          struct file_system_type *type;
>>>>>>>>          struct vfsmount *ss_mnt;
>>>>>>>> @@ -1382,7 +1383,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>>>>>>          char *ipaddr, *dev_name, *raw_data;
>>>>>>>>          int len, raw_len;
>>>>>>>>          __be32 status = nfserr_inval;
>>>>>>>> -     struct nfsd4_ssc_umount_item *work = NULL;
>>>>>>>>          struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>>>>>>>>
>>>>>>>>          naddr = &nss->u.nl4_addr;
>>>>>>>> @@ -1390,6 +1390,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>>>>>>                                           naddr->addr_len,
>>>>>>>>                                           (struct sockaddr *)&tmp_addr,
>>>>>>>>                                           sizeof(tmp_addr));
>>>>>>>> +     *nsui = NULL;
>>>>>>>>          if (tmp_addrlen == 0)
>>>>>>>>                  goto out_err;
>>>>>>>>
>>>>>>>> @@ -1432,10 +1433,10 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>>>>>>                  goto out_free_rawdata;
>>>>>>>>          snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
>>>>>>>>
>>>>>>>> -     status = nfsd4_ssc_setup_dul(nn, ipaddr, &work, &ss_mnt);
>>>>>>>> +     status = nfsd4_ssc_setup_dul(nn, ipaddr, nsui);
>>>>>>>>          if (status)
>>>>>>>>                  goto out_free_devname;
>>>>>>>> -     if (ss_mnt)
>>>>>>>> +     if ((*nsui)->nsui_vfsmount)
>>>>>>>>                  goto out_done;
>>>>>>>>
>>>>>>>>          /* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
>>>>>>>> @@ -1443,15 +1444,12 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>>>>>>          module_put(type->owner);
>>>>>>>>          if (IS_ERR(ss_mnt)) {
>>>>>>>>                  status = nfserr_nodev;
>>>>>>>> -             if (work)
>>>>>>>> -                     nfsd4_ssc_cancel_dul_work(nn, work);
>>>>>>>> +             nfsd4_ssc_cancel_dul_work(nn, *nsui);
>>>>>>>>                  goto out_free_devname;
>>>>>>>>          }
>>>>>>>> -     if (work)
>>>>>>>> -             nfsd4_ssc_update_dul_work(nn, work, ss_mnt);
>>>>>>>> +     nfsd4_ssc_update_dul_work(nn, *nsui, ss_mnt);
>>>>>>>> out_done:
>>>>>>>>          status = 0;
>>>>>>>> -     *mount = ss_mnt;
>>>>>>>>
>>>>>>>> out_free_devname:
>>>>>>>>          kfree(dev_name);
>>>>>>>> @@ -1474,8 +1472,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>>>>>>     */
>>>>>>>> static __be32
>>>>>>>> nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>>>>>>>> -                   struct nfsd4_compound_state *cstate,
>>>>>>>> -                   struct nfsd4_copy *copy, struct vfsmount **mount)
>>>>>>>> +             struct nfsd4_compound_state *cstate, struct nfsd4_copy *copy)
>>>>>>>> {
>>>>>>>>          struct svc_fh *s_fh = NULL;
>>>>>>>>          stateid_t *s_stid = &copy->cp_src_stateid;
>>>>>>>> @@ -1488,7 +1485,8 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>>>>>>>>          if (status)
>>>>>>>>                  goto out;
>>>>>>>>
>>>>>>>> -     status = nfsd4_interssc_connect(copy->cp_src, rqstp, mount);
>>>>>>>> +     status = nfsd4_interssc_connect(copy->cp_src, rqstp,
>>>>>>>> +                             &copy->ss_nsui);
>>>>>>>>          if (status)
>>>>>>>>                  goto out;
>>>>>>>>
>>>>>>>> @@ -1506,61 +1504,42 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>>>>>>>> }
>>>>>>>>
>>>>>>>> static void
>>>>>>>> -nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
>>>>>>>> +nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *ni, struct file *filp,
>>>>>>>>                          struct nfsd_file *dst)
>>>>>>>> {
>>>>>>>> -     bool found = false;
>>>>>>>>          long timeout;
>>>>>>>> -     struct nfsd4_ssc_umount_item *tmp;
>>>>>>>> -     struct nfsd4_ssc_umount_item *ni = NULL;
>>>>>>>>          struct nfsd_net *nn = net_generic(dst->nf_net, nfsd_net_id);
>>>>>>>>
>>>>>>>>          nfs42_ssc_close(filp);
>>>>>>>>          nfsd_file_put(dst);
>>>>>>>>          fput(filp);
>>>>>>>>
>>>>>>>> -     if (!nn) {
>>>>>>>> -             mntput(ss_mnt);
>>>>>>>> -             return;
>>>>>>>> -     }
>>>>>>>>          spin_lock(&nn->nfsd_ssc_lock);
>>>>>>>>          timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>>>>>>>> -     list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
>>>>>>>> -             if (ni->nsui_vfsmount->mnt_sb == ss_mnt->mnt_sb) {
>>>>>>>> -                     list_del(&ni->nsui_list);
>>>>>>>> -                     /*
>>>>>>>> -                      * vfsmount can be shared by multiple exports,
>>>>>>>> -                      * decrement refcnt. If the count drops to 1 it
>>>>>>>> -                      * will be unmounted when nsui_expire expires.
>>>>>>>> -                      */
>>>>>>>> -                     refcount_dec(&ni->nsui_refcnt);
>>>>>>>> -                     ni->nsui_expire = jiffies + timeout;
>>>>>>>> -                     list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount_list);
>>>>>>>> -                     found = true;
>>>>>>>> -                     break;
>>>>>>>> -             }
>>>>>>>> -     }
>>>>>>>> +     list_del(&ni->nsui_list);
>>>>>>>> +     /*
>>>>>>>> +      * vfsmount can be shared by multiple exports,
>>>>>>>> +      * decrement refcnt. If the count drops to 1 it
>>>>>>>> +      * will be unmounted when nsui_expire expires.
>>>>>>>> +      */
>>>>>>>> +     refcount_dec(&ni->nsui_refcnt);
>>>>>>>> +     ni->nsui_expire = jiffies + timeout;
>>>>>>>> +     list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount_list);
>>>>>>>>          spin_unlock(&nn->nfsd_ssc_lock);
>>>>>>>> -     if (!found) {
>>>>>>>> -             mntput(ss_mnt);
>>>>>>>> -             return;
>>>>>>>> -     }
>>>>>>>> }
>>>>>>>>
>>>>>>>> #else /* CONFIG_NFSD_V4_2_INTER_SSC */
>>>>>>>>
>>>>>>>> static __be32
>>>>>>>> nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>>>>>>>> -                   struct nfsd4_compound_state *cstate,
>>>>>>>> -                   struct nfsd4_copy *copy,
>>>>>>>> -                   struct vfsmount **mount)
>>>>>>>> +                     struct nfsd4_compound_state *cstate,
>>>>>>>> +                     struct nfsd4_copy *copy)
>>>>>>>> {
>>>>>>>> -     *mount = NULL;
>>>>>>>>          return nfserr_inval;
>>>>>>>> }
>>>>>>>>
>>>>>>>> static void
>>>>>>>> -nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
>>>>>>>> +nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *ni, struct file *filp,
>>>>>>>>                          struct nfsd_file *dst)
>>>>>>>> {
>>>>>>>> }
>>>>>>>> @@ -1700,7 +1679,7 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
>>>>>>>>          memcpy(dst->cp_src, src->cp_src, sizeof(struct nl4_server));
>>>>>>>>          memcpy(&dst->stateid, &src->stateid, sizeof(src->stateid));
>>>>>>>>          memcpy(&dst->c_fh, &src->c_fh, sizeof(src->c_fh));
>>>>>>>> -     dst->ss_mnt = src->ss_mnt;
>>>>>>>> +     dst->ss_nsui = src->ss_nsui;
>>>>>>>> }
>>>>>>>>
>>>>>>>> static void cleanup_async_copy(struct nfsd4_copy *copy)
>>>>>>>> @@ -1749,8 +1728,8 @@ static int nfsd4_do_async_copy(void *data)
>>>>>>>>          if (nfsd4_ssc_is_inter(copy)) {
>>>>>>>>                  struct file *filp;
>>>>>>>>
>>>>>>>> -             filp = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
>>>>>>>> -                                   &copy->stateid);
>>>>>>>> +             filp = nfs42_ssc_open(copy->ss_nsui->nsui_vfsmount,
>>>>>>>> +                             &copy->c_fh, &copy->stateid);
>>>>>>>>                  if (IS_ERR(filp)) {
>>>>>>>>                          switch (PTR_ERR(filp)) {
>>>>>>>>                          case -EBADF:
>>>>>>>> @@ -1764,7 +1743,7 @@ static int nfsd4_do_async_copy(void *data)
>>>>>>>>                  }
>>>>>>>>                  nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
>>>>>>>>                                         false);
>>>>>>>> -             nfsd4_cleanup_inter_ssc(copy->ss_mnt, filp, copy->nf_dst);
>>>>>>>> +             nfsd4_cleanup_inter_ssc(copy->ss_nsui, filp, copy->nf_dst);
>>>>>>>>          } else {
>>>>>>>>                  nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
>>>>>>>>                                         copy->nf_dst->nf_file, false);
>>>>>>>> @@ -1790,8 +1769,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>>>>>                          status = nfserr_notsupp;
>>>>>>>>                          goto out;
>>>>>>>>                  }
>>>>>>>> -             status = nfsd4_setup_inter_ssc(rqstp, cstate, copy,
>>>>>>>> -                             &copy->ss_mnt);
>>>>>>>> +             status = nfsd4_setup_inter_ssc(rqstp, cstate, copy);
>>>>>>>>                  if (status)
>>>>>>>>                          return nfserr_offload_denied;
>>>>>>>>          } else {
>>>>>>>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>>>>>>>> index 0eb00105d845..36c3340c1d54 100644
>>>>>>>> --- a/fs/nfsd/xdr4.h
>>>>>>>> +++ b/fs/nfsd/xdr4.h
>>>>>>>> @@ -571,7 +571,7 @@ struct nfsd4_copy {
>>>>>>>>          struct task_struct      *copy_task;
>>>>>>>>          refcount_t              refcount;
>>>>>>>>
>>>>>>>> -     struct vfsmount         *ss_mnt;
>>>>>>>> +     struct nfsd4_ssc_umount_item *ss_nsui;
>>>>>>>>          struct nfs_fh           c_fh;
>>>>>>>>          nfs4_stateid            stateid;
>>>>>>>> };
>>>>>>>> diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
>>>>>>>> index 75843c00f326..22265b1ff080 100644
>>>>>>>> --- a/include/linux/nfs_ssc.h
>>>>>>>> +++ b/include/linux/nfs_ssc.h
>>>>>>>> @@ -53,6 +53,7 @@ static inline void nfs42_ssc_close(struct file *filep)
>>>>>>>>          if (nfs_ssc_client_tbl.ssc_nfs4_ops)
>>>>>>>>                  (*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
>>>>>>>> }
>>>>>>>> +#endif
>>>>>>>>
>>>>>>>> struct nfsd4_ssc_umount_item {
>>>>>>>>          struct list_head nsui_list;
>>>>>>>> @@ -66,7 +67,6 @@ struct nfsd4_ssc_umount_item {
>>>>>>>>          struct vfsmount *nsui_vfsmount;
>>>>>>>>          char nsui_ipaddr[RPC_MAX_ADDRBUFLEN + 1];
>>>>>>>> };
>>>>>>>> -#endif
>>>>>>>>
>>>>>>>> /*
>>>>>>>>     * NFS_FS
>>>>>>>> --
>>>>>>>> 2.9.5
>>>>>>>>
>>>>>>> --
>>>>>>> Chuck Lever
>>>>>>>
>>>>>>>
>>>>>>>
