Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C7B5AB6C4
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Sep 2022 18:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiIBQoV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Sep 2022 12:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbiIBQoT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Sep 2022 12:44:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B0DF7B1D
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 09:44:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282GCJgn001632;
        Fri, 2 Sep 2022 16:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=mu/T4akswNe9xdOGuGiMOY0DO91w4jYUOkeFxAbZ604=;
 b=e/SiDnS8bUWtVpaQdw4gDv2xDQUhqvAA93EQZv05Dtu46m1D/AitdcosHlDXIHlOfb9b
 SD7r536DzshG/AeBBSlJSBeMWQC06wnfFscUlfuurnq+TiFX9F5r+rDfZls32n9Gu2VY
 ZDAVbaFBp1r8TsSr3+kR36yAL45yobeyr2uDs4bjyPtFkJ7WAGRDxOEz1PYNjAP7NVu2
 kwmTgoQNI2yUlBb82XMYN0ywujYaRAW34JKJEAUfrT3Me+q/i69ufPF6WPjN5Ex1sdF/
 pSQhrQmNvRro96cpfmxxFzN4LhgdgPAW21/vGxWspoWHTZhvNJ3PycNxK6SdU0MnFvb4 wA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7bttfpx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 16:44:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 282FibxG002065;
        Fri, 2 Sep 2022 16:44:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jarqm2s5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 16:44:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/mqUqZ/R6zlD9U13Uq7MxP+WcN9USwvD+sXBFYk42wj7hp9PcgtdElcCz9Ww3S6Jaccsy5ceWA/F7UZnZN32TgJYoLaMlsNgG4VsA2U7VSsUfNLNr3+S1j9nUCYQaSzSVRElt3vqhQebq3pNm0M/wfBuYKSR8Y2mSPcVF+tA+u+9yl37TWPajr5GCYBV3UmJ3lFpyGhA7Wr1prB2oMX391uuZfrHY49F31JhdKaeoo1Yy/jP4jZkR0qnegl/zpiY7rtId1x9oWx6517I4tlEHuOl8mZwC6WCGGudrs842IoyDNCq8oPJHP1wNzZhVxnnAuquT4+LDClcCPNfkpOpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mu/T4akswNe9xdOGuGiMOY0DO91w4jYUOkeFxAbZ604=;
 b=i14jAwe4o7KMuiWZUsGWlgCD6+8NHCrbl22Gp3ZAiWmlFYEQdvEyw2DxSGOtlYPk1IXdtTU+iGyMjy00N26apY3eEigOLrUnIS7jIsrFJgy5jo9CV0YZ/dn+x76YL4CltcTClQXH5nOsf2vgf5E9Cc2G7z01JK5+qPyC9DYFnLmldhH9f7eSadyKEWe+a5oRIT0mR1AeEXg6/pPoEP3hSFREBCmsNrpoasE+XfBgvxnwOyXmTWKxIFMH0+N06fqXSoyMj+Mef5EwSt86OGBFHM26aJdnsa7Idlkce3jpCSFf44LB4Yf2FLSQ3eEMf4otqDpJ0bQew686Nm411AntFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mu/T4akswNe9xdOGuGiMOY0DO91w4jYUOkeFxAbZ604=;
 b=pmNLUZ3nc93xnKr29hAVk+PInQ1VXsy7hvj9oy6cGpz/ChUL6lAx50xwU4dag43fLhS9O7si7MMXr7bfOTsv1q8V88vGoBb74xUG3+KLVsJDjubsBJrQFaNXIAVtk8oq+oTSzG0Z/zRSzPM0QZdWl5kEM/WmQXwsjwAqnpRsrTM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH0PR10MB4678.namprd10.prod.outlook.com (2603:10b6:510:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 16:44:11 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::803:3bcf:a1ee:9e1c]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::803:3bcf:a1ee:9e1c%5]) with mapi id 15.20.5588.010; Fri, 2 Sep 2022
 16:44:10 +0000
