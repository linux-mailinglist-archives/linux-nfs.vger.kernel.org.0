Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131163B88BA
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 20:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbhF3Sv6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 14:51:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40030 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233046AbhF3Sv4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Jun 2021 14:51:56 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UIfZWr015544;
        Wed, 30 Jun 2021 18:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=kTcoxbU7XwdtKfQp3G2bpU7jepc4V3hw/2eKWUtWUdM=;
 b=O3uaih8DE3rPWv6b09dwK0b7dsr3vKpdW4TYTzvkvcdlIpo2QjC6N0vvRV6dtV8Nd3hw
 HGpMhHVU/uh8+wtDWdaryMX3XZ58uo6GBT1zobNW6KmmNJx+7somApcwRKDxxrAGd1eQ
 S818BhqxOJYSkb+LrJPGzapnlj/yd2byXSudpEVCKPJ8DoeRTIBj+s9xRmLbC9sSoNjD
 TWCwntgYCdBn4QdR0GaShHZvS5NMB82rKw7Ph0H0OLS8bHM+/H6dQIfhQhl6Gk5zsPpu
 kAoY+SwfUys5b0sNlUwgEV06XJSpA785y4fG72+fARRwpJmgFw8cowEGQB6gxMoeWjcb zQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gha49ra6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 18:49:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15UIdtOx029217;
        Wed, 30 Jun 2021 18:49:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3020.oracle.com with ESMTP id 39dv28jw4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 18:49:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9p46vxv3onzQmscTn9w5VaCwG7ic7y2uHn/s+t78zep9aw5Pt4oxk/QDsNWOhopih0FavRzRktOasZWOnKQ+2IeAvwwaSqJEAD+oz6obR0Th35YkUH6+8thT4MQ5cA/we+IF/9Yv0HF0mGnCbHCTa2g0oDTwi0jMTB1zx1hWhCnVJWliBQlxASINQ+RaJN3PBiT27tFmyk0eyVRiZ6TEMgUPajogmoR8KCLE90gx+eobVSeoychxI7p3SLxjK+eett27l9+ChKtmwqlh1GNnnyeqCIZSWv+KIV1ACfbnJ7R88vXIePaxzHZOhF/AkOsfmTjXwsPyk7OAx68Mb7xvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTcoxbU7XwdtKfQp3G2bpU7jepc4V3hw/2eKWUtWUdM=;
 b=l0wrYpNjSmfzmoMPfyOtUHA1MpApWScSpRX1zvnKd3e5w5tE3r+kHBwfsLLzHt6OPzENxTUXkLziW7Hq8nMIJRn6j/6ObsG9EqEHZcQsoNpWuNUUXkSL9B7XLlX/VM1v+mw42JbPfA4CzYGl/VQwQMrxldxEmf4rhuP65Bwx9R6rL4nf8phWCmY7HzPO8jxt0P9XakLvdXPF/wBF32YWNrmZvPUNyzMssa6BmWDnhSzyEqRS+3wc+OeiQa84CPanaymtztPB4TIGKGbbs4bJxpmpP6vcosBE3uCGEdFKMdjtEjr7pJhdDGKbyCGmyi8DHC0ljLbF1BtCZaXWaGQEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTcoxbU7XwdtKfQp3G2bpU7jepc4V3hw/2eKWUtWUdM=;
 b=RaFfjFE+bwVJA12xi1oq4gar9LWVZz4xe7dSdl0rI4uM8ouOSS+db1xiJr5WXyt7sMtQ8+vHl5gFzg3e3kvQdHnAhJKevNtKYXyjdwNoM14p8ZhmkFGG7EFlFW6M6q1w6/SURQjufdYGy7Q+FVQ1Lmdg7L3PuqYktgYgaD2e81w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB3828.namprd10.prod.outlook.com (2603:10b6:a03:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 18:49:19 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be%5]) with mapi id 15.20.4264.027; Wed, 30 Jun 2021
 18:49:19 +0000
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
References: <20210603181438.109851-1-dai.ngo@oracle.com>
 <20210628202331.GC6776@fieldses.org>
 <dc71d572-d108-bcfc-e264-d96ef0de1b36@oracle.com>
 <9628be9d-2bfd-d036-2308-847cb4f1a14d@oracle.com>
 <20210630180527.GE20229@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <08caefcd-5271-8d44-326d-395399ff465c@oracle.com>
