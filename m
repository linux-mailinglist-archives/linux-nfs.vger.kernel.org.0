Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C247E6263B0
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Nov 2022 22:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiKKVey (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Nov 2022 16:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiKKVew (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Nov 2022 16:34:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B836417
        for <linux-nfs@vger.kernel.org>; Fri, 11 Nov 2022 13:34:50 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABLEIU4011150;
        Fri, 11 Nov 2022 21:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jGPo7zFyzY/vRdyX6FvX44jKzgz2Pr32q7K1X9GXmyg=;
 b=w7QUgs7QzuMxpvAHJ923nxoB0kBU2Omaq3ptANO6JYI5dhH4GryUykWOSfN1j/vqoTEB
 kAVnT/dxgLCn5JfAZCLDIAH0KtwZ7PEiqF7oj7dtyFVV3Iq/UeIdABn6vNGPYXKYbkNF
 iGbYfezsda1wJUjJYfWRsh6SGyn2l7b2u92KNdpV3ZXDUzt87GA7NfPpkGbZYgWffk31
 Ghw71uGd/qvMOstPc+zxnfJlcL1lWd9sPveE3Ng2uSt9/Ehg6cMK8DGu11nS0ap+8GRb
 1ZuMD94kJHx2e8ReHSqA9V/lwdqPWIE9cd6Zyp7XMx2NMKCtLqQyxFLTWN7y6P2s2xXV nw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksx4qg0yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 21:34:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABJva1g011711;
        Fri, 11 Nov 2022 21:34:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcth1w01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 21:34:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFXy55rv+D9q0uhHAyKNW1qtXTvrPWT0pHrd44M8a4KRg8YM6s+RcKSUmEoBvb8Gtq0NCQSPWw+XQaH4Ch/QnFylhfghQnMmYU6QDrLNN3V7a8zHU1UCC5pDQKIcIRXnmT4IibgcoOUlO5YU1hEhExP5rxmT+qX3lmVka3C7y45o4PMXocoMylIrVTxROGxTX4zRf7nGG55BHHrzy2X2uTcZ57h7ksTQuDDbQ5sliwnMqWY+8VWGWJe5E/XfcOHqnKR0nxeirl4QREko2WPqPkjqKbW43gttSmX4YB3O8mgD0+CCyi4i2YLDrjE1AuC4BPTaoSVWS+G3ZDvsf+sm7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGPo7zFyzY/vRdyX6FvX44jKzgz2Pr32q7K1X9GXmyg=;
 b=heplobaIku43UosdAFcx1+9kkHWejEDO4/UzEedgXfuAbuzZdKciciitf6I8+1ra+30lBkhrX1LwOM2NiB62aGbLvYtb2ywn9X7fZL0M2ySOyxhSULrNVN++VmRPqw7alwpoBzZax1+aeQZ3pGtFlifJTgwSgUuyr/NgjLUeDi6ganmh+SmQGIVpVMSo0NQyijEDoGJQRQfZIEXhGyKkphykMMc8PzedegYbnZRdaZxekd57Dni/PLl6QTPYgGyFg4pEzOUm1NZC3iR2irbp7lZ4dPT8J9gr44kEk3S6bf62w8rX2pA6enEowpRuEvr6lred0405e/FDRiwHAciOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGPo7zFyzY/vRdyX6FvX44jKzgz2Pr32q7K1X9GXmyg=;
 b=qLuiwzdPx2cek8dVvHz07Tl9jqi8lzACsw9jHNniZm+zbQUm63CgWoBXpglWIT1JgrkKJNTNdZNLv3s7fGlAm9w6BGpWa9TkAobQYNfpFA9h80GYrWyi50f5qfHFnzRpgUy+bBinFBnPzzxhEPckR76CJHVqPwbhjLhFYOpLzPo=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 21:34:41 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2d62:ce4b:356d:e242]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2d62:ce4b:356d:e242%7]) with mapi id 15.20.5813.014; Fri, 11 Nov 2022
 21:34:41 +0000
Message-ID: <b6901519-a423-566e-f447-af8590ec407b@oracle.com>
Date:   Fri, 11 Nov 2022 13:34:38 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v4 3/3] NFSD: add CB_RECALL_ANY tracepoints
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1668053831-7662-1-git-send-email-dai.ngo@oracle.com>
 <1668053831-7662-4-git-send-email-dai.ngo@oracle.com>
 <F69554A8-20BB-482E-AF8A-94F90B1081FD@oracle.com>
