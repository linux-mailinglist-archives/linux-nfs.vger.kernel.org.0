Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A6E502C23
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Apr 2022 16:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351580AbiDOOuh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Apr 2022 10:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347186AbiDOOug (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Apr 2022 10:50:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC9C114
        for <linux-nfs@vger.kernel.org>; Fri, 15 Apr 2022 07:48:07 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23F9Zchw031973;
        Fri, 15 Apr 2022 14:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RbuXQbakNKz+8ucP70GrlH+lEdacGo1cMlGfmtqeG7M=;
 b=otM1qDgZQhAFxuDhh0Pp7LWLFg/ErpuUb/DJyZLOgLfBxfO2thiU1VtDpe0IbAH1USOE
 pAAKtN/CfDLWLWvUyp3oYxxtSvnVGYtJld3IXYTEyFTS1RHootXiaRsAB5AJlADT9Mn3
 JDcs6HRz2cpXQe0qRfwaxwot9v8m/Hs4Eso5szfbkIyFVilnJagyS6D1it15+s1TWef8
 B6uMVyP2ti1wikmJ10smzkXCoEsv/52XrtpPHbxii9s+wQow31x8Uv2oJbX6Gxz9hSow
 uiKXTmZx9AMwYpbIGcCX/WiF5eqJJ24XA5XfGjL7mLdz4uqDQqovsaFKQNZ7Qqn228lO 2Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jdeumj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 14:48:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23FEkXFZ002693;
        Fri, 15 Apr 2022 14:48:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck15xycj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 14:48:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyaPiozhiRIn6eEFpf74/KGwEHUmPxP3yZqVfBY8m3UsTZaIH7IogFuQPFQm/SZPGrdyCuL54gXrcQvZSpo53t+F8W6b5z/TfFut8u6GAOS9BYa2mDPCxV+GPAAuFjRhtvu2rtROT60pmHMC9pjuAy9BbmuWO7hIDrAeaxRYb1wK28XhBSDHewF49QrtGOe7NC7sNbiDmuzW5orvP2vzChYPRdUl5zT5HcoIsyjxqzXOH/1pG0IF4m3OfZKVWO45Lzz1lt83sXvrPvJ2vEoSWFgY/mUhJhfRiBwefjt8UIsHp0mWwsjlk5plUWILG3RaLe9n2Dqg+L+SpECmgBYKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbuXQbakNKz+8ucP70GrlH+lEdacGo1cMlGfmtqeG7M=;
 b=WNr9pXMeuGTOD3LS8E3+pYEl5QCxO3oOVV2/T07O7K6cQC+QtIUFIaBS2OMHimGxs99s86PgwpqojKBpnOoxjjGgO1ojH9c2LxI2HvC3wUGwB0xnY6jOwob2y2+/fIoiq0y/CeB0fjWhF+5sW84VmXqX8OwkWBRdS3SNynh5NDqKWcKjVi81IqliZQ5RrZxw+TG16hoQC9cmpCXlG0otKycXv+DEFV3CSHTq+fCsIVkJuqrXOFo4cfID5Y0ceDotyKU7NWUsRybq5VVdLU9oSqKMLnDOqiVS3/DpWAUn2H9RBsfuI1IuUk3pnzr702L3UKXTsMbOMt/7zRJ2GC96ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbuXQbakNKz+8ucP70GrlH+lEdacGo1cMlGfmtqeG7M=;
 b=0MXWlY6izlmI9yvrRTFCdeyrUh1HGh10gq0Ud8vM8p/o0cntRedD2HADz85V4I2ZIHci1G9ITBgHer9Jp8k3ryt4uykFDjD+6GZjDCMxOJfxXLJuOlFKwoo1KAol0JfQ207kQ0yg+yamtBznKn9eHe8l5aapVxKn74H5lSlfaho=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 14:48:01 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::52b:f017:38d1:fd14]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::52b:f017:38d1:fd14%2]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 14:48:01 +0000
Message-ID: <fae06919-13de-9ebb-8259-108f6e18c801@oracle.com>
Date:   Fri, 15 Apr 2022 07:47:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH RFC v19 06/11] NFSD: Update find_clp_in_name_tree() to
 handle courtesy client
Content-Language: en-US
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
 <1648742529-28551-7-git-send-email-dai.ngo@oracle.com>
 <20220401152109.GB18534@fieldses.org>
 <52CA1DBC-A0E2-4C1C-96DF-3E6114CDDFFD@oracle.com>
 <8dc762fc-dac8-b323-d0bc-4dbeada8c279@oracle.com>
 <20220413125550.GA29176@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220413125550.GA29176@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR14CA0049.namprd14.prod.outlook.com
 (2603:10b6:5:18f::26) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 432b27ad-a983-4d73-43f6-08da1eeef0af
