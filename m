Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8256E552297
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jun 2022 19:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiFTRG1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jun 2022 13:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiFTRGW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jun 2022 13:06:22 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2136.outbound.protection.outlook.com [40.107.100.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924041AD80
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 10:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yg7SKfkjYy48xSQCeTiaSMNgbwNwAPxR+mMjfEd+yWxaBJgKHxj1TS1KCstpx7xSi0hHxaPC1QtA5a2pvmF+urOXyMa/sKsiSo0GSJ91595C7fZAvzD52hCNcd7Ak8+hHC+sPzX1ALNGeAkWl9ebhRAe2CPo3UOe3JyA1miN29ueyYhabLXOqWrYJhxByVtSNAMKaQkEvaOzD/+ri4zfECnVHSNtde7FYZ7tK2cYKhXS+yZXxZVBUqUvvxthjMkC3cKGkklaBucNd59aS+61lrcqFbpDjif9RH7r9vJGJzUvrzuCaRpB5dw/IByO9kQg6gIC00UDKyS7G2Qup0B+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnOPWEHuITTrhPkLxJ5QdMi8fuSC7mOR/UAyraLH0RY=;
 b=V0OvQWOM4bBUC0Bpe+l5PpDYqzqi84Rx11Z2lKgqLt5Xvy7OUw/MuD58XjflzSp/JeR3HfCm9Vc9cWbt5vzMf/Wtj2XK+oZWp54K5h6RS0HoSfryS+b6fQ5cIfPqU2GvsrIWs+QMm7VuDvhJ86JgNnpNJl+Fdo0VkHlrxlYHzoFUp0rQ4JuvtpGfxSTYXOYXFOurc1bvb0ZXFkDOwdfKVgazbsnKbKivYSjRa8FL9++M+E9A6uoP48Acb5KLICYj2Q5+EvVG7sLTUV8fDGDSGhqqxD7XSbbColK9btfkCSj2Mlj/fW4adcoNj6f2OS+KKRgbQunkNltUWvFmOTe1lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnOPWEHuITTrhPkLxJ5QdMi8fuSC7mOR/UAyraLH0RY=;
 b=b2+IienJL/7trg9g2cFGIhMc5pv39aDMFtGo5IVFsfGD8Ej3HlwzzV58uKUUIXERZoor31FCnNhyFg99IWn/X80sHCEWTKsKjD8OGecsxli0vEwmHV1Wt1WsuGt/FRZ4inDX0lXXn3JXTSbmep1apaBlZdHVBp2ibeEuuFkXgvsQI6kAUHuS+J9ekqv9PJB5Qkhzg/Mv4/jDzwkyjWTc7xm50jQ/CMySYNJ01bFbV76wYX5BTH4k7z9WMxLex/uYBHYoCBXweGDi6KaiUuqclXw94Aalsnqu8P24DjeUkUzpvPXMiusFFqYLVBGM77CGTdfL2EiqWZ5QtYqeEzM6og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 BYAPR01MB5064.prod.exchangelabs.com (2603:10b6:a03:7b::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.19; Mon, 20 Jun 2022 17:06:15 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4000:7ba9:d4a:c339]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4000:7ba9:d4a:c339%6]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 17:06:15 +0000
Message-ID: <0faa0fce-52ef-de28-7594-6e93bb47fec6@cornelisnetworks.com>
Date:   Mon, 20 Jun 2022 13:06:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: NFS regression between 5.17 and 5.18
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
 <8E8485F8-F56F-4A93-85AC-44BD8436DF6A@oracle.com>
 <9d814666-6e95-e331-62a7-ec36fe1ca062@cornelisnetworks.com>
 <04edca2f-d54f-4c52-9877-978bf48208fb@cornelisnetworks.com>
 <ca84dc10f073284c9219808bb521201f246cf558.camel@hammerspace.com>
 <bb2c7dec-dc34-6a14-044d-b6487c9e1018@cornelisnetworks.com>
 <A04B2E88-9F29-4CF7-8ACB-1308100F1478@oracle.com>
 <46beb079-fb43-a9c1-d9a0-9b66d5a36163@cornelisnetworks.com>
 <9d3055f2-f751-71f4-1fc0-927817a07d99@cornelisnetworks.com>
 <b2691e39ec13cd2b0d4f5e844f4474c8b82a13c8.camel@hammerspace.com>
 <9D98FE64-80FB-43B7-9B1C-D177F32D2814@oracle.com>
 <1573dd90-2031-c9e9-8d62-b3055b053cd1@cornelisnetworks.com>
 <DA2DB426-6658-43CC-B331-C66B79BE8395@oracle.com>
 <1fa761b5-8083-793c-1249-d84c6ee21872@leemhuis.info>
 <C305FE22-345C-4D88-A03B-D01E326467C8@oracle.com>
 <540c0a10-e2eb-57e9-9a71-22cf64babd8e@leemhuis.info>
 <916910EC-4F57-4071-8A4E-FC21ED76839A@oracle.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <916910EC-4F57-4071-8A4E-FC21ED76839A@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::33) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56add946-ae38-42bf-b416-08da52df2f72
