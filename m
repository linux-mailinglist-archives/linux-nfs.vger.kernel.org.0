Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DEE54D1F0
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jun 2022 21:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345960AbiFOTsh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jun 2022 15:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350351AbiFOTs0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jun 2022 15:48:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855F73054E
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jun 2022 12:48:25 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FHXoOD022329;
        Wed, 15 Jun 2022 19:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5uk49bzufPkIvUN2NANRu/GtxjRMr5ahMGNokyT/hbc=;
 b=Ar+uh2iIlUF1IHh0/ee2zIhyCZEYyQj6njlsJ9k3STjmw92wxoN9xohlIjx7FWd/4nJb
 fsVGYh4wkUkaKo8ZixiQ+o5NEjgP3idehPWmIb0imO8HCOTLnzeKlYWSSolHp+2rN5zk
 aEj57wheLbyM5UXM7D9BbEeNY2ndTPBNa+4xGK53npQbJgEQSoI/RvRng3ABc3uTpKdz
 4qAq8Dore4zfu3NjZhgwogZxIOEqH1WrK+ZmcVoD1AYZrHraqF0e54u2iiKc+k8Bwfog
 KkqQIoqLkl5I7CBy3BaMFnwh26V7FQF1qPDoWlDWMEj3MK3YYmJuHxaBrdAUBzgbhVgI ow== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhfcserk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 19:48:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25FJWJhs033215;
        Wed, 15 Jun 2022 19:48:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpqq1n4bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 19:48:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HggWgZKRnJaxoDSpM6v1IDT76FLr/Wtg0uJLEOzAVTkZom6yBmYo2akq6RYwitEbPox6PhuWVwP7vbLfkVsGlADI/h0NxYaW8crl+PQ0azZ3HtIMcIrv9kXSfttd9XKDafhEwhlM9+zo83HIN12Sz17MEph+HA2D7yZ2bSLXKby+59FFYOWhS3coe75eZdBD9JNC57HxwvOTFw3zL6eGp85ZGfSbhufr7bBM+EcOCQO4bfZDGztNlvmDTD2EsqKuuTCVQR6dCvxTMEiIzVYtDE7lIy1K7ZmC+Y2aGqZ1uHY2PSQYOoGxg4GSBbQf2OSzl3aUxHyKRCeABKq9ofB/dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uk49bzufPkIvUN2NANRu/GtxjRMr5ahMGNokyT/hbc=;
 b=ME8Brvit57O5QyAEhpkxPCQIAAEUZPUyBCs2DmMje70p21nOpaje49pxNBsr8+aMQ37eG3LT9NCcyQ6gOlMmB1wuSsj4NSplakcsg1Pge6EIvpzbHOmd2iOBoVFnRTc8efm2fENN89tt53wqzJnBe+81V3b+p45bgiiViWFku65j58DyK22nBr4tHCt+ZhJiGKPPoGp4vyNFZ/sg+fza5p6m547zqrZKqyb9fZ0+Jj0CAX3XW0j3FhYP+K0uEr+PQSwZbgX2OlK19vh+V2ZB61Vc2iQEo/CvhPrE5lWv6bNgP+bzb2K21nQCbDPbBZmfne0Lk0R016l9cgHRiJ+9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uk49bzufPkIvUN2NANRu/GtxjRMr5ahMGNokyT/hbc=;
 b=NtI4Zi8z+DNPQgE6KttZT+6JN1TgVppQP3WNgYgFuGHz3eKIbGI0to8FeIX0nm9zK4bEaAvrYYUzX8Er0ke6MdW7fLjnxdQBNRkGGpQSpgaLC1wfzaxv0KJ7JbCsYWKctMGkgilZmMW8YN9qoZ0V3GjEMNmSW+w2FkgCjUBvl6g=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CY4PR10MB1462.namprd10.prod.outlook.com (2603:10b6:903:28::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Wed, 15 Jun
 2022 19:48:20 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a44a:1596:2b77:2199]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a44a:1596:2b77:2199%5]) with mapi id 15.20.5353.014; Wed, 15 Jun 2022
 19:48:20 +0000