Message-ID: <eb197dde-8758-7ef4-8a7b-989273e09abc@oracle.com>
Date:   Fri, 2 Sep 2022 09:44:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v4 2/2] NFSD: add shrinker to reap courtesy clients on low
 memory condition
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1661896113-8013-1-git-send-email-dai.ngo@oracle.com>
 <1661896113-8013-3-git-send-email-dai.ngo@oracle.com>
 <FA83E721-C874-4A47-87BA-54B13E0B12A3@oracle.com>
 <2df6f1fe-c8eb-d5a1-0a11-2fd965555a33@oracle.com>
 <7041D47D-ECB3-497E-9174-96E9E36FFBDE@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <7041D47D-ECB3-497E-9174-96E9E36FFBDE@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:5:3af::17) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51992ed6-c07a-4dda-e09c-08da8d025c6f
X-MS-TrafficTypeDiagnostic: PH0PR10MB4678:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZpgaJzN5+71NJMYAHUoDtJUYsHIztdy+c/CMb5wrtgxurnGrZ2ZfKKkCQibhGpqWLhQoOd/a2M39k2rAXGUQH+ATG0duWHLDlOdUJf06oyicJ6bw52hItVEyaEXsgp4h+z/vkp6YFDxyAswIL50rNtNVl9qzyiqsx420QrVnUI+13T43Iy4czdv+YoaPm916Gowb6pzaOfUqRgVRIFBcyX52PuDDMdjaKrWtF6dgo4tbD7yl8oU5LGOW0BTMmBMst9SpavhctzXcloDdnJPt2gShD6QcpQslqeZ1pj16oFkfewJahxwAvtMnw3ttKM3XJj545CCeJhQ7TekFq0FPaCV58G1hGncLZdeFHK6IffB+mD21qlvvu+5rwq6Z8phMKTBzAs1aRqLxxj3znFdHEh1Mc+rJvmJLSjt27QcHSbi0CfkvXjk8I/jLbIjE7OFvrbh2t/fB3GUjSxfw0QpgdOL98g6RmWUGr4C1Jn1IPd2DSYa+oQd2t0N5EnjIaALKKQ2yPtIlP2oUkodujBqmUFSPfLucxFVOsqX/pQKUF6ZCeauGBW6PL03bswMBDTzCGI5F3z1mAzjQzKZnSoG0zsKBYqUlUDLCqovOHHUJFXQTPn35LJGP3/H5lLTWIuUooR5zxD296bOiBM5a4bA7qwwGoAdfSaVUuxZBmXqEZie7/SESErLKteCLsnfVkgmoR53BcPhHJrffUP8drKMjI3M/DQGqwdXEOpsxrZ6+Xwhi+r7Muh+5+49a72c4xOuK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(136003)(396003)(376002)(346002)(316002)(6506007)(38100700002)(53546011)(26005)(6512007)(9686003)(83380400001)(36756003)(31686004)(37006003)(54906003)(8676002)(4326008)(478600001)(6486002)(41300700001)(8936002)(6862004)(5660300002)(6666004)(186003)(2906002)(31696002)(86362001)(66476007)(66556008)(66946007)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUdhMUd1bDdLOGh0N05PSitwbFlwQ3dUc1BCZ2c1YlRrRVVKdWo0VURCSVJ4?=
 =?utf-8?B?NE5wT0I4QlBGaFA0UEkzdUpRbjloQ1RyTUl6SklxWGlPZEd3eWxaaXFxOHJN?=
 =?utf-8?B?RTloRWhVRW4xT3hVc28xZEZ3VVlEcHQ4dnlKamNURFluK1Y2UERTejJBeUNG?=
 =?utf-8?B?OTh0OEpnNWJIMThsUUpvUEdPL1RORitEUXF6VjArSmlyQllIbjVEQzRHSGN5?=
 =?utf-8?B?NmdHa05kMEVsWjNLY1JMdW8wYXJISUJyVUR6SUZpckUwVlR2Qk0xcC9jSHJH?=
 =?utf-8?B?SGhnMzMxNVZuOG1RZEhsV2E1LzVBSU81RCtaWWovYVlTLzRUeVhqUzQ1WTZH?=
 =?utf-8?B?TGkvcURPNEtMZ01vU1ZnMXpBUzRuOGhIdnVGbnJXczVJWVRaa3pzQ2oxdUdl?=
 =?utf-8?B?dVpLZDIrNHZLUmh6QVZaMElPbHAwOHRLbDZsSzJPb21BLzV4SkRrNDU1ZEJy?=
 =?utf-8?B?K0lVT1BBTHVmZStnMnhaYzlNOWVEYXdvSjd6dHh4SFZ1U0l1cUwxNjhaNVJo?=
 =?utf-8?B?aTlBSWZac0ZrWVI3Z1RrMEFUQ3A0QVBaNm5jZXZMOGtEcC9oL1VvbTBKckIw?=
 =?utf-8?B?OEtsb0RsS3FqZEpnVVJORm5OYjNJRmM2L1dJNHhzZnFOV1E5aGtxeDFCbnla?=
 =?utf-8?B?TjNaNXBjV1ZPYWdPQkNGeCtJYjRNMUFZNVp1L2hNNmdhSFZ5TUFqNEZDU2xh?=
 =?utf-8?B?eDE4eWZQRTAvOWZIRmhHWjh3NHVJVlFSOXNiMG84cHQ0OVdObStuVFI4U2tK?=
 =?utf-8?B?NDA2bm5SV2lCd1IwbEc0dmpiZWw0WkVzdmpLUVNFbTNuMXZ1K0JDV21rL2lS?=
 =?utf-8?B?UlVPeWl5UnY0Z1E1c3RrRVE3ZmdzN3JkR1ZoeFdTbGRoZm45R2czV3RlWUdj?=
 =?utf-8?B?T2lCNStCV3B3bWhreEZFODIyTnJqWFRvbFNDV1IvNU9PaDBEditCZ2V2WkIv?=
 =?utf-8?B?ZU9YRThnaWNmcVF2OHV4U1gvM1VKZ2xvc29LTS9QUCt3ckxXNUpBMEhBU0Vx?=
 =?utf-8?B?TFAxbUxtSHNCVlZuYitoSDRYUFRUVzhYa3FLU3duV2ZUcmhsOURQYUFXd1E1?=
 =?utf-8?B?RFBhck5icllNbVhMV29jdHE3dHhvSUIwZVJ6dElvYnVUWjhoczI4OHBhbW1F?=
 =?utf-8?B?c3p0MmpidWl5WVlGVkxBOFdaZjNVWmMzREs1akpvRmdPSkxEVFhuNklteXBr?=
 =?utf-8?B?QlpsYjMrRm5wTWQrMkRVSlhXRXdLVGZkcXp1RXBkb09CVTd4dEhlNmhzQVBt?=
 =?utf-8?B?NStzbytnTElEbm5ZUFVocVZsNjZIQ3MvektRd2RycmNaMndoOHowZml0STdT?=
 =?utf-8?B?aitiekJlRE5QSHlOYmdOTlhNTXpyTmJTRzBCbE5tcmNwTFlJRHBQMU9hSnkx?=
 =?utf-8?B?TmV6T0syZGlsTlNMWTR0TlR6NE40c1k2ZFU0L3pKWGR0a0dEalRic2ZvcVdo?=
 =?utf-8?B?N3BhaXZCOTJOdGNoVmFJeUIrUm54bFErdy9vZEZwbndZajNPMnV4eUJpSTBX?=
 =?utf-8?B?UU1TaVhlMCs0cm1ZaU91K1BMQlNqeGRpMDRrVWdWTVBGOG5NakhRVVR2eSs0?=
 =?utf-8?B?dUZQVU5rZUk3QmplQXNlSXNvQnJ5R2FiQTRxNCsrcDE5WEpjSFRJZFhRSE5n?=
 =?utf-8?B?ditIUHd0a0dSOGhvajFTOHFKNWVYNE1UcTI1VzVIU0RDeEgrd1hzUGFtcFdC?=
 =?utf-8?B?cFM4NTdpTUcyRC9aV3RTVmI3TmtXU3hCZ0t5TWFhVUltMWY0R0lyeXNoVXdV?=
 =?utf-8?B?MzBjZURCOFZpSU9lRm83ZXRNZmw4ZFNROUFzYTFqZGtMbjlwZXpma0M3Qmxj?=
 =?utf-8?B?THVCeUdDK2xjd2dRSmdHQklSTWdNOGFhOHg1R0JxU0YzOW5ieTRjaGxNVlB6?=
 =?utf-8?B?R2tzZlNFSnpUQkRETmd2MVM5OStia2FRbGIvcVBycktNT0JTTGhPSDFzYnVP?=
 =?utf-8?B?T0tPdkwzeUhkQ2pjM3c4R2tsZlFTazRQT0VKV0ZmR05tWExpdlBzMElPZERM?=
 =?utf-8?B?NXVRdlRFcnBBUG93TWs2V2hWVFlpQ1ZaeUo5NEVWd05lY2J1VzNkSmttQWpl?=
 =?utf-8?B?TkVKUlEvaGh3aEg1SU51aFNBN3Urb2w3d3VUaVcrRmNrSE8yVm5jRXR6eHU2?=
 =?utf-8?Q?PO9CLcRx/ES6vdILTobhY/PLS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51992ed6-c07a-4dda-e09c-08da8d025c6f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 16:44:10.7726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6g7wpGQZG8G1WzSgvI379DYi/yihFX6+ugEB9QBFGTh/Su9woYTxgMtAfUbDWhdJS5FWwUW0TTZb+yGmgJbXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_04,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020079
