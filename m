Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF31787BC5
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Aug 2023 01:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242140AbjHXXCO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 19:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243935AbjHXXBz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 19:01:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4811BD8
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 16:01:53 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJEZSS027036;
        Thu, 24 Aug 2023 23:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5MFCR5UjG3d00FfTJU8PyvIzL0iqMYQvc6WVkDpj3hA=;
 b=sF7KUHJRADCqEpt6pjlgy18f+WVxksayRV8OEQTMwffCOPnBxp0QtvzhJh/oty7xDHyC
 ta9AOsCG81mkHv+cy0lt5RR0s+6cgagW5cQWbOQjmh9VAQ9oWt21gzD4ZaB1M5uzhrg1
 ttOWyTPDjyvyh1De9XYjN85AUrXUzqTpiBqjzI6k5mJokI9zBTkzzHNZe2GBmc1Z4sFD
 nVla3zYF9M9dNQCdCPEZ2KZAY7hdOqyWIScuONWgW2jdVCSOsuYP+/uIs1I4dr9QMteF
 Zm5lfcxLcZFPIxrbAnmEsUAMa906v5WrLdfF67XEagfBdTl4ZGFOVfmDc8zQ4P7lyf1D 2Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20dd9aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 23:01:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37OMIZUq035981;
        Thu, 24 Aug 2023 23:01:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yq3gu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 23:01:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqIhW1Re9VYzXhgdgcZ5qBGuWlKEtA6fh2Lzf2Gw8aHUUkrH3s++CvfmXrsyGiE6i+9SYGMGXcoxa2VuE4Rtd3GDeQB//uQM5o+ro9+LFmJryKbcKFSwGNloeZmtOaYw3mzKN2D5sOIvSdHbiPI2YvoecYilBf5Hz8MuMRvPxpDmaqpU/+EyW2Bqenm5+s+4Et8kgMFf+XZLfxpg0OvZOqrLXHJJJh7oPGOcARidH3btG+jhepqU39KikXOsd95Rg6Fzvu5dKhycKhCjT2vz7O8QcHDjgLrCmJKp86uHifPMAirr1ivFr211NP4MIJfDYUvj/sCUvuYeByDc3z/WJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MFCR5UjG3d00FfTJU8PyvIzL0iqMYQvc6WVkDpj3hA=;
 b=GSykP1xpSzbiIZ0qrGDcLiTNeMxAXdY2iLh5XgzjrYJefq/6BzRHhSFiI0m3pUSp5HpgshI9RMoj4UYXDBSjOMM+6i0/KdNr1wpFeBMHuXj3Qool5vt+AkKyvSzfP/ybTQwCAsUYIjqLe6f4Vinsu9HBM6uP2Z2lkAfCMd049N87JlboccEcyIciIhO1efv7Y9KNcPecB56Kziup0DXrWdbWLwn4wMV6KClGx5TO1xqqC00oq3hOKCLXgwT2TsEZJZ9ilrj7tAlYHP5FcMUefh7rR0KH/1srrN7vwKuNc+5ZIEQFaez7/Zlo8ABcYr0fA5LA4EgIDOPXRwIYk5WH7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MFCR5UjG3d00FfTJU8PyvIzL0iqMYQvc6WVkDpj3hA=;
 b=BqNM3Vh8/AgWHQdx97ZVdzWNAKvDkrbzCl3FkS59RLM/wr9+DpQYoatM0e0kEs2v4JfPexr5do6oPk16gn0KaXJPL8EYd+4+9bevaAnwbxysVBZ+SyPL/M5aS/RN4Q1hm3Hp2Gx+4flrh3IVpOItiNFKfitFgJBL02i0ewhAvMo=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by DS7PR10MB5101.namprd10.prod.outlook.com (2603:10b6:5:3b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.28; Thu, 24 Aug
 2023 23:01:45 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2%4]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 23:01:45 +0000
