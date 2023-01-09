Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839C1661BA3
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jan 2023 01:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjAIAuw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 19:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjAIAuu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 19:50:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A2E101FE;
        Sun,  8 Jan 2023 16:50:48 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 308Lovnm032149;
        Mon, 9 Jan 2023 00:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=xxT90xy08E3P26bSKkFA38ugobKkRqjfG7VK9FiTHGE=;
 b=lzCjldt/9RLr7HJAOeZMgDlN2RHs8E1QmCMAnsLvrWScpZ09KiqCgpa1Ot1R/EI8oHSx
 EMDWQoM4WfxqxxqIZ9iJ5OqCpbD4ItHQ2UjlL4BecSfF/tJYW6vEbaeQ89KKwclA4fnf
 V+0pfhKW1gyQutyhMGvHlxDJy+FBKmRuecEYHFwC1lWPM/1C3IYOe9dogm8wiHM7BlZi
 E+7RT31cmowZDjvIvM7Cdz0wz3EA+pfwqCNzid1kTz5fCKXKWddCD4RmerdIMQ1J5KVa
 XuVCe0Vr1bnRPqsMJUpSu4yRggBARnPbPgaixcKegrJIcbd+yOnJihXtifZyV09Qmx1w 8A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n033br6ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 00:50:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 308M0JXP009032;
        Mon, 9 Jan 2023 00:50:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy69d74q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 00:50:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlkoJbIkhnZ+Eo3LxeNsBHx+pnGvp4/11q/QxX+f5aY4r/D48IFtZ3RDx+Q2CYrmGi0YBXk49aioZ/6/NSK1CjrQEa2fxnzYpNRMzIMHgn7FRblya4jC+xANqqO4X9F1mRQVoEUDNQFwDdsXi75UFT9GqKKGtwLLSqc4ikoVZ4ZOtGPDz3f6gNlbJIG+UB51COxs8i31RM5N9fYhYJe0meB4/NTLJi5z3tSKTsTLirFRWOgy01kdNl5cVw/8iWjlWWuW60eVF80zrw08OhXdWGp1apejwtnmgxfD2o3/4Dp5hctPQnvJkc4tF5dGUGXFJ5TjkV7qQWvdSOpvYYBPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxT90xy08E3P26bSKkFA38ugobKkRqjfG7VK9FiTHGE=;
 b=G9NZk4ZnRum5lhSD0gZZn1gBiozXxAX9gTjzaEZwQQHnjNqaaOspUoZ59fQ6Crtytx8cCO/+BIL4D37CTAXTRtDU34gJfA0/5ehHiO2CF5MbYkQCq8KWd7k9PyK2DPPZH2vO0mNdDPJ7irM4m1jzieNfpyvFHLXjm8e/hTyJDkZNI5bQ/QCofb7I8l/+5j3C9lrDHXW4wJ3eAJ3gMEgEWfLLQ2an7CshUGV+DKsvFx6Q3+B+D2ysom3ciPSqvD/ize7pHeuTDjzPaAS4sEi8vW74OC+AJ9fTSnVPuJt78QjzBvqf5DoNcbqeT+KnN9gVWhr7GuFcfHGJUHvg/+l15A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxT90xy08E3P26bSKkFA38ugobKkRqjfG7VK9FiTHGE=;
 b=Vr1cRXPrcZZQol/uHDAusOsABOk+ECcJUdJlsjXZIroZ9iZbBVWTdHRuUO4YPdGBLYENFkrUY4v/baRVfw8EtkGu3wMyyGRIogA8SSa/iVNCrkO651B/Bn7lbk6nkwjmvbNlN35RrN3V3Y2mMZt3PbtJ63HmFm2ajTLtI6CXSuk=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CY8PR10MB7291.namprd10.prod.outlook.com (2603:10b6:930:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 9 Jan
 2023 00:50:42 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%6]) with mapi id 15.20.6002.010; Mon, 9 Jan 2023
 00:50:42 +0000
Content-Type: multipart/mixed; boundary="------------NGZ5NpG2LdYNwwfrUS03s19N"
Message-ID: <33eb3085-552b-6a9a-66d4-4b2397b310c8@oracle.com>
Date:   Sun, 8 Jan 2023 16:50:00 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: regression: nfs mount (even idle) eventually hangs server
To:     Mike Galbraith <efault@gmx.de>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <65ed34338c69cb034295f2c9cbe0af684d65d30f.camel@gmx.de>
 <360f3dcfb6cfbefdbcc42fc84c660995142a8645.camel@gmx.de>
 <241c118c2fb60df744bbe351387fc29a34ff6ab9.camel@gmx.de>
 <f533c2e38c0619ea0c3b4346d1c7c99c5ae2122b.camel@gmx.de>
 <1A404CDB-95A8-4D04-B76B-91D4F063B489@oracle.com>
 <36902a3dd6ee1a8656548ff5b5eadb88245e2799.camel@gmx.de>
 <e51b8b218f18abe00ec76eb911d5b5b5af02f79b.camel@gmx.de>
 <AF3DFAF9-CF19-40AE-8B8F-31D100E00F33@oracle.com>
 <a0abf7fef412dc0de0e42cbcd75ee5dec28cb544.camel@gmx.de>
 <cb5508d260288126212453486d6d45e84436b530.camel@gmx.de>
 <ae11915e-9253-4049-e9a6-31432679d27c@oracle.com>
 <b748cbd9db3a5ac06fe48235ed2a1d110261cafa.camel@gmx.de>