Content-Language: en-US
From:   dai.ngo@oracle.com
In-Reply-To: <F69554A8-20BB-482E-AF8A-94F90B1081FD@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:806:130::6) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CH0PR10MB4876:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d15a9a-938f-4527-9cbe-08dac42c8a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ptVKtgDZBMh+AGGuCyPdGaqwa5KcVFndrcmXiX2FDYE7jOJPfstMfh7ur6jtARpCp8LdzUtOVdijqyDJSg65VMzs8ClJTyuNiBnCotlezZXcIRIICVEbu4TCkhEuYNV/PNkWn4rohkLsBXvRG0aEhxol8O2R7S2cQs2W9S/EOETIYmgcTw+7DkvkZIWZdfGqbOJxXaE/2DIO5iTX38zoRvEnvMooY+/HMbUemYCM1ENwDpl2roXOHKOaIrPt2QKUxq+EB4Kn7Fyb91+RcCKnkD664Jc6cq+tSWupMfAGQUwU31lmcNUkXWeQYJyJx8FLdPgmjmv+pLTSu946jY+rzsFevzqdV4v+Z4UgZIT3kcwSI+WJlyRnQBfa8udQOuoCXh6pxciCDv7/YU/A1wnxkKoSKzJA2cnui+iuo03do70YpZJ9TJ7LmKxFGenno4drKC6DhiDJa8Gvf7RwdeNKVqiaineI6nEPb1+B1WZZRqz3F/kSBJ3tTsfRFo9i7o5CckHtb3R2NDA4n21fIRcFmwfyFb8SIEvihhMWN/WC/MFPRPe0cyOFuqNbsW36DXDWD3JxzKYKqs0m46T/3H81CwKQpiUUjtgFBeDScebxAFEsL56iZmwMyKC+PmPTUo7VAJ2QHT79XQ1zifkZ9aBPc2g4aZjxx1BYvouDe9h4JEK5f1ZD4TpsBjdUk+drzqidanYFYwLPaAA+2RKxoY6DTTJddwtu2S95JUcCqEw1gj124yQEQnmlO5BNoI2FyInM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199015)(37006003)(54906003)(478600001)(66476007)(316002)(9686003)(66946007)(6512007)(36756003)(8936002)(66556008)(8676002)(41300700001)(6862004)(4326008)(53546011)(6506007)(2616005)(5660300002)(26005)(186003)(83380400001)(31686004)(86362001)(38100700002)(31696002)(6666004)(6486002)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L21WOGt4UEo5TU0zQUtoUExMcmI5YjJFQU9zT2FDNVptT0tYdjdPNEVtMXg2?=
 =?utf-8?B?cUk3MHlMK0daL0VGTFc4N2w2VnhmQko0UHlrVnAzSmxUeGpBYVk3YnNMeGhK?=
 =?utf-8?B?cUk1S3RETkxtZkJCK293S3REb1AwdjJGRmVpTGNPaW1mZG1VSlpNS0JvR0tB?=
 =?utf-8?B?SVY5bGpXdVR4OXRnb25lTWFLT1cxanNhbjhzenEyR0Nka2JPWE9pL1JxR2xG?=
 =?utf-8?B?SDNaWHRHay9aMjhHQkN3R1R3Z3c0UjUxdzZoNXdweFYrcEQ2R2RqanIxNkwx?=
 =?utf-8?B?Q3FUdzMvUVhHeStmNm5tN2FXbzRPdExaMW8wTG1FU3ROcWdKNWV1UEpBOWRy?=
 =?utf-8?B?WFB6eGZ0QTJ4NGw3UGV5djBoVW1PVklISUVLeGZNNmxsRlB3OVludHZFcGF5?=
 =?utf-8?B?a1pVT0NhdGF6TVBhckY2SGRyaU5tVWRxYkVJNlFnaXl6U1JkN1ZMYTF4Y3Uy?=
 =?utf-8?B?MExzYmdqZDFyN09ZbVcxUWFaQjlYakx1TkRtM3dQbERVNFA3cnc2NUdHVkxq?=
 =?utf-8?B?ck9sVStwRUhUa2Y1K0x4a2dGNGJQU1hDREJPRGlRSllGZXVQaVh5c3JtL1da?=
 =?utf-8?B?bjNiWjFRUWNjMTltMFFNcnVpc1BYcXB0T0tnVUQzTjFKZDloME9MV0w0amd0?=
 =?utf-8?B?Ny9RZ3AyMU9lbVhKWWFncnpOb3NpSkVxQXkrQVVPeWhYN2daMm1Sak5pTCtK?=
 =?utf-8?B?alRPOENoU2EwYkdTMGxnajZEblVSbVo0dlFhWEJPVVpYZWtPZklldzRtNmMz?=
 =?utf-8?B?WU5kZHFLRk9Oalg3VWVOWVdpMXhwMVlEMWNQbU14ZkQ5czZNaXZhSTRnV0xL?=
 =?utf-8?B?SnNCOW1kLzRFSUgycEx1NEFjSDZGUVBXMkk5Zk1OU1lGUWxBanV5S21MU01C?=
 =?utf-8?B?MlVRdmxaaWVqbHRrMFVyZ2dlWVhOc012eDM1ZDJKeThSQ1FWRWtJU1N1MVVz?=
 =?utf-8?B?Tis3RnMrcE9tbnhQNDVvUWxZRHltcm5PREhwYmhYc3E2bkE3dlFzS0s4SHh1?=
 =?utf-8?B?RGErQW0yM0dEWFFLa3Z0QmM1TlIwSXFrY2w3TVRiVFJnTTdjUTZydUxrRjlU?=
 =?utf-8?B?cDNKbVRUVmdXVUkyenBvWW4wUDFLVGlOamE1UG5ZZVQyU0xWRTFnNU1PVVpY?=
 =?utf-8?B?TnpMSkVaSUtvdG1DdGtBMjFhK0Z3MzZoT094VWs3bVZUc0hPdnplSlRpUytp?=
 =?utf-8?B?VTRVVWpRQ29tYmNHSlZySkxkdEtPVnBZL0IxL1o4eDh5cGZJMUJjVjViU1Vs?=
 =?utf-8?B?blZ2RnZTMDl6cDV1WHZpdjdsY3FETGx2NWJOSDBXaTlBQmJZS1VGS2F0eU85?=
 =?utf-8?B?ODdTSk5CdnZkcGJJM252S09LK3dXcjNjUm9VQ3FESTIyTm01TGRId2Z4U0Y3?=
 =?utf-8?B?ZTQ3bVVoLys4a3BuNEJudEo3QlkyRUxNNnZhOFJRZnk0bkVtMnIrVjUrOWhV?=
 =?utf-8?B?SnBnK3ZXQ2dUbWtBZmY2TzVXclpxUm9NRWErZC9ZZTh1QldyQkh6WkVlM3ZX?=
 =?utf-8?B?OTU5bTFUUTJWVXp3ZnFzay9HN3c2MlpOb09ESzFjR2dxRkdiRkFFN0tkVWc0?=
 =?utf-8?B?SFhuNCt3TWpPb2VmUXdlVytVRFNYcWJRTXVVMFROWUc0U1VOcEFQMlhhcHVE?=
 =?utf-8?B?dmNoVUNMdzEyV212UHlweS9GN3VHak8rZWs0RnRDRHVvVHdldUdMbC9kRE1i?=
 =?utf-8?B?aERzK2xrM041OE9ZNVYyQ28xcCtRZythUWFIZjlpM1NEK2JGTGNOQjV6bEM4?=
 =?utf-8?B?dXNvQWpoR0ZJU2Iva1I5VHIySnJJT2tieGg5UVFyL2xzV3BCVC9CdS9QQVhI?=
 =?utf-8?B?MVU5ZnpleHdoc2hoaFFwMzQ1c2tJbUd2dVArRG9sQ0wyUkJ0c2VxSXdMb1My?=
 =?utf-8?B?OG5MdlIyRTVzblVqSWkwUnU4RmpDcm5lSVJ6cU5acjNyMVZ3V1B1TE5WRVNC?=
 =?utf-8?B?cmZMdHZiY3I5b2ljcjFOT1ZycVpRWTVia3p3N296T1N5WVlxU3pWRys5LzhK?=
 =?utf-8?B?OEk0K3k2bG45eE5oa0h6WkJJL05haXFaaHV4UFJxU1ZMLy8rWkJxZEZ5N2Z1?=
 =?utf-8?B?c3pRTFNydHJRN0RTS21XMjRNcURja0pYU3V2MGp0cStEKzdaWmFTMGc3dHNF?=
 =?utf-8?Q?+QmgsrpsasjoYWJ2LWR2luRXp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pCBewgZRgbpxwh6XGKhAuyr/rryf4d+Rf2tH3fGxZQozh1cNIin1QdCIzSSD7v+HtvYYyGW5jdNT2MbNVxN6Hhcd/0p8wR+a0mYGJh0mIFVgg37DO1f74j0imcC5YRko9CcI9mt+/DOKmQQ8xpvHUgsmFSDziUlJOgx1iLgg8dPmnnoQI5m7daLyqYAYCL4bGgcn8QmFI9Ql7E93XLaXfZ6/3V8sFAs3eV0qoN1fH0rINlGnthhKliBeK2SSpEu3yrxim/K5pRKH5qbSsjkit9kliCLBzGhNhqg3yPMQA2l0pkZKZb+JSdpnhyvQgUAfy9PikmEyZ9o2lywD3qDHD8dtIF19vXCexTt6Ma/rFCC68HJyslW0nc4RTJSUyD5Hq+VLrOlRyNoHRviWIa4cDmhIOxYFT09qeTcBLYdgv5Dje2GEZh/9wVyzigt1f/wFCIbJLBCrFWURFHhNvuKOU2ggYuiPYwmEBvm6kOOyAjYQCNbQFtJ21PUZ3kTknz+MJ2ZeFPnNo/DH4Nw1W3484O63BNY7Bv76DxF1O4iuaEb10cjYXKG6gd60EKwyRdngAGbZR97/Nz32d1YfDVfSLUPE019tRpJE7l+0zXCAO2eBQiYaCoQBqCosefmJJFqBfrWYcjsifTr6nbA4AemiuAyrAxXGDjwYEIs3smFHqqu2RiFzmL+l2kP5ngolZHlHEIvin4C0TI6+mTgtneV4nqiCdxadRlEFaikVhcrGl106dQ0OX+wwg1Rm2p4yDCpdOKTNPCZj9UX4kTtfNJOWSSehiL8UXcbmkls/BJiYck8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d15a9a-938f-4527-9cbe-08dac42c8a8e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 21:34:41.0272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WpiwXn/slxTv++P4cqG03HYGIlqDB06Y3CzGZqx+QzRzVF2zB1fmfNhcnQVStEh5Tr7sN0E7STOrUnpe6Nb8CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_11,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110146