Date:   Wed, 30 Jun 2021 11:49:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <20210630180527.GE20229@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: BY3PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:217::20) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-232-63.vpn.oracle.com (72.219.112.78) by BY3PR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:217::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 18:49:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb034f12-80ad-43d2-b846-08d93bf7c48a
X-MS-TrafficTypeDiagnostic: BY5PR10MB3828:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB3828C5E36A9B4402F99BF82A87019@BY5PR10MB3828.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ex4bPw1E2AD3qT+rKd+IIS7Tn9toDezqin7QDIEJRCpEvvAoxDDZPe0WyXPCHfTAfFdKaZnMemD1+/iaujYolIQMJ4mBBok7mWzORSMrCQ6AN8ibS6amf92WCGno80FPTPUmzzdQ8UVTWjkzxen+Wg/ewEPBc5JnzmtYJI+ithnN27oAw90rSMfnlzq+l9GmpdB5xF+yGzeufJTWytrzG41RyS46BlKZkJFDaXTZ4UdF52gYWLmvznYYWmhky/zp7KZMscLWUqx9Ep5stWVJi2OVoLHytJi1DfHNuymBeOFxwCdph24YBUqxMkiJgLChSFkJ/VEdgUTIGaMvALnVsDqSFQ4rvOchF0WhGgI62S5mJvydsWY0TpzOOJxYxp+nIz4mMQm1sKxw+yeBLjekoLKLmKdJ6V+zrDEIt9EFQqvUp3LyO//8hT0XeCM8pnDgBJpI2RtlOG+kCCMMCLS4tH1Na91PSQuR9vp++XI3sMnEzQ7ogrI4uPIhZvizkapGdF+XjIKmbhvFQ6nw4ibogw40EZJ4d1eGOzuYb+G0ub2sq9KmXI+0jILcZJ7+qedFmfJL0KfkIFMTmOL3MuA/L4iYOpP2xaDF9tS8xSDVvq2eP+cDxl0kNqcX1BHG6rjRAkS9wWO2fZApszu0sNRgxxGxnRuGPHDLANjWF0/zHxgN64Hbtspfm9qngCI7xFVUaUCAjsm8FOoqaWQ6VpHpyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(136003)(366004)(376002)(4326008)(8676002)(316002)(36756003)(8936002)(2906002)(66946007)(26005)(6916009)(66556008)(186003)(38100700002)(16526019)(66476007)(53546011)(86362001)(83380400001)(478600001)(2616005)(6486002)(5660300002)(956004)(7696005)(31696002)(9686003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3FkcG1SL2VEaEYrV2lGUkZLSytxYW9ZaVlLdUsvZ2VnUnZMZWdCOXoxaXNs?=
 =?utf-8?B?Y1gyNVpWTkwzR2V5U1NPOGV6L2Fha1J3SFQyR3U3cWw4RHlGZ2NSNHRHcE9C?=
 =?utf-8?B?c3ZoRzJqMTlPdjZlQ0pjbkpsdXd4TmhsRC84ZVBaR0VuckZvUytWbUlQOFZr?=
 =?utf-8?B?Y3hTK2g2ZkJ1d3ZabXJYMkZBYXdVc1Z1Z1ZGU05EbGVTRnRJcC9kUkRybUd1?=
 =?utf-8?B?dldzYThXUDR3aVkzNHh2UWphQklScWh0UVA4ZUdaOHMvdU5NVXIwdm8wb0Ex?=
 =?utf-8?B?VEVZdWFFVVR5eUZNSE13WllXRnN2dm5ibEJaNDRCVWhsL0lPSmxsb3JGd05x?=
 =?utf-8?B?S3RCQ2Zoc0huN1VPUUFoK3pscVhzLzhtdmRDcmI4bEZsa2FPMXBQSEtwYVFO?=
 =?utf-8?B?YkpSQmVGNkRxNWxxRkF1TGdmS0xCbGg3MzZ3MVVlVDF2MDZ1eEdySkZOWk1Z?=
 =?utf-8?B?OFZBdENoMVZpUFE2Zm5hNy9OZU1uUFZ5Zjc5ZkNYbVZ3WlA4V2F4RzZNQUQy?=
 =?utf-8?B?aWpaV2poQ3FJVEswNlBuaVFDOUJhT2dweDFoK2VqNmRCamo3VjJ6cFNiWkJ6?=
 =?utf-8?B?RDFDa0Nkc2d4UTYxaGtORTg5Yi8xNWpzaUxBVHdpTll0U0NWdHN0cENFY2R2?=
 =?utf-8?B?ajd2bTBwUTdmMnJnUkVtMGNhb3NhOExxSWlTdjZOcTdxeFZmR1VrUjBhRCtO?=
 =?utf-8?B?ZXEvSUgyb2k5Sk9oSUpqdHlERVZzcmYxVjRLZFd4Sk9YVU02cFk1NWNZODlU?=
 =?utf-8?B?cVN4RFdMV1FHNGhyMzdQcUhJeVBvRnBuVGdUZE43blJMeWhSd1hFMkdaei9h?=
 =?utf-8?B?dTk0MGNOUnhyK1U4RFZ3c1JjbW1zVE5wVEYwNjVGZVR0UzEvRm1jS05QVlRq?=
 =?utf-8?B?WndncHVWa2dRa3ZxNS9wcWdsZEJJTHpjb0hHL3BVU2pzUGI5aThrVjIzODhK?=
 =?utf-8?B?VDZZNDZhTlY0Y1pCc0ptMDJpNFZ5aTM4dFVJb2hjemFCWm5EOGZIUHNpdXE3?=
 =?utf-8?B?dVR6UWw1YUEvWWJERDlmRUNFOVJGdllqUndTK01SSWd3aUs5OUt0RkQyUUdr?=
 =?utf-8?B?QUF0aDFLbW45U0lodVpTRFNYaGdxMnVpRHAydnpjTjRCQXZZeG02ZjE1bVNQ?=
 =?utf-8?B?OFg5MzJhTE5PZUx4cXlDcUtDYmIxY2ZmUklSOEkzRVpLU2dZYUM1WWxXSFdk?=
 =?utf-8?B?Qm0vN3lFK3pRMTdGTmIwaWhSQytkclE1K1FtKzlhOHNsWlJ2UlltUWpMVXp5?=
 =?utf-8?B?Vml0c1Y0ZGF2QThlQkFRWXJJSTUxUmh2b1JSWlZGT0xQeUJTL1lEWmk0MVFN?=
 =?utf-8?B?WXRIZStOa0tnYXQ5U3dUanFNcG9lN24yeDc3c1VrLzA2NWRVc0FqTThoclds?=
 =?utf-8?B?ajdtejV2QW5vWDlmcFRkdkRjNWVCUlNqUk1DcHlpazB5TGRwemFsbHRVUiti?=
 =?utf-8?B?bEI4ZStxVUh6MjIvUHIzN1hDZW0wT3BNUlEyL1Q5d1RNNC9PaEg1TlBVbGts?=
 =?utf-8?B?aWx0OVVyTDc4cXU4ZGZ6a3ozelYxcG1EMEhGMjhJcVlEdEJuMkpCdG4wR0s3?=
 =?utf-8?B?K3JubTlCMjZUSGlVWGlFanU5TVZGdWRLMGNEanJqaGNiVDVCRDN6U2RWS213?=
 =?utf-8?B?U1B1UVhlb210ZTNVNHpQWFN1djFJZUJYNnJOU2lncDdualptYURQQ3FrUmJp?=
 =?utf-8?B?OFcyWWIwRGpNS2s3d2RORytXemFpY3dvR0llaS9Nc2tteVNQVThZeGQ3L0VB?=
 =?utf-8?Q?ZMUUw4kaWNNTzPn0oztFFqsaK7UUyCVJ3MFBGNd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb034f12-80ad-43d2-b846-08d93bf7c48a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 18:49:19.1665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4b6tLxs7hBmuBg/l9ClJRGn2Hr35qlCk3V7C/WgMAJwKIN31JV5CGbAiF0YZMHSEIR7dZHIU/dkNqK6l21JgGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3828
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10031 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106300104
X-Proofpoint-ORIG-GUID: rPhPu2bEvI077wNMwvSdAOwhqjNQea40
X-Proofpoint-GUID: rPhPu2bEvI077wNMwvSdAOwhqjNQea40
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 6/30/21 11:05 AM, J. Bruce Fields wrote:
> On Wed, Jun 30, 2021 at 10:51:27AM -0700, dai.ngo@oracle.com wrote:
>>> On 6/28/21 1:23 PM, J. Bruce Fields wrote:
>>>> where ->fl_expire_lock is a new lock callback with second
>>>> argument "check"
>>>> where:
>>>>
>>>>      check = 1 means: just check whether this lock could be freed
>> Why do we need this, is there a use case for it? can we just always try
>> to expire the lock and return success/fail?
> We can't expire the client while holding the flc_lock.  And once we drop
> that lock we need to restart the loop.  Clearly we can't do that every
> time.
>
> (So, my code was wrong, it should have been:
>
>
> 	if (fl->fl_lops->fl_expire_lock(fl, 1)) {
> 		spin_unlock(&ct->flc_lock);
> 		fl->fl_lops->fl_expire_locks(fl, 0);
> 		goto retry;
> 	}
>
> )

This is what I currently have:

retry:
                 list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
                         if (!posix_locks_conflict(request, fl))
                                 continue;

                         if (fl->fl_lmops && fl->fl_lmops->lm_expire_lock) {
                                 spin_unlock(&ctx->flc_lock);
                                 ret = fl->fl_lmops->lm_expire_lock(fl, 0);
                                 spin_lock(&ctx->flc_lock);
                                 if (ret)
                                         goto retry;
                         }

                         if (conflock)
                                 locks_copy_conflock(conflock, fl);

>
> But the 1 and 0 cases are starting to look pretty different; maybe they
> should be two different callbacks.

why the case of 1 (test only) is needed,  who would use this call?

-Dai

>
> --b.