Content-Language: en-US
From:   dai.ngo@oracle.com
In-Reply-To: <b748cbd9db3a5ac06fe48235ed2a1d110261cafa.camel@gmx.de>
X-ClientProxiedBy: SA0PR11CA0203.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::28) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CY8PR10MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 68222a96-9ef6-450d-5abe-08daf1db889e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OiBHKFQ9unvKemSzfGUU8WMaOoxluXsoQ5lHW2/aFmuwLbM+oiYs4phe3TgX7mmyUy3URj/qIDqPM+zMOxcP/1+gKxZeKoIY7L0LgE0EIS1GM2qWSe8uoj8gYJKopb6T53z+oMrrodcUlfCCvmYdMEfOWdaBytDZSzWHFWAn1UAVJzEi01plOyuUIrwMyT1AjVqxQx4ncPqCAWlzqVlITygEJDwhYnsZPlDcpZdDuR0sKBNFP7yThZZQ2eBHoQksBATdg0dbt5td7v+MyC3MVwxGZh+qcB6xYW/GyXXvnxa81q9FCqdAMGHZKtf6/0Wdfhxws2WVknCzltr8w4PYXRxxLANjTKtGn+GgoRIQsPUjsmBuDAIXgHc9mBcNixgWVwZDFd5e2yZ7dCt4koZnnD0c5WoEbwXFiRliNY6GFQSoOdD8vPy22V8k5oNpKxgizAXBw9ne02/KisFBbnXlAQ2YooTIAvrQD7nKW18mwiJEo0DEqeYfnO54qY6AshOgPdRvGzokmLdjII5ZQcBcicNjOcDQY4o3BhAlk3MlG0h5MhPPV1/ER6CviGz/QiGEclePaH0LEiwuynlFGXaVK0oD2RZK9BwpKaAhHVGUIAWd0AeZhiXV7uKqs78RG2mApSa2Pt54O12bR1RIwhVb2OK44Yzg1ku/pe4Kng9ZRITnSmH6PwsL723tjaBtfczO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199015)(5660300002)(235185007)(31696002)(83380400001)(8936002)(4001150100001)(2906002)(41300700001)(36756003)(86362001)(26005)(186003)(8676002)(110136005)(6512007)(9686003)(54906003)(53546011)(316002)(6666004)(6486002)(478600001)(6506007)(33964004)(31686004)(38100700002)(2616005)(4326008)(66556008)(66476007)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVVDTUNLeXlwcXhLa0tZMFNpczVRMVNvcW5JZE1NWDlOZ2QxRXJLa0RxdDly?=
 =?utf-8?B?alVRWEdzcVhVcmRZcmZ0c2RHNTZnR0ZTUEttaDllME9uK0FsenliQmRGQllr?=
 =?utf-8?B?STBSZ1NGaUZRQUFnWVNMcFBWZnpFeGlsTDV4VkU0VWtGNTFTMGdhalFrOTl2?=
 =?utf-8?B?MVl1aW5ibmxJMDlpQ3M1RnVkRFdTcjV6cjV1OVhlYVFydVF4c05abC9MRGN6?=
 =?utf-8?B?T1dsSTBKR1RaVVRwMGsweTY3T0ZVWkdtYXk2Sm1ma1hxanV5cTJIalRzdVZF?=
 =?utf-8?B?anVHL09rbEdjdWJUTzIwUDcyMnFtdnkxTHIxdnd5OThHMEVuVnBHam91czM5?=
 =?utf-8?B?S1VCS0Uza3paK1EwRllHWE94Z1Urem1RWVJJdnZiemtGeUQyQnlxaFdvU0hG?=
 =?utf-8?B?Tk9tN0VoL0RFUnJCSE5VR3AyK1N1ZEtBKzE0WlUvUDMvMkJGckZoNEVaT3N0?=
 =?utf-8?B?eDl3MFE0QlFIWjRZbjZyMGlIUksvWWNERmlMSkZOaWFKTGRwWTdKM0dGcVFI?=
 =?utf-8?B?OFpaM3hkenpOallYeFpRZHFBMHI4UXlrSStENmFwWHA0NXNZSU5FU0pXUGZU?=
 =?utf-8?B?aFBuVDJFRWFUMTludkF6RGJZNkhFZ2pZVWpPeGRqRDQxWXVDVTA5NmdYdTl1?=
 =?utf-8?B?Wmw4QVFQVUlLRHJmcklRQm1QNm9nOFFSb0hVQzNIRTdvZzliaTVib1RsV0xa?=
 =?utf-8?B?b3NsMFowbE4yVzhkRXFJWWpvM2xxUUx2VnluK3ZmM3pPV0ZoODBIajF3R2tZ?=
 =?utf-8?B?bnJwMzVtMDNDZEF2b2w3ODNDc1MxYnNQc3hGcnFhcXlNbkEyN2J0bHBiY1gv?=
 =?utf-8?B?UlV4aGZrRW12Tmlwc0g1UVoxazlKRnFtaGI4eHZWRVpmSjQ2K2I1QkpQbGFp?=
 =?utf-8?B?NHB6TkUyK05PTlhwbDBYTVBuNXUwYkxwK3RVSzBPV0hWczFWRWdkTi80WExY?=
 =?utf-8?B?RUFubmxXL05HaWtwL0ZCUFFPeHh2UFREVGl1aXlpck5XbmhLamo5WEI1V1ZS?=
 =?utf-8?B?Nm5SMlpaUW1wUGRUbXgxbGVobkY3Mk9ndDczWTYzTlVaUkJ5TmVKVFppMWcy?=
 =?utf-8?B?Y0VKOXZHd2UrVEczUTlLck5NVHB2d1FrTUVic29ITjk2Q3BRVGNEMlpiSEpW?=
 =?utf-8?B?eEo1SCtOM0dRcUEzL0RUM1hCQUs1RFU1YW5uQVRrWHdUcUZyVEFLUEZKaXcw?=
 =?utf-8?B?VXJnVWN2SE1EMjJVMXJVVnp4bDN5ZjJxN1d2Q0kybjh6bEVHVlp6RDA0T1pk?=
 =?utf-8?B?RWswT0tSMmJBbm1EWFZKOVFrdHF4d1ZwaXl6cEFYUmJ3OEtzZnlRTXh6ZTVC?=
 =?utf-8?B?UlBYZlVCcmVWUUhQOFB6SHV2ZGJjUDJjdXRkSitCV0tiemxKNWs0MWZWM1pW?=
 =?utf-8?B?ZnN1dlV1ZVgrcGhNOE5sbkRIbWlQdndMeDAvbi9NTkF5WUVMWE1JY1g1KzFr?=
 =?utf-8?B?TEJzZU1sUTd2MndBVGQ4OGlqcFpmMUhMQWthbHJwUmlRRUFCbHpBL05KNUxr?=
 =?utf-8?B?WUVuZmkwSkw5S1V1MFpLSTduVXBZRkJjNCtZMWo5MmlBS05MeTZZVW5jNWpB?=
 =?utf-8?B?MlQxNUxtNm1yUmJZa1JYL0Z5VW5GSkNEV1hjL0RHUkM5YXRabkwwNHg0bXlW?=
 =?utf-8?B?TFNaRWJXRG0xU043cDJJQ3Exenl2Wnl0R25DVmg0VlNIcjlSMll0ZUwxM205?=
 =?utf-8?B?U2NEdmMyclp2U1YvK2VobUw1R1FwSXh5ZnhqZFBMWHFNMmlMVFNQSlFRK1cz?=
 =?utf-8?B?dVFjRk0va3l6SmtocG85RnFRNlViMkZMZC9sYU9ZYVMvSmNyTGl3RklXUnJq?=
 =?utf-8?B?WXJRQTNJVkZWMFNZdkVVZlM0R09tZEQzOURGTCtLSThZekNRMWlNaGRsTWFM?=
 =?utf-8?B?QUZkZTdUdjUvS0J3NExNZExEUHRra1RSZkR6M2dnb0VoQnJmS1FxSGgyZVN6?=
 =?utf-8?B?bDVyOXBWQU1FdktNZ3k1SW0vOHV1VllxYktGbFBLNmNJcFJOZHc5S00vNEVD?=
 =?utf-8?B?aDZuYW9kNmZySVg1N1Roek80N0xKNHExU001a1Y1ZlhHczdYS0hFTjhpbW13?=
 =?utf-8?B?eUt0K0RWYW9TRGtqRThYOWRmcjdtU3hZb1c3LzRTYS9ZV1dUa2xKNzFZcVhX?=
 =?utf-8?Q?6/EJZYUy4FpIrdFRsWA1BtN29?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fE4ov4sJKDEogWfqFBJLtjjUwWAD9va/1KIQ2xwGQBmqYF49oXfnMJlbjZ6z9pzcnoPVwkZxW1L8rYfUV+uTPFSf5Kl1mXTXyGl+OEU3Eq3fpT8GIp4zvvmC6luPQ+OiXaTmEIAjq2vVyb4CAYfsMSv6d85FobdPFU3qG058BeiTaeNF1QgJXaz4Rma8TSvi0OEYWq1VuGLZTuWCbniulfTqKgp4TO811H7hJ0tsB/ivcA0Q2EPG+rToLHBeTpFjln9saBF4eAnqNRqEat7AnZFwr5siT33P1Dwv4WUQBEnjOUZgMMid79rtSLYclkkSLKLMbJBw2x5xIzcjUqOswLF/9bbhiFm2kxhwL7r78TMnZmG+BdYxVa1qxhPPcYkOcTIigZdZVDbp43Sr5EJjjlWKSDNXH0qb7VgSRa3arxcWdBhCVmep6tvzlF4UQ4CoKatUmHo15nTlBywr1CQcCy/Igmp6yF34JkKqW5Sd7+EgIsBVG/bxDDoWUUHaixFqidIlPpWbSQ3kOUpo8e2nU4SRLNNrp08YBln3Waejf4Jny+RDIcn858sHCaqGhDP3f1BNj3Uh9KxGvUrjSOliBRFLwJP1i3AiGH2IisBmEDFTc/5Awp3ebMX+u5wMW3Or97PgVi6XqN2odNMjAbZnrahMh93NqVaiD0vWI8lyB2oSXCtF2enZaE0GijR7AXZH6vehC1ewFm/a6ys6DVEY92MAXbKktjx5hMMkbvnOw0cQ4mfjjKtDANDF3bWBlKuNmy79hAzr6WQrbUX2TXaPm3OzSNeSFV9XKaR6iFSGXr5Q1F+TlXZFD5aS/uSQuJYn
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68222a96-9ef6-450d-5abe-08daf1db889e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 00:50:42.0744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvwzyL9JrChoO2kkI7rJXBDX/g6+tknKB35FnIRb6ZCJgsD8K9s8ohTReF7tB20Jd4rpm4xLF/Ntdmgt0eTrwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_19,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090004
X-Proofpoint-GUID: VV0sYOt3ewYCcTN7hGeA3kRpsjdA5-wb
X-Proofpoint-ORIG-GUID: VV0sYOt3ewYCcTN7hGeA3kRpsjdA5-wb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------NGZ5NpG2LdYNwwfrUS03s19N
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mike,