X-MS-TrafficTypeDiagnostic: BYAPR10MB3573:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB35739E2962FBD1E207C4FA2487EE9@BYAPR10MB3573.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQRhJ55mplHiHBOz6OpVjt49ByYNfVEkvi+VeunWH+VZ+qowtazTwcOLtOihtnFrO8/qtLnQ3LrGtjhxae3SjXvufqJ4jmL+fn1+VWFzzZ6N3E8/kvO/RyGY21qp8VZqejlDRUaoKaLcypIHE8qWP+3/CpegD3feg4Qmd0cjNnTmMVzwulHkCg7hg2pSBfHi3Yumz3SFNnbS7TNFCWateMet8RTTTNck8cA6kTF2awhSacq9K3zqldUY90nTAxN1Z6deN68ngNTGt/+v78gJfFlgjZsfElvrCyRi/7dVrtglN6JUibHtGPQovtHstsmTmUPJNEx/kqVP4y5MUuVbasPSKLaCYCvj0pGJZYfWFShgMdtjT+TldrZOFf6RxbtgPYgFJQ0HV7DmzZ+4NN/S/htQJxLBJej2pAj4fBrEvwSAl1kA263tE8nJkAFR1rDXzYWp4pxOhD7EryTbUXJmE8ExScZWu8yN5C9KXGuNCUHiNyu0vsKlssCw30Paxp7U+tPTK3ZLe3syYsybUcN/RqIuzCMT3wyCXItbvILZIsX7yxPqArV1eYC360hLKp7HZQDPnAhLZMS4Go1oHQawfpyI6mubCMB0Ss4J0My5CDCEC4QcpshTmAfOuiqvwXzQ/K2ah89TjAVWRmsxi/aauz7aGmAupDAHIVHo+6yir3q0HL8aJKzst1Sqc1FCpHK2Mf7GmZm3ugACafi6ljb8GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(4326008)(508600001)(66946007)(2906002)(66556008)(66476007)(6486002)(86362001)(6666004)(15650500001)(31696002)(9686003)(6512007)(53546011)(6506007)(8936002)(186003)(26005)(83380400001)(54906003)(5660300002)(2616005)(31686004)(6916009)(316002)(38100700002)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlRnM0w0b3ZDaWNOL05Udm40Mi9hbng2NXBQVkx2bnkwVXRKVm04Y1FxUUdt?=
 =?utf-8?B?WkM5SDlZZGRTUXV1MENTd3h6REs4SVBrUHhBN0xSZllSNjBzNElNUEUrNkty?=
 =?utf-8?B?anNwaFZ0K2Q3dDllcnIzZmNQYnlNWE5OUUFTSVM5RFFLRXdPcWo4SURXNG9u?=
 =?utf-8?B?R1gvM000QndJcFFiYWRGS2NVQ0hSeDQ4dVhYOU53R3BHS3hVWEtXRWwvT0Zx?=
 =?utf-8?B?V1FJM0t1SWorUTBLTFdRVzFVRDU2eWtzeVVoWmlxcjM5dVZlaU5QRThDYTlT?=
 =?utf-8?B?TFVkSnorRGx1UjNhUmZTdStsZGI4Z1Y1WkluclJFU2RBZ0w3Rk1xUEdLS2tQ?=
 =?utf-8?B?RXY1K0ovYkE4TzVaVDJLVjI2cTRCL1dFeGJjQnJzZmduSDRnSEwwK1o3K0JT?=
 =?utf-8?B?QzlsS0I3anFZRHI5WUJoaWlKd0F4TWFSa3R1M2RsbU9obkpLV1ZMZHZnb1NJ?=
 =?utf-8?B?c0UydlkrWVM1VnJqT1hHOTZSRDlVVko2SDltdnJLTDRIS00yaGFra0hGUE1a?=
 =?utf-8?B?alVPdFZtbEZKVjgyenY4a2xIYjBTZy9ITEcxK2IvRGJIeWNPbG5KeXFqVGJV?=
 =?utf-8?B?TUF2dHZucEtSekhLQytGeHpzTTBsTmJXVnhQK29BOTVhTHRGZTlFcy9UUWNn?=
 =?utf-8?B?dU04N0FkZnMza0plc05lYjlGWitKbm8vTVFQU2d6Rm9GL0ZvSWtVODErTVJO?=
 =?utf-8?B?Qm4zSFY1bnhoMDM5ZXRPN08vdkhwYSs1dEh4MlJxTEdKSUpVUFRMRy85OWFN?=
 =?utf-8?B?ZnZsVTRyU3ZXL3NXYkZiM0RyQ0luTkJnMGZyejlONlRuZ01pMjU1MWVsNENH?=
 =?utf-8?B?RnZVRWxxaEQwcS91bjRtZ1l5M3NtUlVla1cxR0Y5WUhwNHhvcktLZGNCVXJ0?=
 =?utf-8?B?ZTErSlM2ZFdoOHNVQ0cxU1dLUGZqN05xUnUrUnNxYzJ5b2E1UTNoQ3BxNnFF?=
 =?utf-8?B?Y1NiQ0treEhkWlFuL3M2ZkxaUEcwZXlLOEEvTisyd3BUSkxDUmVZYjRyemNX?=
 =?utf-8?B?emJVekNEZHdDekszbERVR3JqQ09lRHRwWUgwS2FyNDBuRVRkSCtkak85MEU1?=
 =?utf-8?B?eTVkVjBUNTZ6M1NzL2cwL0p0VTZ6SXE0UjU3eWJPRFBvY05QVWJUamxQRzZI?=
 =?utf-8?B?VFFReUtZNGxOS2V3SEJ0WVVDQjR3VVdYY0FTZS95U00wNXZiZTNWSXJVNzlR?=
 =?utf-8?B?MlJFekdvOUx2bXFXQzVVOXdmYjR6SkxIWWJNQWh1Uit3N21GcEFWakdGUGFi?=
 =?utf-8?B?RGJtMXFybkcwSGEvcVpXSGQ0UklRTndER3JPYXJkY1JINXNzTXhvSklKUGRC?=
 =?utf-8?B?bHQrMlpucTFJQjl4ekd3cjIrbzNZUjZnUkVrMXJnRmlqZGd0VE1uMWRoWTd3?=
 =?utf-8?B?Ky9Kb2JTN0dwZHkrTEZJY2g0QTdDTTgxWnRvV0U1WmZjQWZ4NWpmUkJJR1pC?=
 =?utf-8?B?SFc0aWhISkl3VnV3bGNTVUpoTlpjY2lFa0JwekFPQ256SFQyRnU1aEY0TnZw?=
 =?utf-8?B?RTZwbmswbEVyb1d3Yi9oRFB1d2NwM3VGcW5DTzRoaWF1ZmZFNjhUYkhkb1FP?=
 =?utf-8?B?b0RmeUN4cmJoUWtRNTZJYnJPRGdyMDg2NE5abSsycEs1RmxyQm1rcWQvUXg1?=
 =?utf-8?B?YTM5eUNJcHlaNmVRMzRQKzlrR1VkVEFyVTg2aHhJOXZCdjJlWi8vRHYyQkIr?=
 =?utf-8?B?ZkJpUWxMN3VSU2VZeUppZDBldFZBNlJmTGgzQ0JRNG96cVBBTktrSWNzM0x5?=
 =?utf-8?B?WkcrK0tPQzE1dkZsVURaNlRLamU0NnhwSll1d3dhMnNMZzlVUGNndFhPcTJh?=
 =?utf-8?B?aFM2Mkp6bDB4UTlPTG1sN2FUdWZIZzJsZ2dNaW1LQmI4UW12MStMbTR1VWhn?=
 =?utf-8?B?NCtFRmxMUEhzckJQUW1BTTk4TlVWdVZod25NTUdyM0huVFhPdEszdFBSbFB3?=
 =?utf-8?B?cGNacWtVKy91SWdacEZYS1Zta0pQSkdDM2ZEOGxQOVpTdEM2MEplNnpDcjZW?=
 =?utf-8?B?MzNIamlKOEZja1FEV0hJa2hMNzZ4YmhWVnpvcGswOE5GcHlHK0ltQ2EweHBE?=
 =?utf-8?B?eDJ6VjhVN1p0KzhvS1JTem4yV0dMMndTZENOeGZXWHpSUjQ1K0Y1cGIyVHhF?=
 =?utf-8?B?MzFXY2hNYnlITGd4UmowSkdjU0N0YmZmZjdzZGVWQ3loOCtSeVFWb3YyZDQy?=
 =?utf-8?B?SUlCT2xrWkxTTzNBNHhvV1A0d1hsT3R5MDQwZ2ZtcFhKOVhZY0ZBTkFaa2F3?=
 =?utf-8?B?NU5xcFJBVnc2K3R3NWdLeHV3ZEd0aytqS3Z2M3VodmxpQUdYTmk2UGRzU1ZW?=
 =?utf-8?B?dFcyOU9GL2RtY3oxUktOcUo4VmROSXpvbitISlRDbEl1a3VBbUJRQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432b27ad-a983-4d73-43f6-08da1eeef0af
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 14:48:01.6664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMt2j8C2RHUrQo7Kh/VvbuTnuk4UIveExUpkQUjahNdh8n67hzu7tWSxpf7lGUqnCg6gIfgLDvwZQKw/3sFJ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3573
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_01:2022-04-14,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204150087
X-Proofpoint-ORIG-GUID: 7v52yZ8Bww6rl6QxO7oafTighrWiCSQD
X-Proofpoint-GUID: 7v52yZ8Bww6rl6QxO7oafTighrWiCSQD
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/13/22 5:55 AM, Bruce Fields wrote:
> On Fri, Apr 01, 2022 at 12:11:34PM -0700, dai.ngo@oracle.com wrote:
>> On 4/1/22 8:57 AM, Chuck Lever III wrote:
>>>> (And to be honest I'd still prefer the original approach where we expire
>>>> clients from the posix locking code and then retry.  It handles an
>>>> additional case (the one where reboot happens after a long network
>>>> partition), and I don't think it requires adding these new client
>>>> states....)
>>> The locking of the earlier approach was unworkable.
>>>
>>> But, I'm happy to consider that again if you can come up with a way
>>> of handling it properly and simply.
>> I will wait for feedback from Bruce before sending v20 with the
>> above change.
> OK, I'd like to tweak the design in that direction.
>
> I'd like to handle the case where the network goes down for a while, and
> the server gets power-cycled before the network comes back up.  I think
> that could easily happen.  There's no reason clients couldn't reclaim
> all their state in that case.  We should let them.
>
> To handle that case, we have to delay removing the client's stable
> storage record until there's a lock conflict.  That means code that
> checks for conflicts must be able to sleep.
>
> In each case (opens, locks, delegations), conflicts are first detected
> while holding a spinlock.  So we need to unlock before waiting, and then
> retry if necessary.
>
> We decided instead to remove the stable-storage record when first
> converting a client to a courtesy client--then we can handle a conflict
> by just setting a flag on the client that indicates it should no longer
> be used, no need to drop any locks.
>
> That leaves the client in a state where it's still on a bunch of global
> data structures, but has to be treated as if it no longer exists.  That
> turns out to require more special handling than expected.  You've shown
> admirable persistance in handling those cases, but I'm still not
> completely convinced this is correct.
>
> We could avoid that complication, and also solve the
> server-reboot-during-network-partition problem, if we went back to the
> first plan and allowed ourselves to sleep at the time we detect a
> conflict.  I don't think it's that complicated.
>
> We end up using a lot of the same logic regardless, so don't throw away
> the existing patches.
>
> My basic plan is:
>
> Keep the client state, but with only three values: ACTIVE, COURTESY, and
> EXPIRABLE.
>
> ACTIVE is the initial state, which we return to whenever we renew.  The
> laundromat sets COURTESY whenever a client isn't renewed for a lease
> period.  When we run into a conflict with a lock held by a client, we
> call
>
>    static bool try_to_expire_client(struct nfs4_client *clp)
>    {
> 	return COURTESY == cmpxchg(clp->cl_state, COURTESY, EXPIRABLE);
>    }
>
> If it returns true, that tells us the client was a courtesy client.  We
> then call queue_work(laundry_wq, &nn->laundromat_work) to tell the
> laundromat to actually expire the client.  Then if needed we can drop
> locks, wait for the laundromat to do the work with
> flush_workqueue(laundry_wq), and retry.
>
> All the EXPIRABLE state does is tell the laundromat to expire this
> client.  It does *not* prevent the client from being renewed and
> acquiring new locks--if that happens before the laundromat gets to the
> client, that's fine, we let it return to ACTIVE state and if someone
> retries the conflicing lock they'll just get a denial.
>
> Here's a suggested a rough patch ordering.  If you want to go above and
> beyond, I also suggest some tests that should pass after each step:
>
>
> PATCH 1
> -------
>
> Implement courtesy behavior *only* for clients that have
> delegations, but no actual opens or locks:

