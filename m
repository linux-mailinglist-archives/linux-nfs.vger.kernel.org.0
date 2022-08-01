Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAD758724C
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Aug 2022 22:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiHAUZt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Aug 2022 16:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbiHAUZq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Aug 2022 16:25:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8CD17ABD
        for <linux-nfs@vger.kernel.org>; Mon,  1 Aug 2022 13:25:45 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271KPcYa026860;
        Mon, 1 Aug 2022 20:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=mKiuF9pY8zsVncsqlToE9xKVZH13FYRSEjYJjn3I8wY=;
 b=nwJOxvBiG/FdwDhZ/Xy86Wu8pKzFnsf8rq9VcoVGMC5GbVnDFJEz9Q+SlRFmW0N33rW2
 nqufQN6M+ZkkJSQqLHIwMCtDQytMATFkvurP1zykY3V+yRN4exbXXQj65Rt+YwFMhx9F
 jDteaaP+V9ztu0cVC4Bg97F5IGIe0C1KIEPkcss/1NCSOQfNZt2+zKELh5YdhcJMTU3i
 7dw3hG8YOgC7sBYjqN4UGDKzJJeyhA5PIsYKk+S5D9Gja+1zIoHwus39CgZ6k7eoxHzL
 2gjJJ78coTC8wfT+7v40O08087NF6wJZ8i1zHPuBt6F80SQj9w3A5sxNeT8Stv2HpyXR Og== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmw6tcuqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 20:25:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 271KN8bZ010793;
        Mon, 1 Aug 2022 20:25:37 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu31ky28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 20:25:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAOz99NCQn3M5rkah3aFPmdWvSxU8dYtTPHOycX7Ug8v3rnpq3Lxz3/XcDKKH0Tb4fgjjaR/eXcVcZVXLS6IZqfW+XxSTu/423RoTVY0SaXluLtAa6YozyzY4avdEKjaTbpdczw5pZPxJTugq54CM4yKquQWpIXbJuyhWoEyKvsMapVOITidjT+Q38bexP0gNiRaXhJn8t/JG8Gk5VOU9Fv+ODrkN69iQdy7z6RKhkF1fPlrm1/C9kku6Ue7StgLhLfWW3eB/zkGhyDdpL1HJeuYkNbZU0h7wv9vmGLTiEc9BIv9nsprgKuYtEVcES9nzXPSPHNvpXpLhyuxTIpDTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKiuF9pY8zsVncsqlToE9xKVZH13FYRSEjYJjn3I8wY=;
 b=kIFrt3kqJ6rPUxqtn9ERv0cwUEUeXQfVYKZFMbwJcXqmiz8RDJ0uof501+X1i/kUgXCJ8jxSGI5JZx3l3u1EzbTvt/xQ5ibJOnTFuGh4JX+Dap9A+9ByNp7hr/sS4SZxcTiJhVZPEbmeurFwKK1mf8UzKRdQk/ozJjJFt+NfVQmoAHDD2cmIIRyOwq120CYE3IlnSOgZKwy7qsbcJHbIxriIC8Z/gapXhR6rDQsW0oaxwuRZWWsZOW4/uZXqVyqOFoNo83PmwsHthJcjjwJz6GCf/izTFZkfVXtSl3GDjFpSxNJzP7PUkLOhLKYY8+wN1iR4sz6pS/rKkN48o8A64w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKiuF9pY8zsVncsqlToE9xKVZH13FYRSEjYJjn3I8wY=;
 b=gGwQSwqePNuiZdt5MyV3lagpaOcN5YWrSKocT5Nunf9PTxBE5/bM/Bv4BB1IHyI3989O5EB7tuY7852fMPKQyNsg1ywsNrpnXnVcYRApr5nBpjA1ZXULyajAa8snajOM25X8a6RHXCeR15PvROi3Ka6+L17DRVBaj9nOD8SVN2w=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CY4PR1001MB2375.namprd10.prod.outlook.com (2603:10b6:910:47::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23; Mon, 1 Aug
 2022 20:25:33 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd%5]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 20:25:33 +0000