Could you give the v2 patch a try? I will send you the location
to upload the core, if it happens, in a private email.

Thanks,
-Dai

On 12/23/22 5:05 AM, Mike Galbraith wrote:
> On Fri, 2022-12-23 at 04:02 -0800, dai.ngo@oracle.com wrote:
>> Hi Mike,
>>
>> I think the problem is the nfsd4_state_shrinker_worker is being
>> scheduled to run multiple times. This trigger the WARN_ON_ONCE
>> in __queue_delayed_work.
>>
>> Could you try the attached patch to see if it fixes this problem.
>> I tried to reproduce it on my test VMs but no success so I can't
>> verify the patch.
> That was a nogo.
>
> bart:/root # grep WARNING: netconsole.log
> [ 1030.364594] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1655 __queue_delayed_work+0x6a/0x90
> [ 1030.364970] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1657 __queue_delayed_work+0x5a/0x90
> [ 1030.365315] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1500 __queue_work+0x33b/0x3d0
> [ 1030.365666] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1500 __queue_work+0x33b/0x3d0
> [ 1030.365992] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1500 __queue_work+0x33b/0x3d0
> [ 1030.366333] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1500 __queue_work+0x33b/0x3d0
> [ 1030.366669] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1500 __queue_work+0x33b/0x3d0
> [ 1030.366995] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1500 __queue_work+0x33b/0x3d0
> [ 1030.367317] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1500 __queue_work+0x33b/0x3d0
> [ 1030.367636] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1500 __queue_work+0x33b/0x3d0
> [ 1030.367962] WARNING: CPU: 4 PID: 79 at kernel/workqueue.c:1500 __queue_work+0x33b/0x3d0
>
--------------NGZ5NpG2LdYNwwfrUS03s19N
Content-Type: text/plain; charset=UTF-8;
 name="0001-PATCH-v2-NFSD-fix-WARN_ON_ONCE-in-__queue_delayed_wo.patch"
