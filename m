Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5017267DB
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jun 2023 19:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjFGR5U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Jun 2023 13:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjFGR5S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Jun 2023 13:57:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B56E43
        for <linux-nfs@vger.kernel.org>; Wed,  7 Jun 2023 10:57:17 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357EidMD001986;
        Wed, 7 Jun 2023 17:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VfNYo7chgpndGxlQWznS9EMY31a4PFezFNK66tP/KVg=;
 b=Lgt1cmk9vLpmd4s2H1ePsOhPx4iWdKcL5BsYH9M7FTpYVaaKjBRvaKXUFztm1IaBNT0O
 Q6HkJbO+SOnd1fZ/FVAvqF3AkymJ/b/DcQ5iQbfxtgUeTSC9WG87xm/ANBOH9Aqblvik
 KKHjhgg0Oaw3cl+aotYbQhijtTn7vm11ZOtRvZu+Z97YjU8Q+8J7w6E1AY8qjyTwYPHK
 BAYC/qvxHbYMc5El5btoD5KIuDdaUDuO9Y6efhL0opVOAOEagxb41QbFQl7CZf4EzGvu
 SlmJOsPB2Q7cDFyV/LyiUL8qBMriNxcoKUPPG2w6ZFJTwv88BrlZpLmqYtxlBwsfA22C 3g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u2d4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jun 2023 17:57:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 357GOS1C036791;
        Wed, 7 Jun 2023 17:57:14 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6k301c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jun 2023 17:57:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YI32JqSwHjVZvqXnppUeAqyLL3y7emboY7x4UCTdr0tDRWGrQBKdvhPQjiay5i7NA5HDygGjDQRgDDKaNG7mNmPaqBnI56dNls7Tx2XDB8DSH7iK8e6PhvOmAE9NLngPwc43KKR5eQskVWQ4vnEd2sLro6H0IuNqhGvS65iA6lzjP9/2eJQraWmkmO6n7QMYsbZNuQ0ppl6qepUW8+Z1lBN/MLkdjUROrxzFBmWdVBWzq3c/uo6HJsujAaX21CbcwpWuT67OPgnvQMAZC6+Gn9uZ6HZGIgzoYsDXrUV9n0IyJqGIWPccpiyyseNREXATOWywEVAxxPzGW3cPshBKIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfNYo7chgpndGxlQWznS9EMY31a4PFezFNK66tP/KVg=;
 b=GtjUeV70ODyb8yPNVT87rnsDaUKQORQKHXiThNTGKtsld7sCkpScL7UT3vTTOyijWicDw6zJNchsSlTRDMtX3/UZWHW9zobCuLsvkNi1W8T73PKfV4YgNuCPS15KY3370Kc9fVCm1F8Om1Jxw9HICCw84HyVXbNmhPylUQUc1SF+gBFHTXkbxXLC1JzJ5yXRW7VJfhc32t036It9c6fQZK910d9Io3PPrVIKRAIGOSFL62eamtTUFH7q2nK6UATmKAL5K+h2J7HJeTpFqtGr/Ueou0elc9KBnLgwu/nfKG6ZPoId/uOPI3cfypoPcPM6yI2GsE/LP4NQV1FxVh/pYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfNYo7chgpndGxlQWznS9EMY31a4PFezFNK66tP/KVg=;
 b=UIFIDV68B6oURONkup4RMBBwzMBXA5nsJ4PlWAhqlA+7GdtL17yZFxki3K5ZDuBGbpw3EaI/1iti9yHz3OfRPu+lcewlcwzh0FDm8WFopJ4YJ3jcyMT5fif31rEFNnJzT6mfVQsbkHUK0TwH4P10YjjzQvbtmMWbPzCFnj9iMSk=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 17:57:12 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8967:3473:fad7:4eb]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8967:3473:fad7:4eb%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 17:57:11 +0000
Message-ID: <60a5121b-f099-c858-10cb-11c02c4cfe8c@oracle.com>
Date:   Wed, 7 Jun 2023 10:57:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 1/1] NFSD: remove dead code in nfs4_open_delegation
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org,
        linux-nfs@vger.kernel.org
References: <1686094819-13044-1-git-send-email-dai.ngo@oracle.com>
 <ZICTbiPEyk0OrlRS@manet.1015granger.net>