X-Proofpoint-GUID: gR5Y2pdIMSFF0KdHPIbp7piCOZieNeVW
X-Proofpoint-ORIG-GUID: gR5Y2pdIMSFF0KdHPIbp7piCOZieNeVW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 11/11/22 7:25 AM, Chuck Lever III wrote:
>
>> On Nov 9, 2022, at 11:17 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Add tracepoints to trace start and end of CB_RECALL_ANY operation.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c |  2 ++
>> fs/nfsd/trace.h     | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>> 2 files changed, 55 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 813cdb67b370..eac7212c9218 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2859,6 +2859,7 @@ static int
>> nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
>> 				struct rpc_task *task)
>> {
>> +	trace_nfsd_cb_recall_any_done(cb, task);
>> 	switch (task->tk_status) {
>> 	case -NFS4ERR_DELAY:
>> 		rpc_delay(task, 2 * HZ);
>> @@ -6242,6 +6243,7 @@ deleg_reaper(struct work_struct *deleg_work)
>> 		clp->cl_ra->ra_keep = 0;
>> 		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
>> 						BIT(RCA4_TYPE_MASK_WDATA_DLG);
>> +		trace_nfsd_cb_recall_any(clp->cl_ra);
>> 		nfsd4_run_cb(&clp->cl_ra->ra_cb);
>> 	}
>>
>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>> index 06a96e955bd0..efc69c96bcbd 100644
>> --- a/fs/nfsd/trace.h
>> +++ b/fs/nfsd/trace.h
>> @@ -9,9 +9,11 @@
>> #define _NFSD_TRACE_H
>>
>> #include <linux/tracepoint.h>
>> +#include <linux/sunrpc/xprt.h>
>>
>> #include "export.h"
>> #include "nfsfh.h"
>> +#include "xdr4.h"
>>
>> #define NFSD_TRACE_PROC_RES_FIELDS \
>> 		__field(unsigned int, netns_ino) \
>> @@ -1510,6 +1512,57 @@ DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_notify_lock_done);
>> DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_layout_done);
>> DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_offload_done);
>>
>> +TRACE_EVENT(nfsd_cb_recall_any,
>> +	TP_PROTO(
>> +		const struct nfsd4_cb_recall_any *ra
>> +	),
>> +	TP_ARGS(ra),
>> +	TP_STRUCT__entry(
>> +		__field(u32, cl_boot)
>> +		__field(u32, cl_id)
>> +		__field(u32, ra_keep)
>> +		__field(u32, ra_bmval)
>> +		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
>> +	),
>> +	TP_fast_assign(
>> +		__entry->cl_boot = ra->ra_cb.cb_clp->cl_clientid.cl_boot;
>> +		__entry->cl_id = ra->ra_cb.cb_clp->cl_clientid.cl_id;
>> +		__entry->ra_keep = ra->ra_keep;
>> +		__entry->ra_bmval = ra->ra_bmval[0];
>> +		memcpy(__entry->addr, &ra->ra_cb.cb_clp->cl_addr,
>> +			sizeof(struct sockaddr_in6));
>> +	),
>> +	TP_printk("client %08x:%08x addr=%pISpc ra_keep=%d ra_bmval=0x%x",
>> +		__entry->cl_boot, __entry->cl_id,
>> +		__entry->addr, __entry->ra_keep, __entry->ra_bmval
>> +	)
>> +);
> This one should go earlier in the file, after "TRACE_EVENT(nfsd_cb_offload,"
>
> And let's use __sockaddr() and friends like the other nfsd_cb_ tracepoints.