we can do a close(2) so that the only remaining state is the
delegation state. However this causes problem for doing exactly
what you want in patch 1.

>
> Define new cl_state field with values ACTIVE, COURTESY, and EXPIRABLE.
> Set to ACTIVE on renewal.  Modify the laundromat so that instead of
> expiring any client that's too old, it first checks if a client has
> state consisting only of unconflicted delegations, and, if so, it sets
> COURTESY.
>
> Define try_to_expire_client as above.  In nfsd_break_deleg_cb, call
> try_to_expire_client and queue_work.  (But also continue scheduling the
> recall as we do in the current code, there's no harm to that.)
>
> Modify the laundromat to try to expire old clients with EXPIRED set.
>
> TESTS:
> 	- Establish a client, open a file, get a delegation, close the
> 	  file, wait 2 lease periods, verify that you can still use the
> 	  delegation.

 From user space, how do we force the client to use the delegation
state to read the file *after* doing a close(2)?

In my testing, once the read delegation is granted the Linux client
uses the delegation state to read the file. So the test can do open(2),
read some (more(1)), wait for 2 lease periods and read again and
make sure it works as expected.

Can we leave the open state remain valid for this patch but do not
support share reservation conflict yet until Patch 2?

-Dai

> 	- Establish a client, open a file, get a delegation, close the
> 	  file, wait 2 lease periods, establish a second client, request
> 	  a conflicting open, verify that the open succeeds and that the
> 	  first client is no longer able to use its delegation.
>
>
> PATCH 2
> -------
>
> Extend courtesy client behavior to clients that have opens or
> delegations, but no locks:
>
> Modify the laundromat to set COURTESY on old clients with state
> consisting only of opens or unconflicted delegations.
>
> Add in nfs4_resolve_deny_conflicts_locked and friends as in your patch
> "Update nfs4_get_vfs_file()...", but in the case of a conflict, call
> try_to_expire_client and queue_work(), then modify e.g.
> nfs4_get_vfs_file to flush_workqueue() and then retry after unlocking
> fi_lock.
>
> TESTS:
> 	- establish a client, open a file, wait 2 lease periods, verify
> 	  that you can still use the open stateid.
> 	- establish a client, open a file, wait 2 lease periods,
> 	  establish a second client, request an open with a share mode
> 	  conflicting with the first open, verify that the open succeeds
> 	  and that first client is no longer able to use its open.
>
> PATCH 3
> -------
>
> Minor tweak to prevent the laundromat from being freed out from
> under a thread processing a conflicting lock:
>
> Create and destroy the laundromat workqueue in init_nfsd/exit_nfsd
> instead of where it's done currently.
>
> (That makes the laundromat's lifetime longer than strictly necessary.
> We could do better with a little more work; I think this is OK for now.)
>
> TESTS:
> 	- just rerun any regression tests; this patch shouldn't change
> 	  behavior.
>
> PATCH 4
> -------
>
> Extend courtesy client behavior to any client with state, including
> locks:
>
> Modify the laundromat to set COURTESY on any old client with state.
>
> Add two new lock manager callbacks:
>
> 	void * (*lm_lock_expirable)(struct file_lock *);
> 	bool (*lm_expire_lock)(void *);
>
> If lm_lock_expirable() is called and returns non-NULL, posix_lock_inode
> should drop flc_lock, call lm_expire_lock() with the value returned from
> lm_lock_expirable, and then restart the loop over flc_posix from the
> beginning.
>
> For now, nfsd's lm_lock_expirable will basically just be
>
> 	if (try_to_expire_client()) {
> 		queue_work()
> 		return get_net();
> 	}
> 	return NULL;
>
> and lm_expire_lock will:
>
> 	flush_workqueue()
> 	put_net()
>
> One more subtlety: the moment we drop the flc_lock, it's possible
> another task could race in and free it.  Worse, the nfsd module could be
> removed entirely--so nfsd's lm_expire_lock code could disappear out from
> under us.  To prevent this, I think we need to add a struct module
> *owner field to struct lock_manager_operations, and use it like:
>
> 	owner = fl->fl_lmops->owner;
> 	__get_module(owner);
> 	expire_lock = fl->fl_lmops->lm_expire_lock;
> 	spin_unlock(&ctx->flc_lock);
> 	expire_lock(...);
> 	module_put(owner);
>
> Maybe there's some simpler way, but I don't see it.
>
> TESTS:
> 	- retest courtesy client behavior using file locks this time.
>
> --
>
> That's the basic idea.  I think it should work--though I may have
> overlooked something.
>
> This has us flush the laundromat workqueue while holding mutexes in a
> couple cases.  We could avoid that with a little more work, I think.
> But those mutexes should only be associated with the client requesting a
> new open/lock, and such a client shouldn't be touched by the laundromat,
> so I think we're OK.
>
> It'd also be helpful to update the info file with courtesy client
> information, as you do in your current patches.
>
> Does this make sense?
>
> --b.