Message-ID: <2b83101b-e04b-9fd5-07c3-95c103aaa203@oracle.com>
Date:   Thu, 24 Aug 2023 16:01:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/1] nfs42: client needs to update file mode after
 ALLOCATE op
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <1692892434-4887-1-git-send-email-dai.ngo@oracle.com>
 <c02190c39f123a16aeae70fd65a68fba4aa70b6f.camel@hammerspace.com>
 <067a68e1-cd7a-55c5-619b-d64266b5ada9@oracle.com>
 <af94f54e27b14e3129691d78ae1f439b33fb7733.camel@hammerspace.com>
 <24ae5b14-0fe3-15e8-37e8-e8aed0cdefa9@oracle.com>
 <5b0bc635-40bb-2c3e-28dd-b9a71814a7bb@oracle.com>
 <737abceb902411f583f731108fbc7eb235120eaf.camel@hammerspace.com>
 <F88C0F0D-62EB-45A2-8C70-477CD13D6EBF@oracle.com>
 <6a9e0757-b901-c694-1720-632f1a0339e0@oracle.com>
In-Reply-To: <6a9e0757-b901-c694-1720-632f1a0339e0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0004.namprd21.prod.outlook.com
 (2603:10b6:a03:114::14) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4270:EE_|DS7PR10MB5101:EE_