I tried but it did not work. I got the same error as 'nfsd_cb_args' tracepoint:

[root@nfsvmf24 ~]# uname -r
6.1.0-rc1+
[root@nfsvmf24 ~]# trace-cmd record -e nfsd_cb_args
[root@nfsvmf24 ~]# trace-cmd report
trace-cmd: No such file or directory
   Error: expected type 4 but read 5
   [nfsd:nfsd_cb_args]*function __get_sockaddr not defined*
   cpus=1
     nfsd-3976  [000]   410.956975: nfsd_cb_args: [*FAILED TO PARSE*] cl_boot=1668201586 cl_id=2938128369 prog=1073741824 ident=1 addr=ARRAY[02, 00, 80, 93, 0a, 50, 6f, 5f, 00, ..]

I also tried Fedora 36 and got same error.

Can you verify __get_sockaddr works with tracepoints on your system?

Thanks,
-Dai

>
>
>> +
>> +TRACE_EVENT(nfsd_cb_recall_any_done,
>> +	TP_PROTO(
>> +		const struct nfsd4_callback *cb,
>> +		const struct rpc_task *task
>> +	),
>> +	TP_ARGS(cb, task),
>> +	TP_STRUCT__entry(
>> +		__field(u32, cl_boot)
>> +		__field(u32, cl_id)
>> +		__field(int, status)
>> +		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
>> +	),
>> +	TP_fast_assign(
>> +		__entry->status = task->tk_status;
>> +		__entry->cl_boot = cb->cb_clp->cl_clientid.cl_boot;
>> +		__entry->cl_id = cb->cb_clp->cl_clientid.cl_id;
>> +		memcpy(__entry->addr, &cb->cb_clp->cl_addr,
>> +			sizeof(struct sockaddr_in6));
>> +	),
>> +	TP_printk("client %08x:%08x addr=%pISpc status=%d",
>> +		__entry->cl_boot, __entry->cl_id,
>> +		__entry->addr, __entry->status
>> +	)
>> +);
> I'd like you to change this to
>
> DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_recall_any_done);
>
>
>> +
>> #endif /* _NFSD_TRACE_H */
>>
>> #undef TRACE_INCLUDE_PATH
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
