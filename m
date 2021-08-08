Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EF53E3C23
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Aug 2021 20:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhHHSJr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Aug 2021 14:09:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1076 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230201AbhHHSJr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Aug 2021 14:09:47 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 178I8tds022524;
        Sun, 8 Aug 2021 18:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YwA6zDxpYBX6rhABDzplXwRsFmPxC/SIqXk9he20xIo=;
 b=Mqoynhxws6PfFx4TIRN8RKuO9dLVq2F1zd5X+CWfcDbO/KR+UhGhB+tiWMKXo/be/4zj
 y/RiLxLRRnibdMKo0tENv+gY8zHDp7pMemPXzT0zcw/Zcm+VqXRBXPDJzULaNVJ34IHF
 +kSb+wH1XKf/jLkE6uyWTA+xhPOUJgD/QZl2IClqLXOv80E2zUxgKAJmohiPSExB2GqC
 Hf6KsS4L0r+IPdqr8EZ5TZQXrDwoRFJLeqRGScMBj5itNsfzZydST403FIZ4+fEAQ1jt
 WAPhhRMTx+oYxR4gJCZXACA/OK18LSDW3I3UnkX1j9OUk2eiM159MAag0U4H8WcFHoh8 0w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=YwA6zDxpYBX6rhABDzplXwRsFmPxC/SIqXk9he20xIo=;
 b=pe2nqLa8aGnEubHqc1g93sh/r0Gc65v7LJufas0i/b0EVNix7f6X4MrrVMI3sLDjSQlI
 SmPJVSRv0M/bF71xALnmgQjHUsEqDUS8u/NPW5A2zU9biHnso45ME0gmnvUASRHOQT0n
 B1WfWSUOH7wquqWQ79okn2DVt68ShA1UKEzqp/qom2sXGi72yzmq+zZH3UZGsDn4AXfd
 gQ5Ut3JS/FDjvC6CTvqhGIc8HZfr/Jch6q4WsZLb+krhq1X90ILsap5103TOeNwvJub6
 t1VNc2UYxIpdtWA3piMtRQasr27JgPFm2UiPGDZT6EEA796GBTgmr2F5R8BZr927QUr2 +w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a9gkd1tkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Aug 2021 18:09:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 178I6HOI036724;
        Sun, 8 Aug 2021 18:09:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3020.oracle.com with ESMTP id 3a9vv1y1e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Aug 2021 18:09:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcA1kp9+Z+lGaqdhMDGx3LA0MBzkOMpBU2cfsCfO1acTY1Z3DnxI7wdofw6KCjS12xh4MVYntUnUSPu3OcDZ9Dp2QCWG6/mYITWS/VNNs1ABxCMSAC2746PtuK2wF5VYxiyYH36Rlo9NiEDnfZ2PScTyeMcpERFdsbScUwWRJklD8TNP8ZXj0QQjYYcr+W56BeB+fZHxWbOZL8Tok/W9NNFmYmcNvtfg2xP00tOaUW796hLgaFwz1puk1+gmwog/T50H7sAIrz+qTNt6eE3szDPQmAGEDOoEWHjguFR1nbM6z8fluN7tS0ShpwwfJzgqPpCsbGbA/tguJh2trdm05g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwA6zDxpYBX6rhABDzplXwRsFmPxC/SIqXk9he20xIo=;
 b=Q65HKlCgMql30dOdu8NJTG35P8syxh4KSa/ta1KEwfV2z3JBIhkfWOrhatKAo9gn7lNZBeuMAwgN2GiU3s7pfNmTMWhLpFNDdiKBOL7Yf/TgdCrOd1WD0UooLk7FVzolFNiF1Vzkoe/MY1RRnrvdUp/6kLmX9GZ+rYsZhJQPTf4s8seXhBVhdpJ4wv3TyXq45UxBLRCAlTcAU8AOn8K/OEjQwH6MWZCnQQsWGgDkZZvZYR/+Pqs0u0JJA24rPjXvcs0s/eXA0HOZ/Z3/N3+zUjG4u9p9C8vf/7q8bRol4OrbirALyVn8h/21Gw1Bzy8/quD562BwQn0JJEhle/J1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwA6zDxpYBX6rhABDzplXwRsFmPxC/SIqXk9he20xIo=;
 b=FQXTS5OaaouwTklKfmxkBGVLVrzZkNJQhimQqqJrqZ+J1sV179MCD1f61AXFtPHQ5T26CIWJjdy0ypz86A5Ti9v+7w1Uiax/ZlWslOLHWTsNsvbIMCQKc4KoX05ohUYS7/UfD0Y4Rl7MAtb9AZmcUG+ytERPJMoMFWGEHEIZhn4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB2760.namprd10.prod.outlook.com (2603:10b6:a02:a9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Sun, 8 Aug
 2021 18:09:08 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::e4ce:bb43:6e72:1e10]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::e4ce:bb43:6e72:1e10%7]) with mapi id 15.20.4394.022; Sun, 8 Aug 2021
 18:09:08 +0000