Content-Disposition: attachment;
 filename*0="0001-PATCH-v2-NFSD-fix-WARN_ON_ONCE-in-__queue_delayed_wo.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBhYjBjMzJlMDA3Mzg5Mjg4MWRhMThhMDIzNDkwZDZmODExZTY5YjVlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYWkgTmdvIDxkYWkubmdvQG9yYWNsZS5jb20+CkRhdGU6IFRo
dSwgNSBKYW4gMjAyMyAxOToxMjo0OCArMDAwMApTdWJqZWN0OiBbUEFUQ0hdIFtQQVRDSCB2Ml0g
TkZTRDogZml4IFdBUk5fT05fT05DRSBpbiBfX3F1ZXVlX2RlbGF5ZWRfd29yawoKQ3VycmVudGx5
IG5mc2Q0X3N0YXRlX3Nocmlua2VyX3dvcmtlciBjYW4gYmUgc2NoZHVsZWQgbXVsdGlwbGUgdGlt
ZXMKZnJvbSBuZnNkNF9zdGF0ZV9zaHJpbmtlcl9jb3VudCB3aGVuIG1lbW9yeSBpcyBsb3cuIFRo
aXMgY2F1c2VzCnRoZSBXQVJOX09OX09OQ0UgaW4gX19xdWV1ZV9kZWxheWVkX3dvcmsgdG8gdHJp
Z2dlci4KClRoaXMgcGF0Y2ggYWxsb3dzIG9ubHkgb25lIGluc3RhbmNlIG9mIG5mc2Q0X3N0YXRl
X3Nocmlua2VyX3dvcmtlcgphdCBhIHRpbWUgdXNpbmcgdGhlIG5mc2Rfc2hyaW5rZXJfYWN0aXZl
IGZsYWcuCgpSZXBsYWNlcyBtb2RfZGVsYXllZF93b3JrIHdpdGggcXVldWVfZGVsYXllZF93b3Jr
IHNpbmNlIHdlCmRvbid0IGV4cGVjdCB0byBtb2RpZnkgdGhlIGRlbGF5IG9mIGFueSBwZW5kaW5n
IHdvcmsuCgpTaWduZWQtb2ZmLWJ5OiBEYWkgTmdvIDxkYWkubmdvQG9yYWNsZS5jb20+Ci0tLQog
ZnMvbmZzZC9uZXRucy5oICAgICB8ICAxICsKIGZzL25mc2QvbmZzNHN0YXRlLmMgfCAzNyArKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCiBmcy9uZnNkL25mc2N0bC5jICAgIHwg
IDcgKy0tLS0tLQogZnMvbmZzZC9uZnNkLmggICAgICB8ICA2ICsrLS0tLQoga2VybmVsL3dvcmtx
dWV1ZS5jICB8ICA5ICsrKysrKy0tLQogNSBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCsp
LCAyNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9uZnNkL25ldG5zLmggYi9mcy9uZnNk
L25ldG5zLmgKaW5kZXggOGM4NTRiYTMyODViLi44MDFkNzA5MjY0NDIgMTAwNjQ0Ci0tLSBhL2Zz
L25mc2QvbmV0bnMuaAorKysgYi9mcy9uZnNkL25ldG5zLmgKQEAgLTE5Niw2ICsxOTYsNyBAQCBz
dHJ1Y3QgbmZzZF9uZXQgewogCWF0b21pY190CQluZnNkX2NvdXJ0ZXN5X2NsaWVudHM7CiAJc3Ry
dWN0IHNocmlua2VyCQluZnNkX2NsaWVudF9zaHJpbmtlcjsKIAlzdHJ1Y3QgZGVsYXllZF93b3Jr
CW5mc2Rfc2hyaW5rZXJfd29yazsKKwlib29sCQkJbmZzZF9zaHJpbmtlcl9hY3RpdmU7CiB9Owog
CiAvKiBTaW1wbGUgY2hlY2sgdG8gZmluZCBvdXQgaWYgYSBnaXZlbiBuZXQgd2FzIHByb3Blcmx5
IGluaXRpYWxpemVkICovCmRpZmYgLS1naXQgYS9mcy9uZnNkL25mczRzdGF0ZS5jIGIvZnMvbmZz
ZC9uZnM0c3RhdGUuYwppbmRleCA3YjJlZTUzNWFkZTguLjFmOTJkNjViZjE2ZiAxMDA2NDQKLS0t
IGEvZnMvbmZzZC9uZnM0c3RhdGUuYworKysgYi9mcy9uZnNkL25mczRzdGF0ZS5jCkBAIC00NDA3
LDExICs0NDA3LDIwIEBAIG5mc2Q0X3N0YXRlX3Nocmlua2VyX2NvdW50KHN0cnVjdCBzaHJpbmtl
ciAqc2hyaW5rLCBzdHJ1Y3Qgc2hyaW5rX2NvbnRyb2wgKnNjKQogCXN0cnVjdCBuZnNkX25ldCAq
bm4gPSBjb250YWluZXJfb2Yoc2hyaW5rLAogCQkJc3RydWN0IG5mc2RfbmV0LCBuZnNkX2NsaWVu
dF9zaHJpbmtlcik7CiAKKwlzcGluX2xvY2soJm5uLT5jbGllbnRfbG9jayk7CisJaWYgKG5uLT5u
ZnNkX3Nocmlua2VyX2FjdGl2ZSkgeworCQlzcGluX3VubG9jaygmbm4tPmNsaWVudF9sb2NrKTsK
KwkJcmV0dXJuIDA7CisJfQogCWNvdW50ID0gYXRvbWljX3JlYWQoJm5uLT5uZnNkX2NvdXJ0ZXN5
X2NsaWVudHMpOwogCWlmICghY291bnQpCiAJCWNvdW50ID0gYXRvbWljX2xvbmdfcmVhZCgmbnVt
X2RlbGVnYXRpb25zKTsKLQlpZiAoY291bnQpCi0JCW1vZF9kZWxheWVkX3dvcmsobGF1bmRyeV93
cSwgJm5uLT5uZnNkX3Nocmlua2VyX3dvcmssIDApOworCWlmIChjb3VudCkgeworCQlubi0+bmZz
ZF9zaHJpbmtlcl9hY3RpdmUgPSB0cnVlOworCQlzcGluX3VubG9jaygmbm4tPmNsaWVudF9sb2Nr
KTsKKwkJcXVldWVfZGVsYXllZF93b3JrKGxhdW5kcnlfd3EsICZubi0+bmZzZF9zaHJpbmtlcl93
b3JrLCAwKTsKKwl9IGVsc2UKKwkJc3Bpbl91bmxvY2soJm5uLT5jbGllbnRfbG9jayk7CiAJcmV0
dXJuICh1bnNpZ25lZCBsb25nKWNvdW50OwogfQogCkBAIC00NDIxLDcgKzQ0MzAsNyBAQCBuZnNk
NF9zdGF0ZV9zaHJpbmtlcl9zY2FuKHN0cnVjdCBzaHJpbmtlciAqc2hyaW5rLCBzdHJ1Y3Qgc2hy
aW5rX2NvbnRyb2wgKnNjKQogCXJldHVybiBTSFJJTktfU1RPUDsKIH0KIAotaW50Cit2b2lkCiBu
ZnNkNF9pbml0X2xlYXNlc19uZXQoc3RydWN0IG5mc2RfbmV0ICpubikKIHsKIAlzdHJ1Y3Qgc3lz
aW5mbyBzaTsKQEAgLTQ0NDMsMTYgKzQ0NTIsNiBAQCBuZnNkNF9pbml0X2xlYXNlc19uZXQoc3Ry
dWN0IG5mc2RfbmV0ICpubikKIAlubi0+bmZzNF9tYXhfY2xpZW50cyA9IG1heF90KGludCwgbWF4
X2NsaWVudHMsIE5GUzRfQ0xJRU5UU19QRVJfR0IpOwogCiAJYXRvbWljX3NldCgmbm4tPm5mc2Rf
Y291cnRlc3lfY2xpZW50cywgMCk7Ci0Jbm4tPm5mc2RfY2xpZW50X3Nocmlua2VyLnNjYW5fb2Jq
ZWN0cyA9IG5mc2Q0X3N0YXRlX3Nocmlua2VyX3NjYW47Ci0Jbm4tPm5mc2RfY2xpZW50X3Nocmlu
a2VyLmNvdW50X29iamVjdHMgPSBuZnNkNF9zdGF0ZV9zaHJpbmtlcl9jb3VudDsKLQlubi0+bmZz
ZF9jbGllbnRfc2hyaW5rZXIuc2Vla3MgPSBERUZBVUxUX1NFRUtTOwotCXJldHVybiByZWdpc3Rl
cl9zaHJpbmtlcigmbm4tPm5mc2RfY2xpZW50X3Nocmlua2VyLCAibmZzZC1jbGllbnQiKTsKLX0K
LQotdm9pZAotbmZzZDRfbGVhc2VzX25ldF9zaHV0ZG93bihzdHJ1Y3QgbmZzZF9uZXQgKm5uKQot
ewotCXVucmVnaXN0ZXJfc2hyaW5rZXIoJm5uLT5uZnNkX2NsaWVudF9zaHJpbmtlcik7CiB9CiAK
IHN0YXRpYyB2b2lkIGluaXRfbmZzNF9yZXBsYXkoc3RydWN0IG5mczRfcmVwbGF5ICpycCkKQEAg
LTYyNDksNiArNjI0OCw5IEBAIG5mc2Q0X3N0YXRlX3Nocmlua2VyX3dvcmtlcihzdHJ1Y3Qgd29y
a19zdHJ1Y3QgKndvcmspCiAKIAljb3VydGVzeV9jbGllbnRfcmVhcGVyKG5uKTsKIAlkZWxlZ19y
ZWFwZXIobm4pOworCXNwaW5fbG9jaygmbm4tPmNsaWVudF9sb2NrKTsKKwlubi0+bmZzZF9zaHJp
bmtlcl9hY3RpdmUgPSAwOworCXNwaW5fdW5sb2NrKCZubi0+Y2xpZW50X2xvY2spOwogfQogCiBz
dGF0aWMgaW5saW5lIF9fYmUzMiBuZnM0X2NoZWNrX2ZoKHN0cnVjdCBzdmNfZmggKmZocCwgc3Ry
dWN0IG5mczRfc3RpZCAqc3RwKQpAQCAtODA3NSw5ICs4MDc3LDE1IEBAIHN0YXRpYyBpbnQgbmZz
NF9zdGF0ZV9jcmVhdGVfbmV0KHN0cnVjdCBuZXQgKm5ldCkKIAogCUlOSVRfREVMQVlFRF9XT1JL
KCZubi0+bGF1bmRyb21hdF93b3JrLCBsYXVuZHJvbWF0X21haW4pOwogCUlOSVRfREVMQVlFRF9X
T1JLKCZubi0+bmZzZF9zaHJpbmtlcl93b3JrLCBuZnNkNF9zdGF0ZV9zaHJpbmtlcl93b3JrZXIp
OworCXByaW50aygiJXM6IG5uWyVweF0gZHdvcmtbJXB4XSB0aW1lclslcHhdXG4iLCAgX19mdW5j
X18sCisJCW5uLCAmbm4tPm5mc2Rfc2hyaW5rZXJfd29yaywKKwkJbm4tPm5mc2Rfc2hyaW5rZXJf
d29yay50aW1lci5mdW5jdGlvbik7CiAJZ2V0X25ldChuZXQpOwogCi0JcmV0dXJuIDA7CisJbm4t
Pm5mc2RfY2xpZW50X3Nocmlua2VyLnNjYW5fb2JqZWN0cyA9IG5mc2Q0X3N0YXRlX3Nocmlua2Vy
X3NjYW47CisJbm4tPm5mc2RfY2xpZW50X3Nocmlua2VyLmNvdW50X29iamVjdHMgPSBuZnNkNF9z
dGF0ZV9zaHJpbmtlcl9jb3VudDsKKwlubi0+bmZzZF9jbGllbnRfc2hyaW5rZXIuc2Vla3MgPSBE
RUZBVUxUX1NFRUtTOworCXJldHVybiByZWdpc3Rlcl9zaHJpbmtlcigmbm4tPm5mc2RfY2xpZW50
X3Nocmlua2VyLCAibmZzZC1jbGllbnQiKTsKIAogZXJyX3Nlc3Npb25pZDoKIAlrZnJlZShubi0+
dW5jb25mX2lkX2hhc2h0YmwpOwpAQCAtODE3MSw2ICs4MTc5LDcgQEAgbmZzNF9zdGF0ZV9zaHV0
ZG93bl9uZXQoc3RydWN0IG5ldCAqbmV0KQogCXN0cnVjdCBsaXN0X2hlYWQgKnBvcywgKm5leHQs
IHJlYXBsaXN0OwogCXN0cnVjdCBuZnNkX25ldCAqbm4gPSBuZXRfZ2VuZXJpYyhuZXQsIG5mc2Rf
bmV0X2lkKTsKIAorCXVucmVnaXN0ZXJfc2hyaW5rZXIoJm5uLT5uZnNkX2NsaWVudF9zaHJpbmtl
cik7CiAJY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZubi0+bGF1bmRyb21hdF93b3JrKTsKIAls
b2Nrc19lbmRfZ3JhY2UoJm5uLT5uZnNkNF9tYW5hZ2VyKTsKIApkaWZmIC0tZ2l0IGEvZnMvbmZz
ZC9uZnNjdGwuYyBiL2ZzL25mc2QvbmZzY3RsLmMKaW5kZXggZDFlNTgxYTYwNDgwLi5jMjU3N2Vl
N2ZmYjIgMTAwNjQ0Ci0tLSBhL2ZzL25mc2QvbmZzY3RsLmMKKysrIGIvZnMvbmZzZC9uZnNjdGwu
YwpAQCAtMTQ1Nyw5ICsxNDU3LDcgQEAgc3RhdGljIF9fbmV0X2luaXQgaW50IG5mc2RfaW5pdF9u
ZXQoc3RydWN0IG5ldCAqbmV0KQogCQlnb3RvIG91dF9pZG1hcF9lcnJvcjsKIAlubi0+bmZzZF92
ZXJzaW9ucyA9IE5VTEw7CiAJbm4tPm5mc2Q0X21pbm9ydmVyc2lvbnMgPSBOVUxMOwotCXJldHZh
bCA9IG5mc2Q0X2luaXRfbGVhc2VzX25ldChubik7Ci0JaWYgKHJldHZhbCkKLQkJZ290byBvdXRf
ZHJjX2Vycm9yOworCW5mc2Q0X2luaXRfbGVhc2VzX25ldChubik7CiAJcmV0dmFsID0gbmZzZF9y
ZXBseV9jYWNoZV9pbml0KG5uKTsKIAlpZiAocmV0dmFsKQogCQlnb3RvIG91dF9jYWNoZV9lcnJv
cjsKQEAgLTE0NjksOCArMTQ2Nyw2IEBAIHN0YXRpYyBfX25ldF9pbml0IGludCBuZnNkX2luaXRf
bmV0KHN0cnVjdCBuZXQgKm5ldCkKIAlyZXR1cm4gMDsKIAogb3V0X2NhY2hlX2Vycm9yOgotCW5m
c2Q0X2xlYXNlc19uZXRfc2h1dGRvd24obm4pOwotb3V0X2RyY19lcnJvcjoKIAluZnNkX2lkbWFw
X3NodXRkb3duKG5ldCk7CiBvdXRfaWRtYXBfZXJyb3I6CiAJbmZzZF9leHBvcnRfc2h1dGRvd24o
bmV0KTsKQEAgLTE0ODYsNyArMTQ4Miw2IEBAIHN0YXRpYyBfX25ldF9leGl0IHZvaWQgbmZzZF9l
eGl0X25ldChzdHJ1Y3QgbmV0ICpuZXQpCiAJbmZzZF9pZG1hcF9zaHV0ZG93bihuZXQpOwogCW5m
c2RfZXhwb3J0X3NodXRkb3duKG5ldCk7CiAJbmZzZF9uZXRuc19mcmVlX3ZlcnNpb25zKG5ldF9n
ZW5lcmljKG5ldCwgbmZzZF9uZXRfaWQpKTsKLQluZnNkNF9sZWFzZXNfbmV0X3NodXRkb3duKG5u
KTsKIH0KIAogc3RhdGljIHN0cnVjdCBwZXJuZXRfb3BlcmF0aW9ucyBuZnNkX25ldF9vcHMgPSB7
CmRpZmYgLS1naXQgYS9mcy9uZnNkL25mc2QuaCBiL2ZzL25mc2QvbmZzZC5oCmluZGV4IDkzYjQy
ZWY5ZWQ5MS4uZmEwMTQ0YTc0MjY3IDEwMDY0NAotLS0gYS9mcy9uZnNkL25mc2QuaAorKysgYi9m
cy9uZnNkL25mc2QuaApAQCAtNTA0LDggKzUwNCw3IEBAIGV4dGVybiB2b2lkIHVucmVnaXN0ZXJf
Y2xkX25vdGlmaWVyKHZvaWQpOwogZXh0ZXJuIHZvaWQgbmZzZDRfc3NjX2luaXRfdW1vdW50X3dv
cmsoc3RydWN0IG5mc2RfbmV0ICpubik7CiAjZW5kaWYKIAotZXh0ZXJuIGludCBuZnNkNF9pbml0
X2xlYXNlc19uZXQoc3RydWN0IG5mc2RfbmV0ICpubik7Ci1leHRlcm4gdm9pZCBuZnNkNF9sZWFz
ZXNfbmV0X3NodXRkb3duKHN0cnVjdCBuZnNkX25ldCAqbm4pOworZXh0ZXJuIHZvaWQgbmZzZDRf
aW5pdF9sZWFzZXNfbmV0KHN0cnVjdCBuZnNkX25ldCAqbm4pOwogCiAjZWxzZSAvKiBDT05GSUdf
TkZTRF9WNCAqLwogc3RhdGljIGlubGluZSBpbnQgbmZzZDRfaXNfanVuY3Rpb24oc3RydWN0IGRl
bnRyeSAqZGVudHJ5KQpAQCAtNTEzLDggKzUxMiw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IG5mc2Q0
X2lzX2p1bmN0aW9uKHN0cnVjdCBkZW50cnkgKmRlbnRyeSkKIAlyZXR1cm4gMDsKIH0KIAotc3Rh
dGljIGlubGluZSBpbnQgbmZzZDRfaW5pdF9sZWFzZXNfbmV0KHN0cnVjdCBuZnNkX25ldCAqbm4p
IHsgcmV0dXJuIDA7IH07Ci1zdGF0aWMgaW5saW5lIHZvaWQgbmZzZDRfbGVhc2VzX25ldF9zaHV0
ZG93bihzdHJ1Y3QgbmZzZF9uZXQgKm5uKSB7fTsKK3N0YXRpYyBpbmxpbmUgdm9pZCBuZnNkNF9p
bml0X2xlYXNlc19uZXQoc3RydWN0IG5mc2RfbmV0ICpubikgeyB9OwogCiAjZGVmaW5lIHJlZ2lz
dGVyX2NsZF9ub3RpZmllcigpIDAKICNkZWZpbmUgdW5yZWdpc3Rlcl9jbGRfbm90aWZpZXIoKSBk
byB7IH0gd2hpbGUoMCkKZGlmZiAtLWdpdCBhL2tlcm5lbC93b3JrcXVldWUuYyBiL2tlcm5lbC93
b3JrcXVldWUuYwppbmRleCAwNzg5NWRlY2EyNzEuLjE1MzVlN2M5MjQzNSAxMDA2NDQKLS0tIGEv
a2VybmVsL3dvcmtxdWV1ZS5jCisrKyBiL2tlcm5lbC93b3JrcXVldWUuYwpAQCAtMTQ5Nyw3ICsx
NDk3LDcgQEAgc3RhdGljIHZvaWQgX19xdWV1ZV93b3JrKGludCBjcHUsIHN0cnVjdCB3b3JrcXVl
dWVfc3RydWN0ICp3cSwKIAl0cmFjZV93b3JrcXVldWVfcXVldWVfd29yayhyZXFfY3B1LCBwd3Es
IHdvcmspOwogCiAJaWYgKFdBUk5fT04oIWxpc3RfZW1wdHkoJndvcmstPmVudHJ5KSkpCi0JCWdv
dG8gb3V0OworCQlwYW5pYygid3FbJXB4XSB3b3JrWyVweF1cbiIsIHdxLCB3b3JrKTsKIAogCXB3
cS0+bnJfaW5fZmxpZ2h0W3B3cS0+d29ya19jb2xvcl0rKzsKIAl3b3JrX2ZsYWdzID0gd29ya19j
b2xvcl90b19mbGFncyhwd3EtPndvcmtfY29sb3IpOwpAQCAtMTY1MSw5ICsxNjUxLDEyIEBAIHN0
YXRpYyB2b2lkIF9fcXVldWVfZGVsYXllZF93b3JrKGludCBjcHUsIHN0cnVjdCB3b3JrcXVldWVf
c3RydWN0ICp3cSwKIAlzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmsgPSAmZHdvcmstPndvcms7CiAK
IAlXQVJOX09OX09OQ0UoIXdxKTsKLQlXQVJOX09OX09OQ0UodGltZXItPmZ1bmN0aW9uICE9IGRl
bGF5ZWRfd29ya190aW1lcl9mbik7CisJaWYgKFdBUk5fT05fT05DRSh0aW1lci0+ZnVuY3Rpb24g
IT0gZGVsYXllZF93b3JrX3RpbWVyX2ZuKSkKKwkJcGFuaWMoIndxWyVweF0gZHdvcmtbJXB4XSB0
aW1lci0+ZnVuY3Rpb25bJXB4XVxuIiwKKwkJCXdxLCBkd29yaywgdGltZXItPmZ1bmN0aW9uKTsK
IAlXQVJOX09OX09OQ0UodGltZXJfcGVuZGluZyh0aW1lcikpOwotCVdBUk5fT05fT05DRSghbGlz
dF9lbXB0eSgmd29yay0+ZW50cnkpKTsKKwlpZiAoV0FSTl9PTl9PTkNFKCFsaXN0X2VtcHR5KCZ3
b3JrLT5lbnRyeSkpKQorCQlwYW5pYygid3FbJXB4XSBkd29ya1slcHhdXG4iLCB3cSwgZHdvcmsp
OwogCiAJLyoKIAkgKiBJZiBAZGVsYXkgaXMgMCwgcXVldWUgQGR3b3JrLT53b3JrIGltbWVkaWF0
ZWx5LiAgVGhpcyBpcyBmb3IKLS0gCjIuOS41Cgo=

--------------NGZ5NpG2LdYNwwfrUS03s19N--