X-Proofpoint-ORIG-GUID: 7TfGzpdnoe73d5lzSS8-yObX7VB8iS2o
X-Proofpoint-GUID: 7TfGzpdnoe73d5lzSS8-yObX7VB8iS2o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 9/1/22 9:32 PM, Chuck Lever III wrote:
>
>> On Sep 1, 2022, at 9:56 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Hi Chuck,
>>
>> On 8/31/22 7:30 AM, Chuck Lever III wrote:
>>>> 	struct list_head *pos, *next;
>>>> 	struct nfs4_client *clp;
>>>>
>>>> -	maxreap = (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients) ?
>>>> -			NFSD_CLIENT_MAX_TRIM_PER_RUN : 0;
>>>> +	cb_cnt = atomic_read(&nn->nfsd_client_shrinker_cb_count);
>>>> +	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients ||
>>>> +							cb_cnt) {
>>>> +		maxreap = NFSD_CLIENT_MAX_TRIM_PER_RUN;
>>>> +		atomic_set(&nn->nfsd_client_shrinker_cb_count, 0);
>>>> +	}
>>> I'm not terribly happy with this, but I don't have a better suggestion
>>> at the moment. Let me think about it.
>> Do you have any suggestion to improve this, I want to incorporate it
>> before sending out v5?
> Let's consider some broad outlines...
>
> With regards to parametrizing the reaplist behavior, you want
> a normal laundromat run to reap zero or more courtesy clients.
> You want a shrinker laundromat run to reap more than zero. I
> think you want a minreap variable as well as a maxreap variable
> in there to control how the reaplist is built. Making @minreap
> a function parameter rather than a global atomic would be a
> plus for me, but maybe that's not practical.