Subject: Re: [Libtirpc-devel] [PATCH 1/1] Fix DoS vulnerability in statd and
 mountd
To:     Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org
Cc:     libtirpc-devel@lists.sourceforge.net,
        Florian Weimer <fweimer@redhat.com>
References: <20210807170248.68817-1-dai.ngo@oracle.com>
 <5d67875a-05bc-df80-3971-e8bde9b588b8@redhat.com>
From:   dai.ngo@oracle.com
Message-ID: <153913b5-2ee9-f19c-a921-13bd3e15cca4@oracle.com>
Date:   Sun, 8 Aug 2021 11:09:06 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <5d67875a-05bc-df80-3971-e8bde9b588b8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PH0PR07CA0074.namprd07.prod.outlook.com
 (2603:10b6:510:f::19) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MacBook-Pro.local (72.219.112.78) by PH0PR07CA0074.namprd07.prod.outlook.com (2603:10b6:510:f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Sun, 8 Aug 2021 18:09:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 708ab876-1ece-49b1-ea20-08d95a979db8
X-MS-TrafficTypeDiagnostic: BYAPR10MB2760:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2760CBD4DD065AD551F091BC87F59@BYAPR10MB2760.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:142;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GNe2F6y5aGQ07V0QYKptnz9jHsmobs8ZQ1kbKDFwEriktwU5NS+g7gjIaRdvsBjun44YzJxLePXs8zVSSSaaOhga8m9apTEz7KX595PubiABeENANFO74AHdMadhlZ04R3JR816Y2YJSCufYvXG2z2c1Q+T9QYWEOOaDNGiXOIsN0QQqSDH6dGR6sKfKc8BBqDPE9G74PtrxflYjeA/3mrva9OQxQ/iHv8ijUeP3R7yNY3txzo9mWAKCfDdo+rRyE9kxNbHnFS1dAMS7bzJ0w+q80n5R92hJeCf6zp3F6WxEiKTn0qrsbRhIJp0lwO3eY/j5ClCqvOCSrpqGrD8HVewUWy/BOSpaQO+tcnMVgCdv/GRiW2zUPkYWe/uuvHseDg8s/icJaXcYZ1PbYkRdQWti6i+XcGFdyLK/ij7X89nns/cazDYEiiAXCBATFOhfQ2aMpBaj+4cT1J9Mw37eFrYissHNVxaD3hpWUeya+nIlvgvTuX5IFGv4TirK24OGxJ0XZIbKGw9PNdjKqZPjK5/+tTHoiCP5D0afDGt4PVmXbTPwJcexCnG6i5uIIJtWKFS2isXrv2KqofOFi8Dlvzqa6J/x/cehC4qhXMlYIXUfTEWWZtLzgXIkToiMO37p+MtYy/vzK1AZWLVVPpKeoaSFMdivwGrSDEfCqvbq/rrxOFjoREpJSojmfkAJjj5QACd9AoFs3uX1pFXSvVY9Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(39860400002)(396003)(136003)(66556008)(31696002)(86362001)(478600001)(316002)(4326008)(2616005)(31686004)(6486002)(5660300002)(38100700002)(66476007)(8676002)(8936002)(6512007)(66946007)(9686003)(186003)(26005)(2906002)(956004)(83380400001)(6506007)(53546011)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVlGL0RvZEdLWkNyanIzZXBzY2t0TGlyR2R0L1RqTkVqREpqUXpKeXZEek5v?=
 =?utf-8?B?Tmc4czB3MVkxOEorY0hWOWU4dkhTNU1JSkdqSE5PQTlmZ2oyeUlZK1gwWm1X?=
 =?utf-8?B?WVhIMEJoY1VLY3FEb2dmeWxrS3VIaDJTK3ZseGQweGNkUHJiRXgvcUtsTkVx?=
 =?utf-8?B?NWtOU1VVTVBWek9kbmpGLzFubWpnQTZPckNtWi93TW1oci96WC9xVUpKU0V1?=
 =?utf-8?B?Tkl4dVkveVhYVXlkWHVnbFVXVnlobmhkSXpsYlR3TjRMaGVsZlp1S2c2TE1M?=
 =?utf-8?B?cFlXdWNwb0dKYVhxV24xTTB2Uk1SWWtrUXkzRi9XZkVJTlFSLzh4c0dVZGNU?=
 =?utf-8?B?L3hIakxiMjFrdDhZMlBNdXJseHVrbUtPY1ZERFVQVUcxT2VHY2x6VzQwaG5v?=
 =?utf-8?B?VlNlYU54Zmwvc2NPRlU2c1J0YW9JY0tpZjFidjAyTE9KbU5KRW02RFVXT0hX?=
 =?utf-8?B?SDhvM3F5Z2JRVWF6V3kwV2hwUldzc0dLb0RaTEF3Vmc3ZUd3aHJsbit4Z1Iv?=
 =?utf-8?B?NXhVUUFzT0d2NndRakgvOHp4bTAzcWJyaml0anA3aWcrNytVTnZBQm0wT1VW?=
 =?utf-8?B?OTZuVDFka3NkNGFCODNzcDJocTd5dGVtQTQyS29MRXZLNTQ1Mzk5SkhvRE9W?=
 =?utf-8?B?UFdSR0JlYmttQ0lMdlpiMUFVSDgzZFVrQTdMTGJaNk1WU1V3S1UxMjJFSHl6?=
 =?utf-8?B?NjZiYndVNWdGNUZibVIveWFHN3ptY0FTb1Byc2Ivc1h3bGtqQTROeS9qbFZo?=
 =?utf-8?B?YmRyOTJTUDdDMy9Hb0NHNkN1MUtJRmIrMHdUeExJUWJ0TmRWNFRhSGErL0pE?=
 =?utf-8?B?TVZFeWZNY3prV1drcHJVL0ZHRzAxaTlxcXQzV3BmbG5uOVpqclBYeXZwUndU?=
 =?utf-8?B?c1I4aHNpcHJLUjUrc0gveTNCU0sza3NlZzZiMzN5UVNXRjFxU1hlcU1qc0lV?=
 =?utf-8?B?aWxYL2VPSk0yTkNpRFdhZVlaWGloRUtra3FyTy9hNkxYK2N3VVp5Q3JYOXJl?=
 =?utf-8?B?YzVDdEtESW8xNlkwMGpRQndlNTkxN0hWdHl6SkZaMVgyMnAzLzh5OTgyWU9W?=
 =?utf-8?B?aHk1SEpGdmU4RTIzQnRNV1E0TE5xUDd6NTNtR0Z1Q0g5T3RaOE5UN3A1ZjZT?=
 =?utf-8?B?K3VLRHF3T080WTZSbkNjdXpxVlZYSzJ4YzNXSWJUVCtoUFpPc2FmMEVlaEdy?=
 =?utf-8?B?ZmpIbnhuMXdCK1ltRXVhNFgwb29hUE11YkpHRm9lUGJjN2x1M3U3cmFLbUdu?=
 =?utf-8?B?U0dYdmVScUNEVnZxM3d5NUtKWVV6TDRmS3A3cUlnL0RzR1J3ZlVMVS9oRThw?=
 =?utf-8?B?M0g0aEdqUEhreU1uU09yUElreFE5aFlXQVBIUlkrTnVVVFhsdlNFT3VydE9h?=
 =?utf-8?B?UkFudVBkcU1PekxaZE1QSFBNbm9HUVc4OWw0ajgrTnNUcXczYTFod0hqNUVQ?=
 =?utf-8?B?WUFrYVE4Z3B6bTNzYWFabERCS3VwcTd6WWxXTEhBa1hidm9tNlM1S1JJOXo0?=
 =?utf-8?B?b0RnS3RzOCtrUm9mSmN5ZHoyZm94MnpmWVpCMWxobEwvbDR6d3h6ZEJCeWQr?=
 =?utf-8?B?bDgxcjNSRTNXazIrU2lWWkIxVlQ4YjJveGR5Ykt0bTFyb05qdVlzOEZLV2pi?=
 =?utf-8?B?bmFCU3B5QWNxU1VvN04rQmx1ZmNTb1Z3VU9VMWhFYis5dTBLM21xV3dvNjEw?=
 =?utf-8?B?bGNEVjhpQVZ0MEZMdnppWVNUcUgvenJ3d2cvWFo0TFNiaS9XbFhQWURrWTBr?=
 =?utf-8?Q?oChwvvavIkjXoSOMiKh8q3TEyxs3sao0N1XNGNd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708ab876-1ece-49b1-ea20-08d95a979db8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2021 18:09:08.3473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+PqsMGVyiv8XREicHpdaAUHwQ9eRwuKt6kfuufogVTGIug1gIReK5JxSV6LXTm1rsoDngyZPCRkvnJeDNMlFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2760
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10070 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108080114
X-Proofpoint-ORIG-GUID: 4po9J0GsFOGJRy2pPfBaCM8cMctYEBvb
X-Proofpoint-GUID: 4po9J0GsFOGJRy2pPfBaCM8cMctYEBvb
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/8/21 9:56 AM, Steve Dickson wrote:
> Hello,
>
> On 8/7/21 1:02 PM, Dai Ngo wrote:
>> Currently my_svc_run does not handle poll time allowing idle TCP
>> connections to remain ESTABLISHED indefinitely. When the number
>> of connections reaches the limit the open file descriptors
>> (ulimit -n) then accept(2) fails with EMFILE. Since libtirpc does
>> not handle EMFILE returned from accept(2) this get my_svc_run into
>> a tight loop calling accept(2) resulting in the RPC service being
>> down, it's no longer able to service any requests.
>>
>> Fix by removing idle connections when select(2) times out in my_svc_run
>> and when open(2) returns EMFILE/ENFILE in auth_reload.
>>
>> Signed-off-by: dai.ngo@oracle.com
>> ---
>>   support/export/auth.c  | 12 ++++++++++--
>>   utils/mountd/svc_run.c | 10 ++++++++--
>>   utils/statd/svc_run.c  | 11 ++++++++---
>>   3 files changed, 26 insertions(+), 7 deletions(-)
>>
>> diff --git a/support/export/auth.c b/support/export/auth.c
>> index 03ce4b8a0e1e..0bb189fb4037 100644
>> --- a/support/export/auth.c
>> +++ b/support/export/auth.c
>> @@ -81,6 +81,8 @@ check_useipaddr(void)
>>           cache_flush();
>>   }
>>   +extern void __svc_destroy_idle(int, bool_t);
> This is adding to the API... Which means mountd
> and statd (the next patch) will not compile without
> this new API...