X-MS-TrafficTypeDiagnostic: BYAPR01MB5064:EE_
X-Microsoft-Antispam-PRVS: <BYAPR01MB5064CEC4220E5B28F282B9A8F4B09@BYAPR01MB5064.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHbB9Zg/UWWlXm8aFu/OBPm6OCiXReQpceb8kFsOZmj/pPEHvQRW4C+Ogkodi5IK2QNk21BLKluy8jQIlssh7yXmAomCZS3WLqy30t+agxWwgjx3ibb6I3U2KzuAMrCUY5gr0CDqOmncczqsvn2pRbZxi/NOJt9yArCzYY6U+CBVn6aucO0OBDzWm/KGsY/8TEmNLAUZ9aSVjOQFRApjrNXRQcaWHtjwzCM03cHIxKqHj5yQ6WJ6eFxBMy0qBR9gnUeyd7YORR972v/WkynKPI9LMdDl99o3CrScyy7RJSE0Ey2mNZgg7fZwSeBDUVUwSN/Zj4ABfQVQlStHrt6gcqDfa0Mtmpg8ccxBwWc/BfJlJjvhZQSmHzYTz08U4x06s9NzoqmnlWLeIFhc9pP1x0EJYNu2HWhnequxuIotq7td7K3TqMwWXmsRaMDhQ+5jq/65IRfcqdtKu2PxR+gwLuhuYgvYCDEaTeEjNl7+zJY+2Y1Tqm1xTo34tFk4oETOtfDH/4HaIadQK/9gyIBrY9J9PA2IRbLI0lVpaS+v6h45xJhQMtVRL2zxbdz2UE/r8WyDU6/bM+SkglQO1EcBcsVEKiMPI6IEvMVjov0CECu7AMbPY3K9AWdKw/RM/RMsQ7i5V28TGluFvQ3tBzsR1zIGQ+gN6cJU0ipBodqfpdD5L3YptVjZAc1KehSM6Lzs7sbf0GuM2KljKk12gyx6Gq8txicVheNmHFZFiMRxtcPrieXCYpkpZpWd3C437KNm8jnwx2VSXsRIOXhzgowDqiRJw0rXXQ4Zlp2/P6OjPdI//fugKj55ftq6I34Opf5U5BPleVRzF58HFPCwDsRiHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(39830400003)(376002)(136003)(396003)(86362001)(38350700002)(41300700001)(186003)(2616005)(38100700002)(26005)(83380400001)(31696002)(6512007)(54906003)(31686004)(8936002)(6486002)(53546011)(2906002)(4326008)(5660300002)(8676002)(66946007)(66556008)(44832011)(66476007)(36756003)(316002)(52116002)(478600001)(6506007)(110136005)(6666004)(966005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmpKMzlvd3VEZEVOUXJWc3pLUS9DQVFpOEtlVzNLL0RPNVV0V2gvb0x4TU16?=
 =?utf-8?B?Q2pBNTBMTnduNFRMcks4NW80SWFxajJUYW1WeHRJL2Q5aldHR2pxNlVUZmVX?=
 =?utf-8?B?dnY5bFl1N1dobFJtbDR6TGRIZ2o2REtuMGYzUlJ4c0dvam00ZHdZTUxJOUxU?=
 =?utf-8?B?NE1HUksxbjkxODFyN2o2Y1dYOElMdG1mUk1SN1dTUXBGOEZuTlg1K1FaT1hh?=
 =?utf-8?B?WkpKUEpmMDE1Rm9uUTl5d2hIZzZnYlArbmk5Q01lQUNUMS9rSGJUWTBla283?=
 =?utf-8?B?MkFpYnUwcmFTN3JLM3Zoa05JejQrNFNuOUhiUWd3WmswU2krSEFPZ1pIR3Fv?=
 =?utf-8?B?bE9kMUg4dFRvck41NTc5SHlzV0lrWWlaYUJOWmlydVlLeFIxQ1gwWWw4dktH?=
 =?utf-8?B?UTE2d3ptRXI3dGdzQ2sxTlZ5REY5K29raFNzV3k0V1JNaC9XRXRzcE9uZkp2?=
 =?utf-8?B?a2lGN2poR2tZTGtaR25sVHFaM0NseGd1QldET3hxUzVhVmJNZzRaTWNmOU5V?=
 =?utf-8?B?blZLTnJiNW4vS0RHcHBCWXFtaXVJSG1uV3c1aHpkYXZPbTRXN2kzQ2hUS2pF?=
 =?utf-8?B?YUNQYytqOWdrRDR2Z2FQc002dEdZWmtQa0hIbDV5YUNyMGJNMU9DU1F2TWxW?=
 =?utf-8?B?aHdxWEtETDRYMk1sd3ZiOHNKQktoMEJyU0RudFpkcEFLRGlZRis0dW54NnpY?=
 =?utf-8?B?ZVhDYWFuMVhjeGx2djRRTmZwZHE4TWd0S0RKSEpkZVB6eS9LSFVRcDI1cnB0?=
 =?utf-8?B?RjB3OGVtNHo3bll2MUFMUFMyMjU2VitORlpMSDM4UTR5ckNBNjVHNDlJTXR1?=
 =?utf-8?B?dTdjZW1kQUlZQzhXSXlZWVBXc21XYXRJLzhFZ1k3Wm9RSUIxMnBsMVdtV1RI?=
 =?utf-8?B?M1diRlpYdzFKZ29jYml0SHBudnpRK2hsb2RFNTBsbll6aUNxSEN0T3FJRFF3?=
 =?utf-8?B?NXA0dHRXL3htVk50VEFENThFTzB1aU9mc2dDb2JXeUROMUZneDNVWnR5RTU2?=
 =?utf-8?B?VzRSQXpLMU1NVFoxcjArNmtndm9ybVlvUVYxTk5jQ0tRU1laMjdPOUhGdnQ5?=
 =?utf-8?B?NE5ML3I5SkxibTdGUUNqY0FjcHVuWFVMaFZtZ2EyL25SWGp4dDJYNUxNeFVV?=
 =?utf-8?B?d1VTbThtUlRET25SVzd2NWw1UVNGY3lxaDhtUis2a2hHeDRyZ1crQzVXeXI5?=
 =?utf-8?B?YTMwalNkVWc1LzFCWXRBdkp5MFdhMnRHVm9PajdvWmJhVTVIZ2N5emJwaTQ2?=
 =?utf-8?B?K09zajh6TGN1Yi9RT24zdnNDUm5CREYxK25INE5SSWJmUmRRTmF4Znp0dWxh?=
 =?utf-8?B?VCsxMFp4VW1vckJlMnF5RER2VjlmSVZIckdLSFo4L1VUTGpUMWlSem5ObFor?=
 =?utf-8?B?MGtONkMzUmg3TG9EVmhLUGJtMG9XZXRHZ1UzT25GYXVWWVdhVUdmTjVRR1ZV?=
 =?utf-8?B?L0tERGtWa3RXM0g4ZGNZNUFwKzhMTzkxR3I3VFdmeHV3emNZNk5MU25MV09Q?=
 =?utf-8?B?RHo5a0pWRDNWSk9JY1NWNGU0RGErL1ZhSFU3QnZScXI4bDU1dFFYZGhlNGwr?=
 =?utf-8?B?bTBKV1Bxb1FOSC9tRi84SVdMVjJzVUJJZzJpWWVoUmM5QXJJekc2bmE1L2h3?=
 =?utf-8?B?NFZvK2wxRnQ5NWFnOEFhZWZ0VlZKci9XNHhuR3Z1YjhxSjcvSGI1MWVRVXVk?=
 =?utf-8?B?dnJFRnpYYUNRai8zdU8ybWlCdWh3TUpQK3ZlOW05MDdLcjlmZnBTUU02MkVv?=
 =?utf-8?B?RUJSOU1HYmpNYmp4cFpudFdTbW1aaklVZXphUmVYRTRMUU5TaTR2cy9RcTUw?=
 =?utf-8?B?dmRGZXJxY05RL3lCRVJ1TjkwT1VIWnVzZXJsTDU1Q2hzaUozWElYZmg2RE0y?=
 =?utf-8?B?SndzaUZtMG14Y1JUUGFDbEtRRTJ0ZS95SmRQMHBHbkYzZmUweG5lZHc3dzhp?=
 =?utf-8?B?UWRlSUNJQnBySE5TeXk3K21KVXA5eGM5VXJoNmRndnVnc25ENG5DOWd4QWNv?=
 =?utf-8?B?cVdVZDFHSGtlYjhvcThBL2VhVC90dFlEMTdPVW8zNjRNZTlHbGg5SGdQZlpN?=
 =?utf-8?B?WWY4WXB3elpQdk8rcmg0ZGpZUTN3Z2xwTzNkenBCNEkybkxlSSs1OVM3Ry90?=
 =?utf-8?B?a212L05nQ25ZWXRKTU0rYmsxNTlSQVJYaGwvM3hsUEpsam03VVNtbHB0eDJw?=
 =?utf-8?B?ZHNsYmNsRHhwejB1K3B1aE1BdTk3bWZjU2N3S3hXWXJ5Z0RJVm5FK2VCMWgx?=
 =?utf-8?B?NVR0K3dlUFRlNFRJM05Lc0doZVBoS20zNTdtcFVxbU4vMldPMndUaUp4NEw2?=
 =?utf-8?B?QlAzWWd4ZUhJblpJMmJFYitRRm9WdzZPQm12TU1wamFQejRkdlcvVFpZeHR2?=
 =?utf-8?Q?CAq4GA0DWFpV/CADIjEdKDy9Cs4cKigA/OyZo?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56add946-ae38-42bf-b416-08da52df2f72
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 17:06:15.5295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4jzKbcd8FsZeh+UrxWHAMDoXtSH1ra1w5oi3808jF91P0IXM4TRKkHrjdtFuaLzfrEDPXq9Nk4znDYQXrIQ0LWEypBtt3J+rcOeXiZ1EStSRbW2dDGllx/To1xkkMAC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6/20/22 10:40 AM, Chuck Lever III wrote:
> Hi Thorsten-
> 
>> On Jun 20, 2022, at 10:29 AM, Thorsten Leemhuis <regressions@leemhuis.info> wrote:
>>
>> On 20.06.22 16:11, Chuck Lever III wrote:
>>>
>>>
>>>> On Jun 20, 2022, at 3:46 AM, Thorsten Leemhuis <regressions@leemhuis.info> wrote:
>>>>
>>>> Dennis, Chuck, I have below issue on the list of tracked regressions.
>>>> What's the status? Has any progress been made? Or is this not really a
>>>> regression and can be ignored?
>>>>
>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>>
>>>> P.S.: As the Linux kernel's regression tracker I deal with a lot of
>>>> reports and sometimes miss something important when writing mails like
>>>> this. If that's the case here, don't hesitate to tell me in a public
>>>> reply, it's in everyone's interest to set the public record straight.
>>>>
>>>> #regzbot poke
>>>> ##regzbot unlink: https://bugzilla.kernel.org/show_bug.cgi?id=215890
>>>
>>> The above link points to an Apple trackpad bug.
>>
>> Yeah, I know, sorry, should have mentioned: either I or my bot did
>> something stupid and associated that report with this regression, that's
>> why I deassociated it with the "unlink" command.
> 
> Is there an open bugzilla for the original regression?
> 
> 
>>> The bug described all the way at the bottom was the origin problem
>>> report. I believe this is an NFS client issue. We are waiting for
>>> a response from the NFS client maintainers to help Dennis track
>>> this down.
>>
>> Many thx for the status update. Can anything be done to speed things up?
>> This is taken quite a long time already -- way longer that outlined in
>> "Prioritize work on fixing regressions" here:
>> https://docs.kernel.org/process/handling-regressions.html
> 
> ENOTMYMONKEYS ;-)
> 
> I was involved to help with the ^C issue that happened while
> Dennis was troubleshooting. It's not related to the original
> regression, which needs to be pursued by the NFS client
> maintainers.
> 
> The correct people to poke are Trond, Olga (both cc'd) and
> Anna Schumaker.

Perhaps I should open a bugzilla for the regression. The Ctrl+C issue was a
result of the test we were running taking too long. It times out after 10
minutes or so and kills the process. So a downstream effect of the regression.

The test is still continuing to fail as of 5.19-rc2. I'll double check that it's
the same issue and open a bugzilla.

Thanks for poking at this.

-Denny
