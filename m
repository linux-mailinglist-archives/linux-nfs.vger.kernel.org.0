Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6228582DDD
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 19:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiG0REp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 13:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241286AbiG0RDg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 13:03:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142D46D9FD
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 09:38:48 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RGBfYQ012160;
        Wed, 27 Jul 2022 16:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/5sBdIVuzL31XFF0hzaE6wVj2yx/bIGliDBQcmF5pDA=;
 b=sfusTGzmmOsiRpg40ywRkdddThRW4mCII9d3YzlH9BkrphE/Toz4zt23Zzbpwya/ZM5K
 EFJCMVCFXaFNkRmJkVpJ+UN1VSGq7bllzdhB7O1S9hWlKAbqrSXRyEUzWm+JNSi1qzy8
 RSEaARyP4wNfwATPPrcEaTT3o1d2br6UdlNwimfvH5DewqUmez/gGD/zk16aHyoDj8Ji
 2mdQen5Y1W2faSP/5wT4THPZfm+zJogagDAJ41Rwmc2I1i5C7mvNDg/a7bqe4qfmhy8i
 gAt4rYyRWPBPFflTeZAsqVcMYrNgT4vxAwvuB85NVamGpecCEjI5FyaurvqP8hFDeLgS DA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hstj7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 16:38:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26RFbFv4016641;
        Wed, 27 Jul 2022 16:38:23 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh6527e58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 16:38:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H56znCzyXqdN4JQD20jMDKeH+1toYU7wIPVn3Zv9c1GWkW2kKBDyeACc1DPtGolpi3dytioQajTvcvkeyT4vMIrku7kamqGmxCzGtqQ1lNRRTCK8paqFaAGlTdWRGuHS6h7RM48kS8it36xD1V8ZlUQsrSgstXio0CSfm5Y8K7HUOhk69pFrBCp5YUZkoPn1iHcD3WgMVdo2QL2Um5vcF08zVCpUuLdDNYBnlZc8Ixh+MSgdTCyxtkGSfWk1oHA8BLvluJqXX/1VloeikthEJdJHm8eM6KGzkSR9HZeiVMNg+Jh0Kv1cD6Ip6oA6WCdGIcTPTKHq96YMAxhN298SGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5sBdIVuzL31XFF0hzaE6wVj2yx/bIGliDBQcmF5pDA=;
 b=XVn4jbVlCr7khj25au100Jbi6TjxLHxUR6QCrEJo2ImvoiIacD9BLJR6WTLAmhQZURyAjItpWLeduY58Zj7HWAyrUeigRTackOfXH7e1qJcJ5FCjXxtRx9MeuxbVtirdetu8S+v34xPj0bq3THnaUH2hd38qntVdJt86Co1LMdAjuz16JUsowRNRZAU9WEhFlw2wKtyBrZz1yXaGFyZowlQMqHjM9m+MFmLkbggvNW/1GuCdqvYbf+jaSQKi6c7dhbbcVqWD4ssJvZ8X1tEG5Mwh1nYpgs4rLMeXwa9gaXVUjJmfTVKe/WUBKOUvMxiyisBcZgn/p/4OQ9VTOVzJ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5sBdIVuzL31XFF0hzaE6wVj2yx/bIGliDBQcmF5pDA=;
 b=Ch1PQQQP9G3ZlJg8xAos2zcwbHQ6WHE8Pva08bG6/6aJ9NPFVZad/J6UhWePIU6XH9UXkDZgfcdki5EmNLTLOxJgK0eZmUi4ix/UUTORwiipaBpS6zpS2U2uW5+cj1Ihql8R4blkzuMAjYyqmhTk7eg3WB4xz8mg+Smqt8ezyqg=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SN6PR10MB2431.namprd10.prod.outlook.com (2603:10b6:805:49::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Wed, 27 Jul
 2022 16:38:21 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd%5]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 16:38:20 +0000
Message-ID: <d36263e7-7f18-0fc4-2be8-2265f72a5fa7@oracle.com>
Date:   Wed, 27 Jul 2022 09:38:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v1 00/11] Put struct nfsd4_copy on a diet
Content-Language: en-US
To:     Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
References: <165852076926.11403.44005570813790008.stgit@manet.1015granger.net>
 <CAN-5tyEgRvvFq51kdT-ROo-ew71JE610Da=Cqf_Ya4dgYxEmKg@mail.gmail.com>
 <CAN-5tyEjNjEbR7YC7MMiYgCNEL0MdjRW+CZM71uZG1iO+YHwRQ@mail.gmail.com>