From:   dai.ngo@oracle.com
In-Reply-To: <ZICTbiPEyk0OrlRS@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::27) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CY8PR10MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1eb97d-3bbf-4d02-30f4-08db67809e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OpgQXRA3tLLrxeOgAwSrk5KE0Rd41ZB+mEne/Jl9XGR57gaIz3LRsud6SgPg7WOGBaWcEQt7Yyra/gpkiUImlNUWzI3kf7T2+dxFniZOwx+6s9D5UGF/Tc8c5rzgs6JLp5gEzbqsIdtjkr6Wig/jUsiY6G0Aj992AEFpdb40dLQUFarygdI8rTSZUOurG6FAIvMD1FkXHycotgUm1YbJI01Nm7uOEU/UNaTrWgMNcRUmMgm00hvutjyPT/o4IQgYsfI6wyiNUgbNA7c68B3h4KDYl/OhFCSpv/LvTLSMKTIOHWs7RPrWV8YeO6rJVWHid1D4b2+DVDcOffj/wH4B0v5mLOd+ybfLdmGcyW1J7V8AkmmsRAqS00sLzyg7qDaCGVtt+YIgYD61n7mzP3eXbLllUFAvZCv43UnD6NB92MbGznA5bPD065DYDLdNf1YZhYgt2dNV/wvv+N7gcjDWgooEP+0c/fpWWY4UcCxrZHL9a60uPtWk+YkYmKdhAgTkbrHpiVMxu4dba5q8/wk85r8ktFzFpHx3sqLmXJvtgjYLNg+wqfY2NMsLFaegDdHH3GFPueLQvJUpW4vAH9+W1IbzTgl+j144wH1AtqBQLWC0D83B/h4K2MLoRdePvJ3B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199021)(83380400001)(2906002)(2616005)(36756003)(31696002)(86362001)(38100700002)(41300700001)(6486002)(316002)(5660300002)(8936002)(8676002)(478600001)(66556008)(66946007)(6916009)(66476007)(4326008)(31686004)(6506007)(9686003)(53546011)(6512007)(26005)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmVlYW9OWm1YV0dCOUQzMXZLd3ZFbW9TUXFpakNVUGk3NVVSS00zeW4vUmgw?=
 =?utf-8?B?WTdDNmdJbitoczRGSExvbklLOGNEWnhkS3QvTUhMY1ZvWG5sYkVOSDVIM3hT?=
 =?utf-8?B?VGVvdzJKM1h5eW1sTUdxRjRaUm5uMStnTnA1dzY1M3ZKUWRPenFvNVFvYjh2?=
 =?utf-8?B?NWIzV3hrQ3BHWG9KWWl2S2ROMHJtbXpHQ3BVLzdqTS9BSlcyMnlIUHdrRXo0?=
 =?utf-8?B?U3MrTGw3ZWcwT2lENkVvMTRKekhuMm9HNjg4RnNwRFpYTnF0dFkvMnpYc1F5?=
 =?utf-8?B?ZFdwd0VBSEVkM21oaUgyWDk1OEdjeEdab3VhaFVKYjJuT0JkSWxhWDRISHFk?=
 =?utf-8?B?MW41Q0c2ZEZRR01yY2ZaZUJHWUJmM2Q3REJUVXpWMTUrUitlcFZTdWFSY29y?=
 =?utf-8?B?Z3E0UVhKQ3pWZktNcDJnWVdwUlpqdGprRGg3c0JobzBJTXZGV2V3UUdFbmdG?=
 =?utf-8?B?c3NobWZIWWRzS0FPVWp6TUxKY2NLdW9LVkp3SW9KQ2RPRHBBSnhDaVRPaGpO?=
 =?utf-8?B?dGpVM0x4djZMU2ZsQzVOcHVjK2R3UkRyQ2Rnd1cvOXgva01BRFB0bU1PRURI?=
 =?utf-8?B?aGpKUkp1ZFJCRHZrV0VBa2ROcFhQamNqTHpldkU2MCtyZk9DMWRyZElRella?=
 =?utf-8?B?S21Md2E0bkh4TUpZWnVRTlNqcmN5RWwxNzBMTWRUdE9pdWc0TkY0THZSWklZ?=
 =?utf-8?B?SGtiQUNud3MrUnIvSzdlR2dYNk1pQ1R3bmRMSENkNlMrWEtIeGovTkMraGFH?=
 =?utf-8?B?WGVNU1A2ZkFjQ2ErenhhZFlvR2gzclZBK3RwdTBONCtsUkY2WkxCZ0ViaEwx?=
 =?utf-8?B?OHFsa2VXWnNKUnB5UGF3S2k0ZVY3dktQdk5oTllaWWNQVUZQZGxkYzVOTjFl?=
 =?utf-8?B?TUJBbHpmTTR1Y09CbVd0TnRkYWU1U1Babi9YaUQ3L2lhWXkwQ1dQcDNFb3NG?=
 =?utf-8?B?UXdHeDBETm96U0UwTWZZYkIxc0V6S2FKaXdhYXZjZW11SjQ2SVdFaTQvSHhj?=
 =?utf-8?B?bnZYeWZyQi8wL2Mvb0c5eVhVSFhjUmpUV1hRQnB4NHoyeU5taXNsR0srUXpQ?=
 =?utf-8?B?UWRVWURHQWhWd3RCVk96cGoyUzlNaHhqUng1OHFDRitLM0FXWE1IenFqbk4x?=
 =?utf-8?B?KzBONDEySzNSSThjamhBNVVBclkxbEZLSXlBaUdCWlZUSWtkTWhTTjlQRU5J?=
 =?utf-8?B?OU5FVzhEUFJTeklTdTJQYllTZ3phQ3FHTHZzYWMwdkQ5OGtuMGlEVjJ4bXhp?=
 =?utf-8?B?NEQ5LzJneVY4TzRQOXY2aGxKVDVqaDFMZWpweE04Q1BYb1R2TFhCd25hY1g3?=
 =?utf-8?B?aU8vMHpxWVFKSWlweUIrWE42a09heUFlUlNBS24zYVlJanhaOEpqOWQ1bkV5?=
 =?utf-8?B?TDJjTFpIZjRvRmo4aG0vSDRTdVFHVzRzZW1yUUt4bmpxcUtRcWJmejJObjBy?=
 =?utf-8?B?blozenNqd2svRUpSaXdvRDRXR0liRGY4WkNXZmV6bEt4KzFKWjR2L1ZMSVRv?=
 =?utf-8?B?TjZLaXV2eElKdzhoa0RwVFdLZVdObk5rdXh1MXcra2N3bVRJRDZOTDVPZVdt?=
 =?utf-8?B?Ny9HQnFHdWZlY1FPN3VlT1drUUtlR0xuaTQ5WmdIemRGeFVCdlMvVG92bVZs?=
 =?utf-8?B?VnZ2Q2tsdDFYVUNKaXlZSTVvQWs2NFA0NSsyazFSWG40VVk0RjFXVzVjWld2?=
 =?utf-8?B?TlJQQWdVSUhOUG1iMTcrVnI2a0lTSE84b1hTUHg4aWxialk1a0pFL2d2Tjdw?=
 =?utf-8?B?QlZVVFpIYnRLWVRyR01VeEVPT2IwQzdNT01TRWFSYk1zM2hDUEgxWGtudUlw?=
 =?utf-8?B?NVlIQlhlSzhTSGJsdFBPTzdjSWJaQkdlVTl5bjVVb3h1V2hPdFhLaitHcU1i?=
 =?utf-8?B?eUNhV2kxcFF0b1JZZzRLMVEvbWhvT0pYV2t6THdQUERTSTdHWmk1ZE1DUCtR?=
 =?utf-8?B?alZqaDA0NmdBN1RJa3N4RDduZWpqRDFsL0lJWFFpMFhqRDRIcE9yeXV2TDlv?=
 =?utf-8?B?OWcwVGp2bDZXTVB1ZEk0Z2tLUW5UbnNjNmQvYVJEVnU4Y3VZSGJocDFDWkFE?=
 =?utf-8?B?SlI0QjRwYUdnQytjS1prbEdCdnR5YjJJb0Q0RWpCWG9zZ3VXNzcwblkyL2xO?=
 =?utf-8?Q?5QrM7N4BKcTn7jpAzLfveJ3/w?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: V/zE4zr5VzVz9GO8vlRZYZUNrBSO7dC+wufnZXNnpi4tXgM7ZPweObZul0up7EjulEn1q9HhVZmhLxqjUCvsC6Zb51mgvxSGkfcNsMqENYrSIC1qNta+azzG+bbky2d+H4ehHgOOrSaVnhX398ltAoYpjDIUDm9CGmtCph5pbiHHGi6llUATqP8z5Z4yAny5i/wLoyYyu74LvCOjl9EgLImk4YahIWJulgHFZfaoKtVtKSet6Vpa06jcEiwfZdkrpsN54synMGi+tXFR+SqxYV1LD5aObLq4Zxe08mibNib6jGh3ByQ+XLQY/tl54Su1Q97Fmceg4XYViChdbWgqQEr0Xj9gzSIPXm3slDRSlv8qZ4y47kOag3Vm4yn8v0MNoW4t/KuoOOKwBfXZZXyCwamOFp2287Cl3NYiYyS16jZQbmqtVzO/7UU5E8gnn727oH7d64E7XHvNnDb76CW7liZDhhbGYEzZJDUteDPLtzX2wQrynLjl8wF+V4TsAUBXSN11Y5c1SEGGpiwvCk4IOBRILnInLaNcjZ2aff7S35Aa1g6jLRnAlzu9AvikOToYzF9XgxWRrMgn3bSx2JjiaosKRG/JNrMefpBVxReG8bRHdbEk3e4lJIbFjbApQ8Lujh5qKbB1YquArGOfQveSaax9B5hlgtrTim2OfezAWyYz9vcVzQBEAq2zVZ1Shky3FII+1dp1EfGbuvdezEc084uCcYCcXFFdn2O1XYlsYlE7nPrdwGOIYZMw2U7TQMn2KPGcu2yYB0YuB9/EKXu5lOZTqnYrtbRJ1AmWJ+SZw3s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1eb97d-3bbf-4d02-30f4-08db67809e87
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:57:11.7920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: duueaH8BAN7b+qZPGH1gO/RuBvWvCQzi3grAj+yLPhIp+26eq8O9wkFPszQZ/nGbyV2guMbujkZQKcAsqHVePA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_09,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070153
X-Proofpoint-GUID: 0D--HaLZWI_3ypQE03_ioqNqGb1NNDac
X-Proofpoint-ORIG-GUID: 0D--HaLZWI_3ypQE03_ioqNqGb1NNDac
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 6/7/23 7:25 AM, Chuck Lever wrote:
> On Tue, Jun 06, 2023 at 04:40:19PM -0700, Dai Ngo wrote:
>> The intention of this code is to tell the client to return the granted
>> delegation immediately for whatever reason in the case of OPEN with
>> NFS4_OPEN_CLAIM_PREVIOUS. However this was already handled above in the
>> cases of switch(open->op_claim_type).
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 6b75656d3e8f..58c78a23f90b 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -5632,11 +5632,6 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   	return;
>>   out_no_deleg:
>>   	open->op_delegate_type = NFS4_OPEN_DELEGATE_NONE;
>> -	if (open->op_claim_type == NFS4_OPEN_CLAIM_PREVIOUS &&
>> -	    open->op_delegate_type != NFS4_OPEN_DELEGATE_NONE) {
>> -		dprintk("NFSD: WARNING: refusing delegation reclaim\n");
>> -		open->op_recall = 1;
>> -	}
> This is dead code because it's broken. Look carefully at it: it sets
> open->op_delegate_type to NONE, then prints a warning if it isn't
> NONE. The warning will never occur, and neither will the recall.

This is why the name of the patch is 'removing dead code'. I can be
more explicit and add the description you have here.

>
> This code came from 99c415156c49 ("nfsd4: clean up
> nfs4_open_delegation"). Can you have a look at that old commit and
> make sure nfs4_open_delegation is working as it was originally
> intended before it was cleaned up by that commit?

I don't see any functional differences before and after 99c415156c49
other than explicitly denying write delegation by 99c415156c49.

>
> Even if you decide not to change the diff, the patch description
> is confusing. out_no_deleg: can be invoked /after/ the switch
> statement, so I'm not seeing how the OPEN/CLAIM_PREVIOUS case
> is handled in that instance.

In the case of OPEN/CLAIM_PREVIOUS, if the back channel is not up then
op_recall is set to 1 and it continues on to call nfs4_set_delegation
to see if the delegation can be granted. If the delegation is granted
then the result of the OPEN is delegation granted but op_recall is set
to true, causing the client to return the delegation immediately.

> The description also needs to at
> least mention that the removed code never worked properly.

I will describe why it's dead code as mentioned above.

-Dai

>
>
>>   	/* 4.1 client asking for a delegation? */
>>   	if (open->op_deleg_want)
>> -- 
>> 2.9.5
>>