I'm not quite understand how the minreap is used, I think it
will make the code more complex.

>
> But I would prefer a more straightforward approach overall. The
> proposed approach seems tricky and brittle, and needs a lot of
> explaining to understand. Other subsystems seem to get away with
> something simpler.
>
> Can nfsd_courtesy_client_count() simply reduce
> nn->nfs4_max_clients, kick the laundromat, and then return 0?
> Then get rid of nfsd_courtesy_client_scan().

I need to think more about this approach. However at first glance,
nn->nfs4_max_clients is used to control how many clients, including
active and courtesy clients, are allowed in the system. If we lower
this count, it also prevent new clients from connecting to the
system. So now the shrinker mechanism does more than just getting
rid of unused resources, maybe that's ok?

>
> Or, nfsd_courtesy_client_count() could return
> nfsd_couresy_client_count. nfsd_courtesy_client_scan() could
> then look something like this:
>
> 	if ((sc->gfp_mask & GFP_KERNEL) != GFP_KERNEL)
> 		return SHRINK_STOP;
>
> 	nfsd_get_client_reaplist(nn, reaplist, lt);
> 	list_for_each_safe(pos, next, &reaplist) {
> 		clp = list_entry(pos, struct nfs4_client, cl_lru);
> 		trace_nfsd_clid_purged(&clp->cl_clientid);
> 		list_del_init(&clp->cl_lru);
> 		expire_client(clp);
> 		count++;
> 	}
> 	return count;

This does not work, we cannot expire clients on the context of
scan callback due to deadlock problem.

I will experiment with ways to get rid of the scan function to
make the logic simpler.

Thanks,
-Dai

>
> Obviously you would need to refactor common code into helper
> functions.
>
> --
> Chuck Lever
>