Message-ID: <d0db9a5c-01f3-2380-20ab-36c1e78e395d@oracle.com>
Date:   Wed, 15 Jun 2022 12:48:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] nfs4lib.py: enhance open_file to work with courteous
 server
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
References: <1655314495-17735-1-git-send-email-dai.ngo@oracle.com>
 <20220615193453.GB16220@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220615193453.GB16220@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::11) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6803d9b4-eaea-427b-9794-08da4f07ffd6
X-MS-TrafficTypeDiagnostic: CY4PR10MB1462:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1462004196689D05B3A72AD987AD9@CY4PR10MB1462.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4D5SFwk5cf/l1qFFEL27+SniG8xbMTaiVzJHp9DYPq33mUr9qVhz5TNJ+HhWRSYleAkZv2Y9X13k5lZODmqZ+L6wY7eaFFEv4NGEdLgGVFXQtyBkfEpJuN12fYmlyJQo3w498ZylKGfFH3QAQccyrpVc/AMUQJ5dLGhUiwpAItPfY4zfF1nklUv4HxM/uwjEUpKuXKeaTh+e6XVvZrt1HCxbwYHKeDyGP2zERXoIedefA3txk2GqLE9zoohUQ9PvaU+Xx0J75862YtxmoTTIzcqDxBa2HJvKCgdOcKEQ6eff3GD78F4bkwcbBOU1u2hFy7j3rMLmAlDeRnxNFyJVa+jcz9tO/g8YOqXE+zTei+33tQsRkNW1PsX3VloaYWxvZPwJDUV5XrDRmzWpHlXwdqgzRX2YsXZAX9jQgRYrErxU1G3Zd72q8v/iNj7Mzi10DD4EQCDyBZnMhaVN5zDM/c5CaqVYtPpLMkTSWNPx2pKYZ/OIzu9B9W16qc+yRJx+4iFPZBIuTfUUxQY+gbqzD/ONOhV+r/LFRux/j1c7OVs87qeyt9k9NXhseJp4waaD8qEuScPwbIORMdRHRZax+4sBAUv9nnCRhdX2OeNIgbycsaUGiVxoOrhfkk3WnwJh80J1VXzf0/4/besC5J6H5Yx7NIcmQfogE0JTqrzGh3pMzLgAJItm2CF1D61Hh++uaIJo9MwcRlY43JRDu1w7ke0WXCFp1/WWcoYr2QaKBcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(36756003)(6666004)(4326008)(6486002)(66476007)(6512007)(8676002)(26005)(508600001)(66946007)(66556008)(9686003)(2616005)(6506007)(53546011)(186003)(2906002)(316002)(6916009)(86362001)(31696002)(83380400001)(8936002)(31686004)(5660300002)(38100700002)(32563001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHpNNlVaektUUmdERkdjM29HTWR4ekFDbXFxRWI1djBETVNUaXVsKzhxMlJ2?=
 =?utf-8?B?V3YzMGhiWDRnay80TThhclZ1dWw1NzhqVDhHMTZCRUJiMEtPZjZpRDhLOGF5?=
 =?utf-8?B?c0J0RDFoYVRMS3pqMWJiNWVqTURSUUJtWXpTSzRjNmRWWkRRWUJnSjF1NFNM?=
 =?utf-8?B?TlQ3bnZTYlpzeExpUU9meE0xcWtPU0JjMC85NXFiK2FjUUNCVEt2QWg0RWZM?=
 =?utf-8?B?Tno2L3JPWit4djdxcXJVb3c2VUwyOUpka2R1S3ZGZXJzbGJrbVRvWHpiaFVP?=
 =?utf-8?B?ODZ3SitTZERQZkJwTUxuRDZKaCt1S2ZBMHVsVmdWSEJkVmgxR0NJbWF6bzJi?=
 =?utf-8?B?RzE5VWMycTJZTTFPRHc5MGhLZ0JxNkFwVTMyeTZJQ01LM3I0c1ZZVm9WZUg0?=
 =?utf-8?B?MGhXZTA1NzIxcGlNRVFaYU1Qd0JTcHRYSUEzZkpaU3pjaThyVDZhYWJFamE4?=
 =?utf-8?B?ako4NW1HVUN0TnBZdndaK2ZiOTVxOFF5bmk5dGVZQ2E1S2ZzdWduRGJqekxj?=
 =?utf-8?B?Y3NMNUExYkorb0dZQlVDSFhVNDVaeTBxNmk2TGsrNzNXdmcraTZuRGRRYW1B?=
 =?utf-8?B?RHFCR2dtcXd5aGpPaXhoVTAzRFdWdktWcXZ5ZTA0aWVxRE5KRnQvR0JLSk5l?=
 =?utf-8?B?dElaaklWUWJWZFV2c2RNT0FHZm1kYWZPbUgwN2d6QzBoWG0vTVFkQWEwdzRz?=
 =?utf-8?B?cUovTnBiZzJRSWxOcmpXOFFRYktuaU1vUWREZWlVQkM4YlFMV3VPd1BzR0ty?=
 =?utf-8?B?VXFHMHBYbjNVSU0wR0wwaGpRNWlNeTNUS3FDTUk4dkhjQ3BpUVNmSGxhWWJv?=
 =?utf-8?B?VDhEL1gyeVI3QW4rRFNOYmx5Qld0L1NYczBibnJoYzFGeFVFS3Z6SWJINTRI?=
 =?utf-8?B?bWlvb2RxTEYrR0ZVQ1VKbnB3TGxLZlNzMkNhY1BGTWlZMExtcXFRMmQ3NUhy?=
 =?utf-8?B?R0VEeDEvdS9FZzdEck13aDdxNisvWS8raDFzait3Q1RFZTZNa1FvOE5wTTVH?=
 =?utf-8?B?WFRMV1hlNkJLWEJueUVTNFFUc1hBM3BYclM3ZDdTOTdhR3dyZU9vS0VOaUVZ?=
 =?utf-8?B?amZSNDdBeVVUbDdxSnd1dEhCVlNOWER3RzhXN0FKcUJhYWViUDdJamY0K2gx?=
 =?utf-8?B?R2N3V0tZQ01HUnhnamRSaWx2b3BsUDM2WnJEcDNBRzJiYVkycXFlQ2lPVHVF?=
 =?utf-8?B?WjJ0MVJYeVVRdVhYNGFCR2lqZ0FReGE5WUNpd3E4Vzg4Znp0SzdndUd1UEZO?=
 =?utf-8?B?ZG04SzRNanlHWWpwU2VOaHIxOEVUWFJMbW5qeWswYm1CT2w0TkdMT0RSeFE0?=
 =?utf-8?B?RjFUMWZkTmR5Y0IvREtoUC85TFgwMXRhVXB5d2x6VFNyN2Q2UndLOWhHQW51?=
 =?utf-8?B?UnFIVVdEbmY5dTAvUVFwa1NidnR4ZjZSbFdhQUZqWDVXUy94VFJWbUtDeERE?=
 =?utf-8?B?QUZjcGhXd1J1K053U2JnL1RvWjZPaE1BU2xWSi9PTzd1Vy8zU3ZNTjFoVTkw?=
 =?utf-8?B?anpwb1RSME5YOW04cGVVTmVKbXNzWUZGM2ZxT3loMkozUU5sRXI4alFva1NE?=
 =?utf-8?B?OWhjTnpUclR3VlhFeHBTMFpZdlUrenh5cU9RcDF6ZGtLbGR0aTV4VEZyOE5C?=
 =?utf-8?B?UkVvVDd0RHNPM1RvWGJxTTJtcWJ2TXhpU0VSTTZjczhJREFXM1ZFNStlSnNZ?=
 =?utf-8?B?ME12NnJpRVdkS3JVRG1XOFNkZlJtSG54WGpIWmNnandhNEE5dUEyU3VUZlJa?=
 =?utf-8?B?NFFwME1CK1NCOGxQY1NqZW5MNkg0bW9jbitTcnBWWVNLSDZsSEJINmo3eGtw?=
 =?utf-8?B?NnZubnE2ZGFRVDRzVGkrKzMvd2w3UHN0VndIMG9jdnJQRjF4OTFIeEMxUEl0?=
 =?utf-8?B?ZGoxREVnUXpCcy9wTWJBZ3NJclNCYThGRWFCYnY0REFZMFJmbk1GUjVKOHV3?=
 =?utf-8?B?Qko4MGxNYTMrbzdaRjlzYVh3Wmt6TXFzcW5xRHBoU3ZONWVPWlBxOHpwZHp1?=
 =?utf-8?B?bFJ2V3l3MkNPbDJkM1hIMVFYanJtUXU3aXQyUzBDMjFBUjlrZVR0YnRMdWtn?=
 =?utf-8?B?MTNqaTd6b2pFM29CK0c5YWNSK3lvWDQrMzlkb3E3d0NYdnQyV05kaWhQN3RQ?=
 =?utf-8?B?UmxWMmRmQ3lLN3g3STluUk1va0VWbzQvWWE1bjJ5aUFpUmllUVdiY2ZyUUll?=
 =?utf-8?B?Q0kvNGlCUk5iQStQc3d1Tk80Z21lYlppZGJ5eHdvRHpFN21TdjlrdGI5akQx?=
 =?utf-8?B?MHRHOEJ5TGI4U2xFcjdHTjE3cG1hbng5MHZjTlo1QXdXMTIxYm9Dd0FXdUpY?=
 =?utf-8?B?V3JGVGR3TGcxbElGSVJOWFJqaTVsM1FiSmhsL3FqaGs3S1JLRDZHZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6803d9b4-eaea-427b-9794-08da4f07ffd6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 19:48:20.3840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqCIA7DdtBGk5sdScUx6UufxhW6Lhc1oar5MXR64xtU+xMQAZAnvXf6Ds98weWzr3eW5rgm44LcahGMyj/8BnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1462
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_06:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150072
X-Proofpoint-ORIG-GUID: UJrC2ntGqDZP-xO7PKJLE1NnwwxkMnHq
X-Proofpoint-GUID: UJrC2ntGqDZP-xO7PKJLE1NnwwxkMnHq
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 6/15/22 12:34 PM, J. Bruce Fields wrote:
> THere are tests that want to explicitly test for DELAY returns.  (Grep
> for ERR_DELAY.  Look at the delegation tests especially.)  Does this
> work for them?

Those tests expect NFS4_OK but also handle NFS4ERR_DELAY themselves
if the OPEN causes recall. With this patch, the NFS4ERR_DELAY is handled
internally by open_file so the ERR_DELAY never get to those tests.
All tests passed with this patch.

-Dai

>   I assumed we'd want an optional parameter that allowed
> to caller to circument the DELAY handling.
>
> --b.
>
> On Wed, Jun 15, 2022 at 10:34:54AM -0700, Dai Ngo wrote:
>> Enhance open_file to handle NFS4ERR_DELAY returned by the server
>> in case of share/access/delegation conflict.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   nfs4.0/nfs4lib.py | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
>> index 934def3b7333..e0299e8d6676 100644
>> --- a/nfs4.0/nfs4lib.py
>> +++ b/nfs4.0/nfs4lib.py
>> @@ -677,7 +677,12 @@ class NFS4Client(rpc.RPCClient):
>>                             claim_type=claim_type, deleg_type=deleg_type,
>>                             deleg_cur_info=deleg_cur_info)]
>>           ops += [op4.getfh()]
>> -        res = self.compound(ops)
>> +        while 1:
>> +            res = self.compound(ops)
>> +            if res.status == NFS4ERR_DELAY:
>> +                time.sleep(2)
>> +            else:
>> +                break
>>           self.advance_seqid(owner, res)
>>           if set_recall and (res.status != NFS4_OK or \
>>              res.resarray[-2].switch.switch.delegation == OPEN_DELEGATE_NONE):
>> -- 
>> 2.27.0
