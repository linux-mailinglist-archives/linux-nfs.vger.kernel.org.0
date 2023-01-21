Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CE1676997
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jan 2023 22:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjAUV3R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Jan 2023 16:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjAUV3Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Jan 2023 16:29:16 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA074233EA
        for <linux-nfs@vger.kernel.org>; Sat, 21 Jan 2023 13:29:14 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30LLPeJa016345;
        Sat, 21 Jan 2023 21:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=LOFnl/U7b9u+c30Y/1Dy99gX+Bc00aQ4AQVdakjv3q8=;
 b=qJANMVe4P1ysNbiBTGoUe8mp8d7dzTiej0fN5YLyzTsrPGvU2yD7rSimMrvZMHP29g08
 ivIM6MomALZtDW6oNdrJtdjXUwTljnCbOFfYfim2wyuaVlwigpiQD7S2zfSoeo10gwti
 vK82jpASRvR0z/ODff6Q0J72nm1UR6lBhVC6rum+tLfnyZVbKf+6Xsa0xTvIxAKoYnmz
 SISe29M97qeEoT/efOuUC3VOpi7gQ0sS5DoSRF1v1y8IPVKL/EHOvepbm3VZBfrADNxN
 nstUPsg5UMS82K2ICo1knx18/Qgqa9tdUQ9YlWlSQaLp2y7H/xfHBkwr4I7+y/QRzTo9 2A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86u2rsnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Jan 2023 21:28:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30LH4eUF034164;
        Sat, 21 Jan 2023 21:28:52 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g23r2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Jan 2023 21:28:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7vVNZXTl5/LxiFMhsmM8ET/kLjI+MTzdUrH4c38cnx3Om2E6m35h7S6EiN6P1WpJwEIipM7/qN/TQqiOv/+1XPvQVw8rEVx2agemuts1MkVVCHUwRMgBwnAB4ARSuylhxK5pmBkS+ziS+6rwHJnc6DFW6AShctqi5eRkrcwNAZ7i9u75o7K9Wa5A+0k5g6RUxGDfx3iOoTuC58N72GBKeXV+ikXY7EgjIUJhZ+3zCvnb4MdJKZiS2l56vAXKGwpyTEOLJtE0yjctXcS1ZriP/OwuQCUNiFqfVH/vH758WT/u0zUEAkXWaclg+YK13NwNnt31QPi+ZBy+VCn9iDmww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOFnl/U7b9u+c30Y/1Dy99gX+Bc00aQ4AQVdakjv3q8=;
 b=hLOXPZAUpjqWxYrMj14PxWPm2f5i2jfxafoAwk0XvWeq7sCx6KPvJQbchtzTVfEV9rEz8AsX7yJN4oNSqxSjCjujifUvefKtc8gYIFR8bVf61eewV7DA7zyaee1Yi8XDRhDEGLa1b7q/e0wGHjMWte8rVDR9NGQHcNwQOJgH8Xfr2NCLvBQxbywmGxDJrQyD9IjalXK9Qo2Gakm9Xvyn3ZQaOVe23sYYVtUxuKjf/HKHp5ZdXjOzHoUUkka7R8zDNI6jnnd023PVKQ/Z/0KHzfOOtxEByzUZJnMfRFioXhS2W4YnpO5ljUs4jX60i9JwprogSBp23GnAFfxouzHv9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOFnl/U7b9u+c30Y/1Dy99gX+Bc00aQ4AQVdakjv3q8=;
 b=bTv/D84jd8vdQm59hmUH1aPtV7Up/2ac1Zj9b4ur/W7HXS3kJEejol+kn0F3elZBsag9IE5EM9cGUyKtuRw0xHPghRU3bw3ZZYIFCl7Ln21L4m+5CQd1Pf1DX4uU45szxr7qgNnVlSI/gcJpX5XjExQN2XwneURbIWGVzWOfe9U=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ2PR10MB7059.namprd10.prod.outlook.com (2603:10b6:a03:4d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Sat, 21 Jan
 2023 21:28:50 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%8]) with mapi id 15.20.6043.009; Sat, 21 Jan 2023
 21:28:49 +0000