Message-ID: <984ba48c-c437-fd8e-e034-903d06b34164@oracle.com>
Date:   Mon, 1 Aug 2022 13:25:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] NFSD: fix use-after-free on source server when doing
 inter-server copy
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com,
        olga.kornievskaia@gmail.com
Cc:     linux-nfs@vger.kernel.org
References: <1659298792-5735-1-git-send-email-dai.ngo@oracle.com>
 <ea6d0556198dd6b77f1ab711401ca65bc39e9912.camel@kernel.org>
 <c969d149-36be-a161-2b2a-469dbf7b9bcf@oracle.com>
 <eec78149840c74bd7b8f2ac18c9f27efb5bcd54d.camel@kernel.org>
 <e8bd29c6-7d68-716f-1ed0-9f58436371c5@oracle.com>
 <71591d59a463ec90e5687788a6e1f9ee9c72bf1c.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <71591d59a463ec90e5687788a6e1f9ee9c72bf1c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::35) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fef4bcf0-5a0d-4832-7994-08da73fbfc36
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2375:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DH8lkmQOdjtjR3f34VkxxZWqcMpQdkKaeEDF/i361viQvnwgv5iNbrJPx+T8pmLMeLLCmHQlT98PnYwILpzSTlMnz4p+hljj/STLxsTyL0MKKQ6R84DVAl60a6xvTOvlr23Q4co/4rtyuTH4sBDrwdVbS5KHn23chcUtPCaxWd5fz2O0Ws8ZWI4bHlM7LOkH8nlMxaAPAEYQ1OdmKIdD6/sm85BNY+LPtEG+jE4ZDd9/yIUnEcL0ul0h77YWA9F0HJTFtOitHCQZpb/2VxRg/YJ4kDRySG/voEybwlGU+noadQmNIr41q9ivfM+ZcI+30HoyNBnwp4Awl717iUhAc+/lFcL6D7oSFxeOFUKhHJlQpp1Zld9eaRgABkf1tw2Ezr/8bRJ9ufpFqvtrcWPzq38UaA9NVhu1/4D+4xUrGJZquNof8NwJ+VRDauNMK3R5hQAZFI3cv6eLN+DYv4fdCv+PVT2hR50M03kgGkaHWA26lwXRs8PJ89RbrJoo1rq/l1x+oRDNLryBFskstTrMc0A0Db0v/KkA7KqolgTBmXUrkHXdQ93k8bXRGcPnMK4Dzvzxd42TmZ4Ok4+m7Iwc795YXSJAr6o+0Pfu0mEPEsLYY/EHh26aWNiQ2GaEOPkhjzsg/4WKhdnnVjBHXTIV+q95X3AFys2Dq7NQSyjhvzBmgk4pt1WjzMszGEygYNYS9vLqkkGbxcgFUwhulh7Bsrqma7BHMv+30P24vRM3GzC/TqwxT/MQ7QlgKW0Bs1jrr2VAcP5MIkVxM5jwXd0IKlhFLxkxZX15LeRU3QUxJ+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(396003)(366004)(316002)(41300700001)(53546011)(478600001)(6512007)(26005)(6506007)(9686003)(6486002)(31696002)(86362001)(2906002)(66476007)(4326008)(66556008)(66946007)(36756003)(8676002)(8936002)(5660300002)(38100700002)(31686004)(83380400001)(2616005)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUV0cDRweVJFRDF5RkNRSTZYbVBOYXZMV29PYnozTm8ySVl6UkhHcGdjYXZK?=
 =?utf-8?B?MkNOb3JJQStLdVA2RGN3MkhOdjlmTWJ0bUdEdUhPSnZLVHJjK1ZSa2Y3Z291?=
 =?utf-8?B?VndUcU9QNUhoMGxHWEhRK2dpcTRzd0ZGWDFVaVVjR1g2SzFoN2xFTUxjTEFo?=
 =?utf-8?B?MVNlWCtJRTFpVTRoVVJzSHZuRHNSZmQxR01OMzFOY0FHZk1URXNmaWE3Uy9M?=
 =?utf-8?B?WDIvWDRMUjZ2dlUrdDM3VnZrYllVSGF4VFdMakpTczBCUzd1U24xYVFzcnln?=
 =?utf-8?B?Z0d4Yk9ZUXd0ajBGZUpHZk9jWS9aN3dmaEFPbU5aaGsvRG9adFN0TzdZRkxy?=
 =?utf-8?B?a05Za0Q4OFpDNFdvK0RMT1NlbW9wZjAvM2NsK1g3T2RvdWRSS2hGTmtlaVFn?=
 =?utf-8?B?b2lKUVZQTlFvbTJTNFNadEJvOTNCbkNhV21wNXQrN0M2bkRidStmcm5ZTjEv?=
 =?utf-8?B?THcvT3RuOWZSdEM0WFN0aDdyZVRab1RVYkJSVUs3ZEdxalZBUFAvU1kxWTBR?=
 =?utf-8?B?RDFoRzg0UWVLY2JRS1NFYlE0YXExQ25FZTFSSjlEQkNZNkVRVjZjYUtLRVZU?=
 =?utf-8?B?NDdNWExoNjBMMmFxQmxTYUlRY1FzNituNWh5Mm45a08yM1lqSjA2WHZHajdW?=
 =?utf-8?B?UHVvbmZ5TldqMlFlUkI0UEY5WmVhdjRhb2VIVXU0RTRNTHpmRWxxRmVqTkwz?=
 =?utf-8?B?WnFabHlGQmIrQ3hKTDBPZnQ0YUJuT1VBbzR5anRubk9mL1VIVENaTVpVRzNP?=
 =?utf-8?B?QnM1eDh2NTVsblNiUk5YUHJwdy9OUXZzeDZlVitnMk53OGxhNnczTEkwQXd1?=
 =?utf-8?B?QXk2Y1ZxNHFabVB1dDFPaFB6cmtCa0tncHRlWG5mN3JUaXBMNGYyN1IrcHVh?=
 =?utf-8?B?ek5jV2owVEp1Y2ExMUVJUmNrVnVLWGxVNkhKeU9qalNsaHVMZDN6TDltWTY2?=
 =?utf-8?B?cjg1RStDQ1BiekdSdjFjODlTM1BkMXdZZWs4N0RmZWgzU1dDMlpuSVUzYzRo?=
 =?utf-8?B?SzJ5V0xKTTRhcDNvMnZTOFRVcDNhaFBUOEY0MzZjWWRaN2ljTm41a2ZpM2pL?=
 =?utf-8?B?MlY1Zi9FZXhod1FsV0JVZnpFSSt4SkJCOGJTaVMrc1FOeTdacEtKai9XMXI3?=
 =?utf-8?B?NDBEU3dMOEQvOFRaTllUMlVDNWl4RklTWDZncFF1dncyUVErci96eVlvN2to?=
 =?utf-8?B?L0xoUnpQRzZWNUVnYlpDNXh0bXlpTXEvaWQ4MVhGUzFUNEoxcUZXamszc3pK?=
 =?utf-8?B?aVJ6Y01zb3F6TDFnaEJoc3JMTHBuajk4VGtEZGRxWnFDUWIwd1hhakhoVFNG?=
 =?utf-8?B?MUNFbE1QVkFyVzZ4bjhWd1dZRU9QSVBQYXFqMHphcFhIR1RVY0pDUytnSGZ3?=
 =?utf-8?B?VkZtdXRmR0xoT3dCazVzNTdFTzZ2aUl1clYyM21hbkxqNTRDSHZUeG93d0Mx?=
 =?utf-8?B?S1JwcmhtNm44cjE3VXlVak5pMDJ1YUQxL1JPb1BmTW9TeUFYQml6dk14anhj?=
 =?utf-8?B?VW9uUXA0ektmZkJZZUFSTm1oUjRScmtPTWdnb092c1pYaktuYzdVNkpPS3ZS?=
 =?utf-8?B?ZUF0eTZZeWlSbEJOcm1uMmdVWTBaZ2IxS0oyL2hOaHJJRUErMnRMTTV0NEZK?=
 =?utf-8?B?KzdvUFBLOURyS0RRYXhXQ0pwSUlRaWc3bzRnQVJVdGNYdEE4VkRoL0s2Q3Bs?=
 =?utf-8?B?MDRVcmpycjl6VFRxYnd2M0lZRzVjZml0SnAwbkZETVlSU2NaSU5VOFFtditV?=
 =?utf-8?B?VWUvVkNIYWlZc3d3ZUd6WG50NFdBaTliSzZnMmJFRy9Xa2sxSkxoYngrRlVm?=
 =?utf-8?B?RkgzVEMwbUczNFgrL01hSGNub21Gd0FpeUttYTZkVXlDemhjSE0wMUFvQU10?=
 =?utf-8?B?cFRwLy9LTllzSjBaSlBFUGU3bVRRaG5sQlZMVkdDeE90QXIvaGNYV1JkRjBi?=
 =?utf-8?B?WkJxclAyVWpGN0haSjYvVEY2T0JFc1A1RDNiY3FwYisydUdyVENkNEo5MGFO?=
 =?utf-8?B?dFA2eURKSUNVVkJhT0tHTUlqRVhtSHZ4aVY2R2xQZXROaVdQVmtIRnBxcEJo?=
 =?utf-8?B?NWFxV0J3QU52N1pnV1ExaERpS25uYkhuUXE2RG9zZ0JUbHcrNXpLUm5qWFZ4?=
 =?utf-8?Q?5ZzT2dbAZIUQi628oY2ZfwMCV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef4bcf0-5a0d-4832-7994-08da73fbfc36
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 20:25:33.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEanEtoxVIMwApYa2fV4D/eArj1zlhqiWWGNyXly5rbzcVXdi+m54Si2CJeCt9Sy6TWRhrEogU4UkfNAJ8DCgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2375
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_11,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010101
X-Proofpoint-GUID: e1chsTXHAFNeaQ1hTnpFYB3093ylDbwR
X-Proofpoint-ORIG-GUID: e1chsTXHAFNeaQ1hTnpFYB3093ylDbwR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/1/22 12:26 PM, Jeff Layton wrote:
> On Mon, 2022-08-01 at 12:22 -0700, dai.ngo@oracle.com wrote:
>> On 8/1/22 12:10 PM, Jeff Layton wrote:
>>> On Mon, 2022-08-01 at 11:52 -0700, dai.ngo@oracle.com wrote:
>>>> On 8/1/22 4:47 AM, Jeff Layton wrote:
>>>>> On Sun, 2022-07-31 at 13:19 -0700, Dai Ngo wrote:
>>>>>> Use-after-free occurred when the laundromat tried to free expired
>>>>>> cpntf_state entry on the s2s_cp_stateids list after inter-server
>>>>>> copy completed. The sc_cp_list that the expired copy state was
>>>>>> inserted on was already freed.
>>>>>>
>>>>>> When COPY completes, the Linux client normally sends LOCKU(lock_state x),
>>>>>> FREE_STATEID(lock_state x) and CLOSE(open_state y) to the source server.
>>>>>> The nfs4_put_stid call from nfsd4_free_stateid cleans up the copy state
>>>>>> from the s2s_cp_stateids list before freeing the lock state's stid.
>>>>>>
>>>>>> However, sometimes the CLOSE was sent before the FREE_STATEID request.
>>>>>> When this happens, the nfsd4_close_open_stateid call from nfsd4_close
>>>>>> frees all lock states on its st_locks list without cleaning up the copy
>>>>>> state on the sc_cp_list list. When the time the FREE_STATEID arrives the
>>>>>> server returns BAD_STATEID since the lock state was freed. This causes
>>>>>> the use-after-free error to occur when the laundromat tries to free
>>>>>> the expired cpntf_state.
>>>>>>
>>>>>> This patch adds a call to nfs4_free_cpntf_statelist in
>>>>>> nfsd4_close_open_stateid to clean up the copy state before calling
>>>>>> free_ol_stateid_reaplist to free the lock state's stid on the reaplist.
>>>>>>
>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>> ---
>>>>>>     fs/nfsd/nfs4state.c | 3 +++
>>>>>>     1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>> index 9409a0dc1b76..749f51dff5c7 100644
>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>> @@ -6608,6 +6608,7 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>>>>>>     	struct nfs4_client *clp = s->st_stid.sc_client;
>>>>>>     	bool unhashed;
>>>>>>     	LIST_HEAD(reaplist);
>>>>>> +	struct nfs4_ol_stateid *stp;
>>>>>>     
>>>>>>     	spin_lock(&clp->cl_lock);
>>>>>>     	unhashed = unhash_open_stateid(s, &reaplist);
>>>>>> @@ -6616,6 +6617,8 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>>>>>>     		if (unhashed)
>>>>>>     			put_ol_stateid_locked(s, &reaplist);
>>>>>>     		spin_unlock(&clp->cl_lock);
>>>>>> +		list_for_each_entry(stp, &reaplist, st_locks)
>>>>>> +			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
>>>>>>     		free_ol_stateid_reaplist(&reaplist);
>>>>>>     	} else {
>>>>>>     		spin_unlock(&clp->cl_lock);
>>>>> Nice catch.
>>>>>
>>>>> There are a number of places that call free_ol_stateid_reaplist. Is it
>>>>> really only in nfsd4_close_open_stateid that we need to do this? I
>>>>> wonder if it would be better to do this inside free_ol_stateid_reaplist
>>>>> instead so that all of those callers clean up the copy states as well?
>>>> Yes, we can do this in free_ol_stateid_reaplist too, I tested it.
>>>>
>>>> The linux client uses either delegation state or lock state to send with
>>>> the COPY_NOTIFY to the source server. If the server grants the delegation
>>>> in the OPEN then the client uses the delegation state, otherwise it sends
>>>> the LOCK to the source and uses the lock state for the COPY_NOTIFY. This
>>>> problem happens only when the lock state is used *and* the client sends
>>>> the CLOSE and FREE_STATEID out of order.
>>>>
>>>> free_ol_stateid_reaplist is called from release_open_stateid, release_openowner,
>>>> nfsd4_close_open_stateid and nfsd4_release_lockowner. Among these functions,
>>>> only nfsd4_close_open_stateid deals with lock state that may have cpntf_state
>>>> associated with it and only for the minorversion > 1 case.
>>>>
>>>> nfsd4_release_lockowner will free the lock states but if the client has
>>>> not send LOCKU yet then put_ol_stateid_locked would fail to add the lock
>>>> state on the reaplist.
>>>>
>>>> I'm ok to move it to free_ol_stateid_reaplist if you still think we should
>>>> and don't mind a little overhead on the unneeded cases.
>>>>
>>> If you think this is the only way this can happen, then the patch you
>>> have is fine. In that case though, it might be good to have something
>>> like this in free_ol_stateid_reaplist():
>>>
>>>       WARN_ON(!list_empty(&stp->sc_cp_list));
>>>
>>> ...to try and catch cases where these objects slip through the cracks
>>> after future changes.
>> Good suggestion, I'll add it to v2.
>>
> Actually, it might be better to put it in nfs4_free_ol_stateid. If we're
> freeing an open or lock stateid and this list isn't empty, then
> something is wrong.

The linux client uses only delegation or lock state for COPY_NOTIFY.
However the protocol allows for using open state with COPY_NOTIFY too,
so adding the warning in nfs4_free_ol_stateid would cover behavior of
other clients. I'll add this to v2.

-Dai
  

>