Yes, both this patch and the patch for rpcbind require the libtirpc patch.

>
> Does this mean an SONAME change? That is such a pain!

Do you have any suggestions to make this less painful?

-Dai

>
> steved.
>
>> +
>>   unsigned int
>>   auth_reload()
>>   {
>> @@ -91,8 +93,14 @@ auth_reload()
>>       int            fd;
>>         if ((fd = open(etab.statefn, O_RDONLY)) < 0) {
>> -        xlog(L_FATAL, "couldn't open %s", etab.statefn);
>> -    } else if (fstat(fd, &stb) < 0) {
>> +        if (errno != EMFILE && errno != ENFILE)
>> +            xlog(L_FATAL, "couldn't open %s", etab.statefn);
>> +        /* remove idle */
>> +        __svc_destroy_idle(5, FALSE);
>> +        if ((fd = open(etab.statefn, O_RDONLY)) < 0)
>> +            xlog(L_FATAL, "couldn't open %s", etab.statefn);
>> +    }
>> +    if (fstat(fd, &stb) < 0) {
>>           xlog(L_FATAL, "couldn't stat %s", etab.statefn);
>>           close(fd);
>>       } else if (last_fd != -1 && stb.st_ino == last_inode) {
>> diff --git a/utils/mountd/svc_run.c b/utils/mountd/svc_run.c
>> index 167b9757bde2..ada8d0ac8844 100644
>> --- a/utils/mountd/svc_run.c
>> +++ b/utils/mountd/svc_run.c
>> @@ -59,6 +59,7 @@
>>   #include "export.h"
>>     void my_svc_run(void);
>> +extern void __svc_destroy_idle(int , bool_t);
>>     #if defined(__GLIBC__) && LONG_MAX != INT_MAX
>>   /* bug in glibc 2.3.6 and earlier, we need
>> @@ -95,6 +96,7 @@ my_svc_run(void)
>>   {
>>       fd_set    readfds;
>>       int    selret;
>> +    struct    timeval tv;
>>         for (;;) {
>>   @@ -102,8 +104,10 @@ my_svc_run(void)
>>           cache_set_fds(&readfds);
>>           v4clients_set_fds(&readfds);
>>   +        tv.tv_sec = 30;
>> +        tv.tv_usec = 0;
>>           selret = select(FD_SETSIZE, &readfds,
>> -                (void *) 0, (void *) 0, (struct timeval *) 0);
>> +                (void *) 0, (void *) 0, &tv);
>>               switch (selret) {
>> @@ -113,7 +117,9 @@ my_svc_run(void)
>>                   continue;
>>               xlog(L_ERROR, "my_svc_run() - select: %m");
>>               return;
>> -
>> +        case 0:
>> +            __svc_destroy_idle(30, FALSE);
>> +            continue;
>>           default:
>>               selret -= cache_process_req(&readfds);
>>               selret -= v4clients_process(&readfds);
>> diff --git a/utils/statd/svc_run.c b/utils/statd/svc_run.c
>> index e343c7689860..8888788c81d0 100644
>> --- a/utils/statd/svc_run.c
>> +++ b/utils/statd/svc_run.c
>> @@ -59,6 +59,7 @@
>>     void my_svc_exit(void);
>>   static int    svc_stop = 0;
>> +extern void __svc_destroy_idle(int , bool_t);
>>     /*
>>    * This is the global notify list onto which all SM_NOTIFY and 
>> CALLBACK
>> @@ -85,6 +86,7 @@ my_svc_run(int sockfd)
>>       FD_SET_TYPE    readfds;
>>       int             selret;
>>       time_t        now;
>> +    struct timeval    tv;
>>         svc_stop = 0;
>>   @@ -101,7 +103,6 @@ my_svc_run(int sockfd)
>>           /* Set notify sockfd for waiting for reply */
>>           FD_SET(sockfd, &readfds);
>>           if (notify) {
>> -            struct timeval    tv;
>>                 tv.tv_sec  = NL_WHEN(notify) - now;
>>               tv.tv_usec = 0;
>> @@ -111,8 +112,10 @@ my_svc_run(int sockfd)
>>                   (void *) 0, (void *) 0, &tv);
>>           } else {
>>               xlog(D_GENERAL, "Waiting for client connections");
>> +            tv.tv_sec = 30;
>> +            tv.tv_usec = 0;
>>               selret = select(FD_SETSIZE, &readfds,
>> -                (void *) 0, (void *) 0, (struct timeval *) 0);
>> +                (void *) 0, (void *) 0, &tv);
>>           }
>>             switch (selret) {
>> @@ -124,7 +127,9 @@ my_svc_run(int sockfd)
>>               return;
>>             case 0:
>> -            /* A notify/callback timed out. */
>> +            /* A notify/callback/wait for client timed out. */
>> +            if (!notify)
>> +                __svc_destroy_idle(30, FALSE);
>>               continue;
>>             default:
>>
>