From:   dai.ngo@oracle.com
In-Reply-To: <CAN-5tyEjNjEbR7YC7MMiYgCNEL0MdjRW+CZM71uZG1iO+YHwRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:5:134::32) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4355a6f6-ecbd-4762-d9e1-08da6fee6a7a
X-MS-TrafficTypeDiagnostic: SN6PR10MB2431:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CgpEiZDzfcuMnHG24sefZ2tJlXhLeE2VJWgm6bRb3f0HGDfdXBYKMtdlmtn2PN0ZS2WLDqsWwZ7rcPCr/WJy7rN0YeF33Ws0uK51xD12p9SMllR8N6uwneOdaKHSYxhMB6RvYM22g9SYmraWG49Vjwl944z5ICBAB9KEvgxD2tH+Q2qa2myPSfVmFj6uP/8xXJh6lKFMy2iPJQVdXU3/9yZOrZZFoielgAjXq4U/rPazatS8h5WPCZkiesH7PwRtNCqV7pjdu5w9jwmPWCEuFlYl59ECs8sXPnRTLH6L1JpJ2GzxAI1LOMa1TIVgMW2TEs1UTICKK/cHPBXUU/UIQZ0XWBwLSB4cQJgo8fwAxuU9sko+sqcGmRSQYgKUTgg9AzAUGU2do2OK1tVAKmHTgZI2ryL/u9Ak5W/G0dOpi5jMOqwFwyUzke8kvHeC8x47pJddZ5+EW+TIGv8hF1FoNG89FX5qZbleMOzfKqOkRKNyzTEz2kPyutRSvC++Wsf4lo9je4Pf+I9oGquCnLe0Qp2NafClYaSINaavbDPnidMLxbJnYjQ6gVhYQt8sbEPalfdUlA/ekOByCDMYym9YrGwr4bN4exqtXIdEGN4AjqWzlpl6uMa7uf9/LkLr5uoZuvpvVx4p+0XwfOngUjCcUEAsdIgCjN4IFw4y3CEZEvuUA5Mv6Dnlo8LLIoPRT9/TJuBgkA+Vnot4a1RzMxBEpbR6jFJhGNQ8kQou7NWsE6PSMqwDEZqEVTEArS38tGOW0mxqS07zWpKWmA5DLrlHzm+UTC8kGK09aSU3Zj3Y7K1vDkVWxW6DHaRPjLCJkdiS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(39860400002)(346002)(136003)(366004)(66476007)(66946007)(8676002)(4326008)(66556008)(478600001)(5660300002)(83380400001)(6486002)(8936002)(6506007)(45080400002)(53546011)(36756003)(6666004)(31686004)(26005)(2906002)(86362001)(41300700001)(186003)(31696002)(316002)(9686003)(6512007)(110136005)(38100700002)(2616005)(21314003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDFBdlpzcnl3WnpmYU9LOE9TZG9ZSWg3U0xWcjhiM09pZ3BtcWxlejIzKzYz?=
 =?utf-8?B?OGtISTR2b2xPWWh2RDVramNQaGdjNXVyQTFGNGJqL2w2N0tsbmZGbzBNSlB1?=
 =?utf-8?B?dC9QVUpUR1JRNTh4M2trZTRtd2hXK0pVTXBJanJJQmFVeFVnZjdBaHRQREFP?=
 =?utf-8?B?OWhxUUNnQXhPVlcvTzJucExZbTlzWE5pbWRQVVBlcitaSkxhajkwem9WZnVw?=
 =?utf-8?B?VWp6MEVqd2tQd29RdWRBbVR6Sjd1Nk9YMjc5U25zYXRiRnZFa25Za3NMdVdS?=
 =?utf-8?B?RkMzbVR0UEdJRElzQllGbFZweVJZVnpsT3cyc1FCUkFmclZkOTV6RVJNRVhS?=
 =?utf-8?B?eU9CbkJMYXE3WThsZGJsT0dwYXpjSktDU0tqMFJCVWNzTG8zbjlhYjJkY01C?=
 =?utf-8?B?ck9wa3lEYWlPUlF6V2dFcUV4blVCaVEyZGF2TVNBWGU1MllMMDRhVmVKblU1?=
 =?utf-8?B?NFZtZzJYSDI5dmpsU3ZDM2cvcTFpMlNSV0pOVnVsSFBnckNyam1jWC96R21o?=
 =?utf-8?B?amE2ZGRYd2krTDB3NUx0aTluNWFlR1dtM0lCaDN4bVJlWVV3YVl4clNRL0RN?=
 =?utf-8?B?TkJKSjMvK1Y3bEZmVGZOUzZXWGxCV2s1dFhCdUcwL1dIUE53M2JlT1FvVVRY?=
 =?utf-8?B?aXVsTzNRalFPK3FHd2M5RGtMYk03NVlma3drU25WcnFwbEo0b2FRRDV3R2FE?=
 =?utf-8?B?YnBqUnE0U2Y0THkxdSt3WkxMYlZUMUI3WHBPMjJHZUFSYy8wUzZzWVJpc2RH?=
 =?utf-8?B?Wm9SVGx4Z3lSYmFhZVJnK2w2WThmRkNEZ0M3SW1uVkdjTlQzdlZNSG9ZczdL?=
 =?utf-8?B?L0RQWDlMQ2R0WjZHMWIvQzFqbzJwT3pVMHc4aWliazU2c2V0SHB4bHVUWERI?=
 =?utf-8?B?NFFGTnJ0OHI2TUExMWtKOXM4TEQ4Vkt3R2RSRERkVUxDVjhyZUFRYjNjMzNK?=
 =?utf-8?B?dUNqUVU0U0h1aWc5dG5NaWh2dDdwdWd4eFkrME5DbDJVdjJkZHFyWllITkUr?=
 =?utf-8?B?RGtzeFkvVjRUb0N3K1p2NkxTOXdrV0Q4Nm5KYjFxR2FGYlVoaGJxbk1xMjBn?=
 =?utf-8?B?d3JDT1V2UHZJOHU5cDZ4cDU2WHRMSmg5NHR4MUovcVRVeWNYNUxkdjZEdEhQ?=
 =?utf-8?B?TFhSV0hnR2F4ZWMvWjdKNFJBZTZOZ1pNeXZuRjhkU2pxQS9YTEpCc05DQWNM?=
 =?utf-8?B?UWtra3o5L24yRWQ3blJnY0xmV0FDdHl4YWpvYkRpL2RqL2Q1TkRsRXRRTW5X?=
 =?utf-8?B?Y3hGMEMvaWVyemJKSFFmSWJMUlZ3Q1FjT3ZFbDJ5RkVyK2FPT0d5VjFab2Ey?=
 =?utf-8?B?blcxOU5UaXpnampmcm5yV29RckJBOFRCMnZoRnJldkFhMHlPMkdubHhsZmJm?=
 =?utf-8?B?VVFRaUVCVCsrenFhRWg5ZzhVb0NTSHdPRlFraHNHMGlZUWU3aWQ5TThka3V0?=
 =?utf-8?B?MUcxLzZIUFZrMlJvd1FtcTFhSEswSWU2YmRnVzRhSXNxR3ptNUxUblY2RWxM?=
 =?utf-8?B?Qkd6djZnTHd3NUpUVmlqZEFUd20vdjFtd3ltMnhXYlZHeDBPS05idEZTcjRL?=
 =?utf-8?B?RDg3Z0dmbE5kbmJQVGhTbXhVZTN0T1lqQWtETFNYR3FPZ1ZpOXJXT3ZYaTVo?=
 =?utf-8?B?Qyt3a1ZsdkN0RUNDMmdlZmdnZG9tbVpHVXI5V21BSDBxNlNmeUVMQlZjakdw?=
 =?utf-8?B?VjJ0M3YrK1R5SlBreWtOQ0ZseDJlNVhCY0ZJa2U0ZnhkNnQ2Y2xzNHNRd0ZL?=
 =?utf-8?B?YnUrRjNUZFNJZTJIV2xPeHNPbWVWMmpZMERPVFdseVUxaFR5NDQxOTdZR29i?=
 =?utf-8?B?dUFldjhic1VxL25LUy9wQUZQZ0pXT1BTVXBqVlpnc29yOFZhZkVVeUt5b0FJ?=
 =?utf-8?B?TElSZlhrdVU1SDdUMFZ6bDlwOGdlT25ZWVhJNmE3M2owem9BbXBpaGJ6K3hY?=
 =?utf-8?B?YXVLcHRySzlybmJpM1lhNHBlUnJHZW1NRFBaeGxWTXY2NDE0bWFTYnBqbnUr?=
 =?utf-8?B?RXhEcDFuZC95L3hORzFkcEN0bkJlNHQ3S1hnQXJhRiszaFBVQ3BPV20yQmVJ?=
 =?utf-8?B?Y1cwQkhibXlmSlpKaDhFdFZ4SUMzZzZxc2FjTWlYNTc4NjcvTTVZM0dqV3c0?=
 =?utf-8?Q?U0w0VpyeKZbaG547ACLMT3YuV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4355a6f6-ecbd-4762-d9e1-08da6fee6a7a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 16:38:20.8494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhpat3tXvadCdEoSvGOcajIu9Ht1+Lr6GhK67dR4iv0biKPz+paEkz15p3R0vCt3jHtorXICZiQITN4PIOU0Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2431
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_06,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207270069
X-Proofpoint-ORIG-GUID: BnQbiU--Wb-gmlA4-zUkWXWs95StnQCB
X-Proofpoint-GUID: BnQbiU--Wb-gmlA4-zUkWXWs95StnQCB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga,

I got the same problem. Can you try this patch:

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 21830cc1ed0a..18dd708ff846 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1921,14 +1921,15 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
  
         if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
                 return nfserr_bad_xdr;
-       if (count == 0) { /* intra-server copy */
-               __set_bit(NFSD4_COPY_F_INTRA, &copy->cp_flags);
-               return nfs_ok;
-       }
  
         copy->cp_src = svcxdr_tmpalloc(argp, sizeof(*copy->cp_src));
         if (copy->cp_src == NULL)
-               return nfserrno(-ENOMEM);       /* XXX: jukebox? */
+               return nfserrno(-ENOMEM);
+       if (count == 0) { /* intra-server copy */
+               __set_bit(NFSD4_COPY_F_INTRA, &copy->cp_flags);
+               return nfs_ok;
+       } else
+               __clear_bit(NFSD4_COPY_F_INTRA, &copy->cp_flags);
  
         /* decode all the supplied server addresses but use only the first */
         status = nfsd4_decode_nl4_server(argp, copy->cp_src);


-Dai

On 7/27/22 9:18 AM, Olga Kornievskaia wrote:
> Hi Chuck,
>
> To make it compile I did:
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 7196bcafdd86..f6deffc921d0 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1536,7 +1536,7 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>          if (status)
>                  goto out;
>
> -       status = nfsd4_interssc_connect(&copy->cp_src, rqstp, mount);
> +       status = nfsd4_interssc_connect(copy->cp_src, rqstp, mount);
>          if (status)
>                  goto out;
>
> But when I tried to run the nfstest_ssc. The first test (intra01) made
> the server oops:
>
> [ 9569.551100] CPU: 0 PID: 2861 Comm: nfsd Not tainted 5.19.0-rc6+ #73
> [ 9569.552385] Hardware name: VMware, Inc. VMware Virtual
> Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> [ 9569.555043] RIP: 0010:nfsd4_copy+0x28b/0x4e0 [nfsd]
> [ 9569.556662] Code: 24 38 49 89 94 24 10 01 00 00 49 8b 56 08 48 8d
> 79 08 49 89 94 24 18 01 00 00 49 8b 56 10 48 83 e7 f8 49 89 94 24 20
> 01 00 00 <48> 8b 06 48 89 01 48 8b 86 04 04 00 00 48 89 81 04 04 00 00
> 48 29
> [ 9569.561792] RSP: 0018:ffffb092c0c97dd0 EFLAGS: 00010282
> [ 9569.563112] RAX: ffff99b5465c2460 RBX: ffff99b5a68828e0 RCX: ffff99b5853b6000
> [ 9569.565196] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff99b5853b6008
> [ 9569.567140] RBP: ffffb092c0c97e10 R08: ffffffffc0bf3c24 R09: 0000000000000228
> [ 9569.568929] R10: ffff99b54b0e9268 R11: ffff99b564326998 R12: ffff99b5543dfc00
> [ 9569.570477] R13: ffff99b5a6882950 R14: ffff99b5a68829f0 R15: ffff99b546edc000
> [ 9569.572052] FS:  0000000000000000(0000) GS:ffff99b5bbe00000(0000)
> knlGS:0000000000000000
> [ 9569.573926] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 9569.575281] CR2: 0000000000000000 CR3: 0000000076c36002 CR4: 00000000001706f0
> [ 9569.577586] Call Trace:
> [ 9569.578220]  <TASK>
> [ 9569.578770]  ? nfsd4_proc_compound+0x3d2/0x730 [nfsd]
> [ 9569.579945]  nfsd4_proc_compound+0x3d2/0x730 [nfsd]
> [ 9569.581055]  nfsd_dispatch+0x146/0x270 [nfsd]
> [ 9569.581987]  svc_process_common+0x365/0x5c0 [sunrpc]
> [ 9569.583122]  ? nfsd_svc+0x350/0x350 [nfsd]
> [ 9569.583986]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
> [ 9569.585129]  svc_process+0xb7/0xf0 [sunrpc]
> [ 9569.586169]  nfsd+0xd5/0x190 [nfsd]
> [ 9569.587170]  kthread+0xe8/0x110
> [ 9569.587898]  ? kthread_complete_and_exit+0x20/0x20
> [ 9569.588934]  ret_from_fork+0x22/0x30
> [ 9569.589759]  </TASK>
> [ 9569.590224] Modules linked in: rdma_ucm ib_uverbs rpcrdma rdma_cm
> iw_cm ib_cm ib_core nfsd nfs_acl lockd grace ext4 mbcache jbd2 fuse
> xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT
> nf_reject_ipv4 nft_compat nf_tables nfnetlink tun bridge stp llc bnep
> vmw_vsock_vmci_transport vsock snd_seq_midi snd_seq_midi_event
> intel_rapl_msr intel_rapl_common crct10dif_pclmul crc32_pclmul
> vmw_balloon ghash_clmulni_intel joydev pcspkr btusb btrtl btbcm
> btintel snd_ens1371 uvcvideo snd_ac97_codec videobuf2_vmalloc ac97_bus
> videobuf2_memops videobuf2_v4l2 videobuf2_common snd_seq snd_pcm
> videodev bluetooth mc rfkill ecdh_generic ecc snd_timer snd_rawmidi
> snd_seq_device snd vmw_vmci soundcore i2c_piix4 auth_rpcgss sunrpc
> ip_tables xfs libcrc32c sr_mod cdrom sg ata_generic crc32c_intel
> ata_piix nvme ahci libahci nvme_core t10_pi crc64_rocksoft serio_raw
> crc64 vmwgfx drm_ttm_helper ttm drm_kms_helper syscopyarea sysfillrect
> sysimgblt fb_sys_fops vmxnet3 drm libata
> [ 9569.610612] CR2: 0000000000000000
> [ 9569.611375] ---[ end trace 0000000000000000 ]---
> [ 9569.612424] RIP: 0010:nfsd4_copy+0x28b/0x4e0 [nfsd]
> [ 9569.613472] Code: 24 38 49 89 94 24 10 01 00 00 49 8b 56 08 48 8d
> 79 08 49 89 94 24 18 01 00 00 49 8b 56 10 48 83 e7 f8 49 89 94 24 20
> 01 00 00 <48> 8b 06 48 89 01 48 8b 86 04 04 00 00 48 89 81 04 04 00 00
> 48 29
> [ 9569.617410] RSP: 0018:ffffb092c0c97dd0 EFLAGS: 00010282
> [ 9569.618487] RAX: ffff99b5465c2460 RBX: ffff99b5a68828e0 RCX: ffff99b5853b6000
> [ 9569.620097] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff99b5853b6008
> [ 9569.621710] RBP: ffffb092c0c97e10 R08: ffffffffc0bf3c24 R09: 0000000000000228
> [ 9569.623398] R10: ffff99b54b0e9268 R11: ffff99b564326998 R12: ffff99b5543dfc00
> [ 9569.625019] R13: ffff99b5a6882950 R14: ffff99b5a68829f0 R15: ffff99b546edc000
> [ 9569.627456] FS:  0000000000000000(0000) GS:ffff99b5bbe00000(0000)
> knlGS:0000000000000000
> [ 9569.629249] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 9569.630433] CR2: 0000000000000000 CR3: 0000000076c36002 CR4: 00000000001706f0
> [ 9569.632043] Kernel panic - not syncing: Fatal exception
>
>
>
> On Tue, Jul 26, 2022 at 3:45 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>> Chuck,
>>
>> Are there pre-reqs for this series? I had tried to apply the patches
>> on top of 5-19-rc6 but I get the following compile error:
>>
>> fs/nfsd/nfs4proc.c: In function ‘nfsd4_setup_inter_ssc’:
>> fs/nfsd/nfs4proc.c:1539:34: error: passing argument 1 of
>> ‘nfsd4_interssc_connect’ from incompatible pointer type
>> [-Werror=incompatible-pointer-types]
>>    status = nfsd4_interssc_connect(&copy->cp_src, rqstp, mount);
>>                                    ^~~~~~~~~~~~~
>> fs/nfsd/nfs4proc.c:1414:43: note: expected ‘struct nl4_server *’ but
>> argument is of type ‘struct nl4_server **’
>>   nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>                          ~~~~~~~~~~~~~~~~~~~^~~
>> cc1: some warnings being treated as errors
>> make[2]: *** [scripts/Makefile.build:249: fs/nfsd/nfs4proc.o] Error 1
>> make[1]: *** [scripts/Makefile.build:466: fs/nfsd] Error 2
>> make: *** [Makefile:1843: fs] Error 2
>>
>> On Fri, Jul 22, 2022 at 4:36 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>> While testing NFSD for-next, I noticed svc_generic_init_request()
>>> was an unexpected hot spot on NFSv4 workloads. Drilling into the
>>> perf report, it shows that the hot path in there is:
>>>
>>> 1208         memset(rqstp->rq_argp, 0, procp->pc_argsize);
>>> 1209         memset(rqstp->rq_resp, 0, procp->pc_ressize);
>>>
>>> For an NFSv4 COMPOUND,
>>>
>>>          procp->pc_argsize = sizeof(nfsd4_compoundargs),
>>>
>>> struct nfsd4_compoundargs on my system is more than 17KB! This is
>>> due to the size of the iops field:
>>>
>>>          struct nfsd4_op                 iops[8];
>>>
>>> Each struct nfsd4_op contains a union of the arguments for each
>>> NFSv4 operation. Each argument is typically less than 128 bytes
>>> except that struct nfsd4_copy and struct nfsd4_copy_notify are both
>>> larger than 2KB each.
>>>
>>> I'm not yet totally convinced this series never orphans memory, but
>>> it does reduce the size of nfsd4_compoundargs to just over 4KB. This
>>> is still due to struct nfsd4_copy being almost 500 bytes. I don't
>>> see more low-hanging fruit there, though.
>>>
>>> ---
>>>
>>> Chuck Lever (11):
>>>        NFSD: Shrink size of struct nfsd4_copy_notify
>>>        NFSD: Shrink size of struct nfsd4_copy
>>>        NFSD: Reorder the fields in struct nfsd4_op
>>>        NFSD: Make nfs4_put_copy() static
>>>        NFSD: Make boolean fields in struct nfsd4_copy into atomic bit flags
>>>        NFSD: Refactor nfsd4_cleanup_inter_ssc() (1/2)
>>>        NFSD: Refactor nfsd4_cleanup_inter_ssc() (2/2)
>>>        NFSD: Refactor nfsd4_do_copy()
>>>        NFSD: Remove kmalloc from nfsd4_do_async_copy()
>>>        NFSD: Add nfsd4_send_cb_offload()
>>>        NFSD: Move copy offload callback arguments into a separate structure
>>>
>>>
>>>   fs/nfsd/nfs4callback.c |  37 +++++----
>>>   fs/nfsd/nfs4proc.c     | 165 +++++++++++++++++++++--------------------
>>>   fs/nfsd/nfs4xdr.c      |  30 +++++---
>>>   fs/nfsd/state.h        |   1 -
>>>   fs/nfsd/xdr4.h         |  54 ++++++++++----
>>>   5 files changed, 163 insertions(+), 124 deletions(-)
>>>
>>> --
>>> Chuck Lever
>>>