Message-ID: <f52f1cbf-aed4-b0f3-2066-9aa67e2a6003@oracle.com>
Date:   Sat, 21 Jan 2023 13:28:46 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks in
 COPY codepath
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
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
From:   dai.ngo@oracle.com
In-Reply-To: <D14F7839-3E42-4592-BF11-4A19905D5AA4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0146.namprd02.prod.outlook.com
 (2603:10b6:5:332::13) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SJ2PR10MB7059:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c6f55e-d11e-426d-37b4-08dafbf67c82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PG9QUbJ1O6QTL15cwJ/lPEFxKqeR3SsYsYzhmlL2iQ8cKiyDuROUGkzf7mHeLKs5oKox2ohB+AkGc6Q+BIzW7j2tZoNjUI1Vv2SkwbRKdGC2F9eY2DGibnG/ZAfz5vjiYlaFuxwJSgqJk+jAbWjXqUmXO7gyOcwj6M1B7e+VAXms2UkiKGH8kYZDCIXSdpeIUxa9Fyfo//LafG5gy0SaPSs+XvTI2iokaSOAOLeKU2AxEGjyQiVPkU0q0A/btuySej1a+3L0zb3rXsg1L8iW18qVDPgmkizT8YChFN7BJ2dzcj3oaAc1tU9w/JMr+m6XncivL0B7211LIOL3Ol65A252Cc6OI+M+Qn+s2UUwQLRe7cnh22HoQ1PABzwcj3tCf6r8bu2IlOkXzo3bVSc7WMSJw03XqMsC4tGD2dpNPkvzB+CeWZZN2o9kaiTBjH5A9Qr+JVvyn3QuFolvHOKhfbWmL563C4ZD09nMRJLws9ieJO/emEYm2ACgtJgxkqsdv5+W72LvBKmou2BkxD5KnKYbfXWXV6ILa7f4LVheEqx+obuyJI8YtSebf5YlYdhfsTzRhJqvGTq8kONqmImzSrx4de1Kpr6ZqFJUfUgKQgc3bu1A6gNI7m7RrmpGa/YbRniWbSjXFq7Cd/5+hRpbuDGe14iWJGiHyTTa8tSxcvIAkpaj8udOK47KL+efwtdKhtMIvtyNz1ygPNqcOHxgNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199015)(38100700002)(66556008)(316002)(478600001)(66476007)(31696002)(2906002)(8936002)(66946007)(5660300002)(41300700001)(8676002)(186003)(4326008)(2616005)(6512007)(26005)(9686003)(83380400001)(54906003)(6666004)(53546011)(86362001)(110136005)(6506007)(6486002)(36756003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXo0Z0NwTm83U09KTW9NaHRqelZ5cUtYTEprUGhRT0U2cEdXNlM5alI3Q2dP?=
 =?utf-8?B?UHUrMUFUNVJUUGF5WmxRQVN5dy9LZy9DSm9PVlg0SVZ4bFBpN29lcTFrcExT?=
 =?utf-8?B?cG9SZ1pYN0RlcDFBTnpMQ3RDaWFNd2FBVXhGZHc1eEowczB6eUpiYUFFUndX?=
 =?utf-8?B?OFdRaGEzMWVtbFJ6alFGMGlrMUV0MC9uYkZNMDV0WGVoTFpVMVBFOGFiakkw?=
 =?utf-8?B?bFJRVVBZcnVvVm5jeWI0RHFnQXpOKzB5dGdlTi9RRHBaYk1CT013UldvQy9H?=
 =?utf-8?B?Ym40ZUx6Q0ZyWW9zem1Jb0VucThVM2hNV3hIOUQ1N21obkJkY1FNQ3F6U3dq?=
 =?utf-8?B?a1FZQlVRUVM5dDE1SnVNZ0ZBNDIwcE02cTMzMWlya1cweVFwa2MvRzFXbjht?=
 =?utf-8?B?M1FIQ3BVYmVjVzBCT0hXQWkwdWxyd1ZaSmpndDhDeGtZZkIyUmZRNVp2M05E?=
 =?utf-8?B?Sk9ZTW4xb3d2VEo0VFltMFJlRmJpbUZ3dk5NT2dlRlZha29xY1MrVlJRa2Vu?=
 =?utf-8?B?MXd5eXFESGxrTlEvZjlOWGVoOHpwUXFjb2JxS1loUitEQi9tcEhLZ3pKck0y?=
 =?utf-8?B?bjRWUTNmaXFNWHZsbWFSVjlrL1lvOFBHSCtNN2xrSW1scmRZOFF0THZ5cEth?=
 =?utf-8?B?dGJ2QXpOZXZXeVptUDE2a1B6VjVFRTVDYjkzY0RyNmpLd3I5SjNBUWJhRDRq?=
 =?utf-8?B?bnNoY1h0Zlc1SE4wSmpGWTN6amZWUEdjLy8rSHdqQlljeVNOVy9mbXdITjZa?=
 =?utf-8?B?VGZqcGtORjFjeTNHS2JTb3grcnFNeW41WGZDekdhTXVEVjNYOGJGTkNLMGdt?=
 =?utf-8?B?WW5HSzg2Y0lKTHlqYUo0cmJzczVpcEpVTHBWSkh6YnVvOUpybGNoWHpVdUtP?=
 =?utf-8?B?WGllTEh1dHMza2NIT2hoMCtrRGJaYlZnUzJQOFRIWEJIVXo5L0RoaFJ1Y3FT?=
 =?utf-8?B?dGlBWVQ0QjdWY1RTakEybWxUMVBLUlFZaWMyd2dEZEFHdlFLWXB3b2QyVjlR?=
 =?utf-8?B?SUJUNHVMZSs4TGVEY2xHbHY3bjdhRTc1L2pnblpUYWEwM0hhd0ZaWEljcDJk?=
 =?utf-8?B?MDFIeG5mYUt4Z09RVzY2QzZ0THNDeXhzeGNib0ZQN0JEbVcyV2JjdkNoUkRC?=
 =?utf-8?B?bVNIcUQ5THFoQ2MrQVB5cHBRYktvT1VjKzlOYzUwVGVkZTBxUy9iUWZmYWw0?=
 =?utf-8?B?T3dDT2RFeHRiNW9XUnZONmJlUWFKRkdkb0lIdFNuOUt6Mm91aUFmTUw3REhY?=
 =?utf-8?B?dU9jZnNSQ1ZnWUdLTkZkSmJHZWFXUG5QTWh3QTBlNDhKdlAwUkhmb21zM05M?=
 =?utf-8?B?MWpsYk9uekR0c2lTOFZRYzRaRmdIeXg0NnMxMW5IT0dBVlY2ekVGbzJkQzJE?=
 =?utf-8?B?OTNWZHZhMkZzcGtKY0l2T00yMEhTMjdUNEsyZm9GNzlqeFBKdUMzSThBamEy?=
 =?utf-8?B?aThEeGluVUx0bTFmVWVNM3BZa0JrR05rOVk0czNJV3RnVmtPbHBxczVVWGVq?=
 =?utf-8?B?dFNZdENqVk9YaEJTRzlybiticmZPODNVWWlHV09qQ3RZQ2tuRytLc01BWWRK?=
 =?utf-8?B?dURwZ0dTRURrajFHVVNlaXQ4SzhSTzYrV3M4K1Frb3dYa0t5d2lhVEVLU2dE?=
 =?utf-8?B?UmJmZ2NaMDN3bC9tTDZ3c2U3RmlMNVpnN28wK3dHdEFTcHJTVXZraTJMU2J5?=
 =?utf-8?B?TXEremlZU0k5bEVZMWh4bzFsWWVJczQxaFZCZTRQR0MrQWhrdCtiaG9kVlNU?=
 =?utf-8?B?ckl2a2sxSGx1RG9KYXllanJNcWFhY2ZNbTh3R29CdTFUbFlrSW5oaE84WkJx?=
 =?utf-8?B?OXBtbkpWQVc1d0hLMk03cFIwR0Vwdk9PaWZheTFLaE56WlVWUGRRcXVzOEgz?=
 =?utf-8?B?SEttSlB0NkxHTE9qZDVqbG9qSUNyT3dzZHRlc1JLOG9IU3RqOTJBTDYxNjYx?=
 =?utf-8?B?NHd4RC95bFptQlI4TXFvREMzbVowRXozeW1HOUtTdVRtaTBoajNxdTRZVzNH?=
 =?utf-8?B?aXkyeVZ4U1FIbk9wN1ZrMVpoS3BiOXJwYmREMlNiSlk2VGtBMzJzUzJzNzht?=
 =?utf-8?B?OVJKelNMS0Mvb2ZDTk9jVU40QTluejE3ZjF3N0hOalhLSFozbmR2TVRVeHFk?=
 =?utf-8?Q?Aehz9KpwnprXkKfq4fE8lT66E?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HnFPQ8pXkhApI/mGmk/GgQDI5G/cdPedD7vXjxqGFEEfTnRA2DX+8pcYzGCP6vqtZH5+3czXuwiy6MCgSlPhkW67Mcjf/fct+vGZBssm/HwBR25/2oOL2ANK6waP6ka+57toTR90bpzmseH3oFuBigtQQnS5rcjcrpJwI5FzTJgNN8dP8IlC1WeNqK3uqT3q2OiLtQC1WhVF9xUjI4Ry9MtmMP6FIpcLuGJZ6l0PEilaM+JCOrhMizxNE00pMPohvb5t65TPGy7aevVfuGbRiFf+hxnOfzal2K30fZJhmpndD0z/0kQYQ8DIayqE2NoOBKweKuDxQV9fgK4FvMv1qX9rqJvxWpbFbMZDAdwhnBDdl+I40MTCpre1Xwi41e83OI/z8zrsD9IrdP10Q4SQrmgUFih8Eak4DbG5hWr15QAJm/AEvKcrrHYtDF14pF+ARkHwCXtq4nwElkMuRlLLWu6vpbgEgZYe3E41jm56iDEVR6HFot8LnAdgJ3t1LE0Two2fKVgNDEHye/8EzgulSmjKsP+ZT3JHDNvhgwOcvwqo2hWN8bdVtm4ySDv1CD2fCWtdLNOE9H9e6mm4nvi88oPRJTpPQFSFV9QNiJnta6QnJ6HNfesNYMjKPQs+N7KpGi6aTL5tvO3g2tGPAyRCDS8HOPqooXhD0qMzfzvwc3NyQvYiQeVVfuHceoGB8XxacH36yWn0E2TB04yEXMYykbF6Xx37O3KxII1KmDWKby96fPd1lp9B7ahXQEXVq5ap6aawELT3lXxjwwBtrs7InX34Fj8iKajo9sdUa/wsRD7ApQG9oi22N6aRq7pzQdtO
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c6f55e-d11e-426d-37b4-08dafbf67c82
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 21:28:49.7187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Ni+AiEb5SENNK3/fYDdjoU4DitatpVNTmyemmHJbjlzrphAHisBlL70ilz/SmXf8bo0LV8EUpxzA43PcTBA9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7059
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-21_15,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301210209
X-Proofpoint-GUID: K3NXDqhyy4GLmlQ8AGoGdpoLF7mw9eFX
X-Proofpoint-ORIG-GUID: K3NXDqhyy4GLmlQ8AGoGdpoLF7mw9eFX
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 1/21/23 12:12 PM, Chuck Lever III wrote:
>
>> On Jan 21, 2023, at 3:05 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>
>> On Sat, 2023-01-21 at 11:50 -0800, dai.ngo@oracle.com wrote:
>>> On 1/21/23 10:56 AM, dai.ngo@oracle.com wrote:
>>>> On 1/20/23 3:43 AM, Jeff Layton wrote:
>>>>> On Thu, 2023-01-19 at 10:38 -0800, dai.ngo@oracle.com wrote:
>>>>>> On 1/19/23 2:56 AM, Jeff Layton wrote:
>>>>>>> On Wed, 2023-01-18 at 21:05 -0800, dai.ngo@oracle.com wrote:
>>>>>>>> On 1/17/23 11:38 AM, Jeff Layton wrote:
>>>>>>>>> There are two different flavors of the nfsd4_copy struct. One is
>>>>>>>>> embedded in the compound and is used directly in synchronous
>>>>>>>>> copies. The
>>>>>>>>> other is dynamically allocated, refcounted and tracked in the client
>>>>>>>>> struture. For the embedded one, the cleanup just involves
>>>>>>>>> releasing any
>>>>>>>>> nfsd_files held on its behalf. For the async one, the cleanup is
>>>>>>>>> a bit
>>>>>>>>> more involved, and we need to dequeue it from lists, unhash it, etc.
>>>>>>>>>
>>>>>>>>> There is at least one potential refcount leak in this code now.
>>>>>>>>> If the
>>>>>>>>> kthread_create call fails, then both the src and dst nfsd_files
>>>>>>>>> in the
>>>>>>>>> original nfsd4_copy object are leaked.
>>>>>>>>>
>>>>>>>>> The cleanup in this codepath is also sort of weird. In the async
>>>>>>>>> copy
>>>>>>>>> case, we'll have up to four nfsd_file references (src and dst for
>>>>>>>>> both
>>>>>>>>> flavors of copy structure). They are both put at the end of
>>>>>>>>> nfsd4_do_async_copy, even though the ones held on behalf of the
>>>>>>>>> embedded
>>>>>>>>> one outlive that structure.
>>>>>>>>>
>>>>>>>>> Change it so that we always clean up the nfsd_file refs held by the
>>>>>>>>> embedded copy structure before nfsd4_copy returns. Rework
>>>>>>>>> cleanup_async_copy to handle both inter and intra copies. Eliminate
>>>>>>>>> nfsd4_cleanup_intra_ssc since it now becomes a no-op.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>>>>> ---
>>>>>>>>>      fs/nfsd/nfs4proc.c | 23 ++++++++++-------------
>>>>>>>>>      1 file changed, 10 insertions(+), 13 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>>>>> index 37a9cc8ae7ae..62b9d6c1b18b 100644
>>>>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>>>>> @@ -1512,7 +1512,6 @@ nfsd4_cleanup_inter_ssc(struct
>>>>>>>>> nfsd4_ssc_umount_item *nsui, struct file *filp,
>>>>>>>>>          long timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>>>>>>>>>              nfs42_ssc_close(filp);
>>>>>>>>> -    nfsd_file_put(dst);
>>>>>>>> I think we still need this, in addition to release_copy_files called
>>>>>>>> from cleanup_async_copy. For async inter-copy, there are 2 reference
>>>>>>>> count added to the destination file, one from nfsd4_setup_inter_ssc
>>>>>>>> and the other one from dup_copy_fields. The above nfsd_file_put is
>>>>>>>> for
>>>>>>>> the count added by dup_copy_fields.
>>>>>>>>
>>>>>>> With this patch, the references held by the original copy structure
>>>>>>> are
>>>>>>> put by the call to release_copy_files at the end of nfsd4_copy. That
>>>>>>> means that the kthread task is only responsible for putting the
>>>>>>> references held by the (kmalloc'ed) async_copy structure. So, I think
>>>>>>> this gets the nfsd_file refcounting right.
>>>>>> Yes, I see. One refcount is decremented by release_copy_files at end
>>>>>> of nfsd4_copy and another is decremented by release_copy_files in
>>>>>> cleanup_async_copy.
>>>>>>
>>>>>>>>>          fput(filp);
>>>>>>>>>              spin_lock(&nn->nfsd_ssc_lock);
>>>>>>>>> @@ -1562,13 +1561,6 @@ nfsd4_setup_intra_ssc(struct svc_rqst *rqstp,
>>>>>>>>>                       &copy->nf_dst);
>>>>>>>>>      }
>>>>>>>>>      -static void
>>>>>>>>> -nfsd4_cleanup_intra_ssc(struct nfsd_file *src, struct nfsd_file
>>>>>>>>> *dst)
>>>>>>>>> -{
>>>>>>>>> -    nfsd_file_put(src);
>>>>>>>>> -    nfsd_file_put(dst);
>>>>>>>>> -}
>>>>>>>>> -
>>>>>>>>>      static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
>>>>>>>>>      {
>>>>>>>>>          struct nfsd4_cb_offload *cbo =
>>>>>>>>> @@ -1683,12 +1675,18 @@ static void dup_copy_fields(struct
>>>>>>>>> nfsd4_copy *src, struct nfsd4_copy *dst)
>>>>>>>>>          dst->ss_nsui = src->ss_nsui;
>>>>>>>>>      }
>>>>>>>>>      +static void release_copy_files(struct nfsd4_copy *copy)
>>>>>>>>> +{
>>>>>>>>> +    if (copy->nf_src)
>>>>>>>>> +        nfsd_file_put(copy->nf_src);
>>>>>>>>> +    if (copy->nf_dst)
>>>>>>>>> +        nfsd_file_put(copy->nf_dst);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>      static void cleanup_async_copy(struct nfsd4_copy *copy)
>>>>>>>>>      {
>>>>>>>>>          nfs4_free_copy_state(copy);
>>>>>>>>> -    nfsd_file_put(copy->nf_dst);
>>>>>>>>> -    if (!nfsd4_ssc_is_inter(copy))
>>>>>>>>> -        nfsd_file_put(copy->nf_src);
>>>>>>>>> +    release_copy_files(copy);
>>>>>>>>>          spin_lock(&copy->cp_clp->async_lock);
>>>>>>>>>          list_del(&copy->copies);
>>>>>>>>> spin_unlock(&copy->cp_clp->async_lock);
>>>>>>>>> @@ -1748,7 +1746,6 @@ static int nfsd4_do_async_copy(void *data)
>>>>>>>>>          } else {
>>>>>>>>>              nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
>>>>>>>>>                             copy->nf_dst->nf_file, false);
>>>>>>>>> -        nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
>>>>>>>>>          }
>>>>>>>>>          do_callback:
>>>>>>>>> @@ -1811,9 +1808,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct
>>>>>>>>> nfsd4_compound_state *cstate,
>>>>>>>>>          } else {
>>>>>>>>>              status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
>>>>>>>>>                             copy->nf_dst->nf_file, true);
>>>>>>>>> -        nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
>>>>>>>>>          }
>>>>>>>>>      out:
>>>>>>>>> +    release_copy_files(copy);
>>>>>>>>>          return status;
>>>>>>>>>      out_err:
>>>>>>>> This is unrelated to the reference count issue.
>>>>>>>>
>>>>>>>> Here if this is an inter-copy then we need to decrement the reference
>>>>>>>> count of the nfsd4_ssc_umount_item so that the vfsmount can be
>>>>>>>> unmounted
>>>>>>>> later.
>>>>>>>>
>>>>>>> Oh, I think I see what you mean. Maybe something like the (untested)
>>>>>>> patch below on top of the original patch would fix that?
>>>>>>>
>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>>> index c9057462b973..7475c593553c 100644
>>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>>> @@ -1511,8 +1511,10 @@ nfsd4_cleanup_inter_ssc(struct
>>>>>>> nfsd4_ssc_umount_item *nsui, struct file *filp,
>>>>>>>            struct nfsd_net *nn = net_generic(dst->nf_net, nfsd_net_id);
>>>>>>>            long timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>>>>>>>     -       nfs42_ssc_close(filp);
>>>>>>> -       fput(filp);
>>>>>>> +       if (filp) {
>>>>>>> +               nfs42_ssc_close(filp);
>>>>>>> +               fput(filp);
>>>>>>> +       }
>>>>>>>               spin_lock(&nn->nfsd_ssc_lo
>>>>>>>            list_del(&nsui->nsui_list);
>>>>>>> @@ -1813,8 +1815,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct
>>>>>>> nfsd4_compound_state *cstate,
>>>>>>>            release_copy_files(copy);
>>>>>>>            return status;
>>>>>>>     out_err:
>>>>>>> -       if (async_copy)
>>>>>>> +       if (async_copy) {
>>>>>>>                    cleanup_async_copy(async_copy);
>>>>>>> +               if (nfsd4_ssc_is_inter(async_copy))
>>>>>> We don't need to call nfsd4_cleanup_inter_ssc since the thread
>>>>>> nfsd4_do_async_copy has not started yet so the file is not opened.
>>>>>> We just need to do refcount_dec(&copy->ss_nsui->nsui_refcnt), unless
>>>>>> you want to change nfsd4_cleanup_inter_ssc to detect this error
>>>>>> condition and only decrement the reference count.
>>>>>>
>>>>> Oh yeah, and this would break anyway since the nsui_list head is not
>>>>> being initialized. Dai, would you mind spinning up a patch for this
>>>>> since you're more familiar with the cleanup here?
>>>> Will do. My patch will only fix the unmount issue. Your patch does
>>>> the clean up potential nfsd_file refcount leaks in COPY codepath.
>>> Or do you want me to merge your patch and mine into one?
>>>
>> It probably is best to merge them, since backporters will probably want
>> both patches anyway.
> Unless these two changes are somehow interdependent, I'd like to keep
> them separate. They address two separate issues, yes?

Yes.

>
> And -- narrow fixes need to go to nfsd-fixes, but clean-ups can wait
> for nfsd-next. I'd rather not mix the two types of change.

Ok. Can we do this:

1. Jeff's patch goes to nfsd-fixes since it has the fix for missing
reference count.

2. My fix for the cleanup of allocated memory goes to nfsd-fixes.

3. I will do the optimization Jeff proposed about list_head and
nfsd4_compound in a separate patch that goes into nfsd-next.

-Dai

>> Just make yourself the patch author and keep my S-o-b line.
>>
>>> I think we need a bit more cleanup in addition to your patch. When
>>> kmalloc(sizeof(*async_copy->cp_src), ..) or nfs4_init_copy_state
>>> fails, the async_copy is not initialized yet so calling cleanup_async_copy
>>> can be a problem.
>>>
>> Yeah.
>>
>> It may even be best to ensure that the list_head and such are fully
>> initialized for both allocated and embedded struct nfsd4_copy's. You
>> might shave off a few cpu cycles by not doing that, but it makes things
>> more fragile.
>>
>> Even better, we really ought to split a lot of the fields in nfsd4_copy
>> into a different structure (maybe nfsd4_async_copy). Trimming down
>> struct nfsd4_copy would cut down the size of nfsd4_compound as well
>> since it has a union that contains it. I was planning on doing that
>> eventually, but if you want to take that on, then that would be fine
>> too.
>>
>> -- 
>> Jeff Layton <jlayton@kernel.org>
> --
> Chuck Lever
>
>
>