X-MS-Office365-Filtering-Correlation-Id: 6961a600-1d83-43fd-53b3-08dba4f616af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQ8Qt4799FBp9vDmNxfZn8cDnSrN7gt6q5DDaXO1YTI1QGHWc7lX/eE0VkRPx/mVK6UuttdCOUj67EjUDT1Z5Nufprn7BRBrSAPuMEB7fbj8KnqRhtKCE6nAWDcxqb4fXoVXMIe4tk6XbvqIqCg52xMAmAmMEswJjk74urEuLQaLnPcdGZRkhmM7426k7h8fLbRGSgsHrjyWpZE6YTHEI7w5FS9Ke6y96FREPj6ksvGguGNULWMrshg/6JtdLgh1d3qJgGWmiIRMcXB53Nyz6TA5UbdxGShlZfDXBJwVHQlVuQqDTcJRu/K6oE+S76O1tYho7IyJz9+ESPU+pWkfzEoANmvFOyPKpEV20Y3pBJgnQ5Nit7EopsYiVXQVwKzYz/oBlWOJouKUsZ/To8AZmwNozJysGULmgEZnWhx/zvKNc5ow0x8SYz1I3kSXY8koyAyc0nT6fI1K6KuiDc9d9x6+AK1kX6BEn42Dm6lGuqXnK4/uXxkvcGjmCAShN37V/G2/XegYOGvJPpyb7HV7rOP7Ow1MtK/7XANqLDKlT1AntPiGNY65kKIEgQYhLG9dfjXXALpGiCInAvHxIJry7S2NQsl7hg4g9OmRZw1FXG5BeEssFRWqFqaOI/5Bmbss
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199024)(1800799009)(186009)(31686004)(31696002)(86362001)(38100700002)(36756003)(6506007)(6666004)(478600001)(6486002)(5660300002)(54906003)(316002)(6916009)(2906002)(4326008)(8676002)(8936002)(26005)(6512007)(9686003)(53546011)(83380400001)(66946007)(66476007)(66556008)(41300700001)(15650500001)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUlDSVZZdStUK3QvUGxvRE1VY1ZuVWdpeUVrNi9zazlaekVSSW9IbXZVN1FH?=
 =?utf-8?B?V1JkUUdqNzdxR0JBcHNSNENVNnV2b3Q1c2tPSjBBaHJSK2VSNnUwYVJHNTAw?=
 =?utf-8?B?QjNBRlRseHlNTkpTQTNiRFMwdXk1SlNhazduVXNpdEs0OWR3d1k4QUxUQ3lm?=
 =?utf-8?B?OTRrZnh0dDBOM21aV3JzNFZLcHJyZDhMd3pFVzhLdHlSVHJWOEN3aGxlRE5x?=
 =?utf-8?B?K0lMbjJmWDZFU0lxWmM3NTJBZjBoL0lFSmpKTExPM210aTIrN1gva05lenZC?=
 =?utf-8?B?K1hCaHl2eGtJa0syWmROcUFMOEdyOVZyUkdsTXVWVGRsbUFPeFhEakM1ZVlq?=
 =?utf-8?B?Q3JSbGRyRE96SnZOSlBuYXYzcUJ6TmVQNi9zOFE2dlhUTm5kMHNvdXJWMUxr?=
 =?utf-8?B?aTJoeUQ5UlhBYXNTZmxkTTQ1Z3REMElyNGo5NU5zMURIa0pvT0NhU1Yxa0FX?=
 =?utf-8?B?amlHVS82ei9xa2dGRDY0dVJtY2R3QWRNVVJ3NU5mcnJ2UlFGdkdEQnZacDk0?=
 =?utf-8?B?TE9wRGl1RDVraVN4cHlKSjZvbnMxM3hLb1dDdnFqa3o4NlVJREMxUFhOSFJp?=
 =?utf-8?B?N0JyUWtKZ2N3TSthaElEUzdPY3dKQ3hYeUZKL2VCT3MyQW5EU1BnanQrdU9D?=
 =?utf-8?B?UVQxS2RjYnBveXFzWDBpVXMrU1U3cSs1Ni9waG5idXBrb1AvT0pjMzcxY3Ny?=
 =?utf-8?B?N3pBV0swbzZVcjA0Y2kzVkxaak1aaUpPUGp2RVI0eldZN3lQZTdOU3RyQXBV?=
 =?utf-8?B?aXFWRWdPK1VadDdDV0lKb1MrdnJRMG5MS3JYT21mLzZuNDVjV2pYWGtiQlRG?=
 =?utf-8?B?ZHFpekdoZVo5cVJ6Q0tkUlhGQ1dkelorMTFOUFNiSXQ5T2liMlM2MVh6RHhX?=
 =?utf-8?B?Y1JBc2pMMGZYTVFNSW43Z3VHUVltL2JnaUtDQWc5MzV5czdxYUJYMm8wTHdp?=
 =?utf-8?B?TklKM0hOdFg5R2dsaTZNOURyMnE5NHJ6RTliRFNOZ2t5WDdZU2U2cjQrRUtT?=
 =?utf-8?B?bml6WVc0cy9kVGtoUVJQeVdId0FLQ09pU0t6MEJCcVJFWG9GSzhUNnBMK2s0?=
 =?utf-8?B?SnEzbnZRTmtxM1ZGempHRVZuSnRnVFVEaS8yWXlEWXlyUDF1TWhDa1FWazYy?=
 =?utf-8?B?SGcrMERGOUFORzJsalNvWTBYemRiVzJjTVJjYnRhTlJiUHBaNm5UMzhyZWVI?=
 =?utf-8?B?MW01VTRsNkVkcmNhcnQ0MFlSV05HTGtiZUswTnFnSHZiTTloZHJDbEphbVhK?=
 =?utf-8?B?MUdLRDZCT0hMeDJoaFI1VDE0NWJWbUZjZG9OdHZiKzZ4WlJBNGc4TFN4Y2xh?=
 =?utf-8?B?aGRyQlA3d3JqMEN6WFhhazZTUlp1K01RS1JrTUc3RVJmYUlodVZ6MDJ2S3lz?=
 =?utf-8?B?RTVpb3VkUnZ3MmhDcGVuSjVkRU4rNk4vSi9nV1pHQnBRTVBBL0c5TE90djMr?=
 =?utf-8?B?RFpNcnRzSGp5N2IxS09Zc3IxZnl3R1ZsOHgrNi90ekVWdWVCVW9MUU14SURh?=
 =?utf-8?B?Z0pKZ3ljT1A4ZzlCZnkwZHlUNDZNQTFqcmR3VW1yS0VJZjdYa09lQmRoVmYz?=
 =?utf-8?B?NjUzS1h3NkorbENBcTZ0YUFlamFTZE9uUWhFdVp3MXBzSXByczRFOURjK3Zl?=
 =?utf-8?B?cnh4K002WlFEaDloMkVKSGRuWU1RMHRXcDVqNi9MNjZnd2lBK1ZvL0hOYm9p?=
 =?utf-8?B?ZzZnUkFHOHVCOVFKdW4reHFNUXNIVGJ5eGgvTUl1cStVRnJaTEw2Q3VtWmVL?=
 =?utf-8?B?dnJxdlVFVlhINFZwY3JyMjY3VklZSG9XWHZCcHRkck5kNkY1MjFIRnJIelZX?=
 =?utf-8?B?Qm9MUUlUdksvWmJhbkFrQlgzdnF1VEJtWWRDQmRLNklYUTVlUUc4VGtmTTht?=
 =?utf-8?B?MjRnVndEMGIyVlYvTExCSGxtbHJkY2FzL2IxMVkwd2lOWFRGVWR2eTRVSWM4?=
 =?utf-8?B?YnVIaEp5eW96WVFvcHdCcnY3L3hsOWI3YkJxd2tiOExFSjlwMlpiQ1IrNlFD?=
 =?utf-8?B?YzJyNWl1VVU1Yjlhc2dMeHZZNDdyTzhxVUZSR0J6RTQybUJ2UGlBVkRXRUg4?=
 =?utf-8?B?T2lBaGg4Y2E4d3AzYnExckhzWXdoMG5hWThWOEdiTE5raC9udTVWbVJJSTZW?=
 =?utf-8?Q?ps2wYvOyQ58A9w8hZzbqV+Pxt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YUkoR2cviqilpr0P/tLdyq4/OqQwrxVmSHH24nBp9aef2JdoUqjTDD3+DvNzWJgikaqF/3cxMiaHfwMNA36CJkSuDt5naRnw0/QDPmFTLenwIEjkJ4lhng2/p5ks/2/UwIy7h+Ws9GWZgOQZQqZWb8RFOPfneFCw3+VF+K6nq63Yz7HrkSjCCrBvVCFE5qQWT6X+VSkhplC9C7FaX9NhD/h5/92DlrGrHOkRHpMZ/Yvw6FrpNjTZBFw+vS/Mmtcv9m5U3zdvlRqiyhTslvAXtlcMV07o5wfHB5NaQH3GHuyRFbEm39wlIhfkBP6DAoG99X33T0simQ4AagNa5Yq+/MfLXP0J/Tvck0EQLIGktN2PZo3+tyj15VZli5rxrfNVsYAdEn58oZLMtzudgfNXK196NWXYeJw318ZSdeGh8kUnPfnipQJdwWjqdwVNHrYCHAY+Y8Z4pe1kDuAz73LuB7png21SvE8QBiUXA3bD05Q4wuDB5V7YoFAJTqJi52sVZrOSHydguxKTYKqlY0D32+I4kwy1ysRXhTb4DKqFmFtvR9f8ALC48A2jKalRMIlA+4mzMmUS437XXrV6iN8sChLmkw8t8ubtBv8RMAStj2ydPxPW+A2YZTDPR26wAe0dQfA/9rVyvJvY2kMuxrjdil7cI7ONfgtnLFHFRkWJGqP+WnXnO5ct0eK8rOuZrQBU0gJwgWvET+GpcNKGy6t4WahdufeHqyuhuLZIqyDlQ7NUV8tYW3liESEJ1R2+v4NTjE1iSAjCNlYoJDMJjVd/A5xKCTdI8ATMakao7nUdDWHEfAZw0sihP3FKIhihQu0ntTTzV/r3rwteewuZSaT4FQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6961a600-1d83-43fd-53b3-08dba4f616af
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 23:01:45.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzCPsTh9zgmsFcK2wK696QwoAsQxR734Bz9pRgL3o/hDXnViBTi/ZznPSB7yRsq4dAdILNj0WOKJDl8ABq3evA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_18,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240200
X-Proofpoint-GUID: D4Id7oJw9fX18Snmm-xqwyEfm17fx_w1
X-Proofpoint-ORIG-GUID: D4Id7oJw9fX18Snmm-xqwyEfm17fx_w1
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/24/23 3:26 PM, dai.ngo@oracle.com wrote:
>
> On 8/24/23 1:05 PM, Dai Ngo wrote:
>>
>>> On Aug 24, 2023, at 12:01 PM, Trond Myklebust 
>>> <trondmy@hammerspace.com> wrote:
>>>
>>> ﻿On Thu, 2023-08-24 at 11:42 -0700, dai.ngo@oracle.com wrote:
>>>>> On 8/24/23 9:38 AM, dai.ngo@oracle.com wrote:
>>>>>
>>>>> On 8/24/23 9:34 AM, Trond Myklebust wrote:
>>>>>> On Thu, 2023-08-24 at 09:12 -0700, dai.ngo@oracle.com wrote:
>>>>>>> On 8/24/23 9:01 AM, Trond Myklebust wrote:
>>>>>>>> On Thu, 2023-08-24 at 08:53 -0700, Dai Ngo wrote:
>>>>>>>>> The Linux NFS server strips the SUID and SGID from the file
>>>>>>>>> mode
>>>>>>>>> on ALLOCATE op. The GETATTR op in the ALLOCATE compound
>>>>>>>>> needs to
>>>>>>>>> request the file mode from the server to update its file
>>>>>>>>> mode in
>>>>>>>>> case the SUID/SGUI bit were stripped.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>>>> ---
>>>>>>>>>     fs/nfs/nfs42proc.c | 2 +-
>>>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
>>>>>>>>> index 63802d195556..d3d050171822 100644
>>>>>>>>> --- a/fs/nfs/nfs42proc.c
>>>>>>>>> +++ b/fs/nfs/nfs42proc.c
>>>>>>>>> @@ -70,7 +70,7 @@ static int _nfs42_proc_fallocate(struct
>>>>>>>>> rpc_message
>>>>>>>>> *msg, struct file *filep,
>>>>>>>>>            }
>>>>>>>>>               nfs4_bitmask_set(bitmask, server-
>>>>>>>>>> cache_consistency_bitmask,
>>>>>>>>> inode,
>>>>>>>>> -                        NFS_INO_INVALID_BLOCKS);
>>>>>>>>> +                       NFS_INO_INVALID_BLOCKS |
>>>>>>>>> NFS_INO_INVALID_MODE);
>>>>>>>>>               res.falloc_fattr = nfs_alloc_fattr();
>>>>>>>>>            if (!res.falloc_fattr)
>>>>>>>> Actually... Wait... Why isn't the existing code sufficient?
>>>>>>>>
>>>>>>>>            status = nfs4_call_sync(server->client, server,
>>>>>>>> msg,
>>>>>>>> &args.seq_args,
>>>>>>>> &res.seq_res, 0);
>>>>>>>>            if (status == 0) {
>>>>>>>>                    if (nfs_should_remove_suid(inode)) {
>>>>>>>> spin_lock(&inode->i_lock);
>>>>>>>> nfs_set_cache_invalid(inode,
>>>>>>>> NFS_INO_INVALID_MODE);
>>>>>>>> spin_unlock(&inode->i_lock);
>>>>>>>>                    }
>>>>>>>>                    status =
>>>>>>>> nfs_post_op_update_inode_force_wcc(inode,
>>>>>>>> res.falloc_fattr);
>>>>>>>>            }
>>>>>>>>
>>>>>>>> We explicitly check for SUID bits, and invalidate the mode if
>>>>>>>> they
>>>>>>>> are
>>>>>>>> set.
>>>>>>> nfs_set_cache_invalid checks for delegation and clears the
>>>>>>> NFS_INO_INVALID_MODE.
>>>>>>>
>>>>>> Oh. That just means we need to add NFS_INO_REVAL_FORCED, so let's
>>>>>> rather do that.
>>>>> ok, I'll create a new patch and test it.
>>>> This is the new patch:
>>>>
>>>> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
>>>> index 63802d195556..ea1991e393e2 100644
>>>> --- a/fs/nfs/nfs42proc.c
>>>> +++ b/fs/nfs/nfs42proc.c
>>>> @@ -81,7 +81,7 @@ static int _nfs42_proc_fallocate(struct rpc_message
>>>> *msg, struct file *filep,
>>>>          if (status == 0) {
>>>>                  if (nfs_should_remove_suid(inode)) {
>>>>                          spin_lock(&inode->i_lock);
>>>> -                       nfs_set_cache_invalid(inode,
>>>> NFS_INO_INVALID_MODE);
>>>> +                       nfs_set_cache_invalid(inode,
>>>> NFS_INO_REVAL_FORCED);
>>> No. The above needs to add NFS_INO_REVAL_FORCED.
>>>
>>> IOW:
>>>     nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE | 
>>> NFS_INO_REVAL_FORCED);
>> Ok, I’ll try again.
>
> I tried again with this patch:
>
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 63802d195556..5c6f15961a9b 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -80,8 +80,10 @@ static int _nfs42_proc_fallocate(struct rpc_message 
> *msg, struct file *filep,
>                                 &args.seq_args, &res.seq_res, 0);
>         if (status == 0) {
>                 if (nfs_should_remove_suid(inode)) {
> +                       printk("%s: FORCE nfs_set_cache_invalid with 
> NFS_INO_REVAL_FORCE\n", __func__);  <<== for testing
>                         spin_lock(&inode->i_lock);
> -                       nfs_set_cache_invalid(inode, 
> NFS_INO_INVALID_MODE);
> +                       nfs_set_cache_invalid(inode,
> +                               NFS_INO_REVAL_FORCED | 
> NFS_INO_INVALID_MODE);
>                         spin_unlock(&inode->i_lock);
>                 }
>                 status = nfs_post_op_update_inode_force_wcc(inode,
> [dngo@nfsdev linux]$
>
> and the xfstest's generic/683 still fail as with previous patch:
>
> [root@nfsvmd08 xfstests-dev]# diff -u 
> /root/xfstests-dev/tests/generic/683.out 
> /root/xfstests-dev/results//generic/683.out.bad
> --- /root/xfstests-dev/tests/generic/683.out    2023-08-17 
> 23:59:09.621604998 -0600
> +++ /root/xfstests-dev/results//generic/683.out.bad    2023-08-24 
> 15:47:40.684240872 -0600
> @@ -1,19 +1,19 @@
>  QA output created by 683
>  Test 1 - qa_user, non-exec file falloc
>  6666 -rwSrwSrw- TEST_DIR/683/a
> -666 -rw-rw-rw- TEST_DIR/683/a
> +6666 -rwSrwSrw- TEST_DIR/683/a
>
>  Test 2 - qa_user, group-exec file falloc
>  6676 -rwSrwsrw- TEST_DIR/683/a
> -676 -rw-rwxrw- TEST_DIR/683/a
> +6676 -rwSrwsrw- TEST_DIR/683/a
>
>  Test 3 - qa_user, user-exec file falloc
>  6766 -rwsrwSrw- TEST_DIR/683/a
> -766 -rwxrw-rw- TEST_DIR/683/a
> +6766 -rwsrwSrw- TEST_DIR/683/a
>
>  Test 4 - qa_user, all-exec file falloc
>  6777 -rwsrwsrwx TEST_DIR/683/a
> -777 -rwxrwxrwx TEST_DIR/683/a
> +6777 -rwsrwsrwx TEST_DIR/683/a
>
>  Test 5 - root, non-exec file falloc
>  6666 -rwSrwSrw- TEST_DIR/683/a
> @@ -33,9 +33,9 @@
>
>  Test 9 - qa_user, group-exec file falloc, only sgid
>  2676 -rw-rwsrw- TEST_DIR/683/a
> -676 -rw-rwxrw- TEST_DIR/683/a
> +2676 -rw-rwsrw- TEST_DIR/683/a
>
>  Test 10 - qa_user, all-exec file falloc, only sgid
>  2777 -rwxrwsrwx TEST_DIR/683/a
> -777 -rwxrwxrwx TEST_DIR/683/a
> +2777 -rwxrwsrwx TEST_DIR/683/a
>
> [root@nfsvmd08 xfstests-dev]#
>
> I don't think adding NFS_INO_REVAL_FORCED will fix the problem
> because nfs_post_op_update_inode_force_wcc(inode, res.falloc_fattr)
> will only update the file attributes with the attributes returned
> from the GETATTR in the ALLOCATE compound which currently does not
> ask for the file's mode attribute.

ops! sorry I loaded the wrong image.

With NFS_INO_REVAL_FORCED the xfstest generic/683 now passes.
I will submit the v2 patch.

-Dai

>
> -Dai
>
>>
>> Thanks,
>> -Dai
>>>> spin_unlock(&inode->i_lock);
>>>>                  }
>>>>                  status = nfs_post_op_update_inode_force_wcc(inode,
>>> -- 
>>> Trond Myklebust
>>> Linux NFS client maintainer, Hammerspace
>>> trond.myklebust@hammerspace.com
>>>
>>>
