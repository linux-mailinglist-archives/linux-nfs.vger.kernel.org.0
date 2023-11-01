Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62237DE576
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Nov 2023 18:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjKARlV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Nov 2023 13:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKARlU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Nov 2023 13:41:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE2011B
        for <linux-nfs@vger.kernel.org>; Wed,  1 Nov 2023 10:41:18 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1HXq7r004325;
        Wed, 1 Nov 2023 17:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=3Xv930Xm8f9FZxGSulAtUKVWsExr10+7W3+UrX1/+co=;
 b=DtTEyeU4WZnlMhhLn005Z9wGCzosT2PFRMYIDDEEPUrc7mAkAEOAFFQNScKIXqCus3kv
 58aSihDe16m0FQsrJyICyjJd/qxyY6tkNCvFO0Y9LblNvK6+OzXAOaa3caQRCFCI+SFY
 5VINAY5RYiqxj4uedgjL7c4GtciDwmsksz0ZnYRHDO3T+fJxwcqzrKtNPruJxPCUT77Z
 B7scchFbLzEAz5Q06F2WgNzR7p+8Zziepdd7cF2VgR2BwKJuVephpproLT0t3wyR0ZA4
 jXMRy99pow97Ralm9Ao1Vhl10b4nBt8RyN1td6BQFlSyUJHG+ArBOzKwQfyoKbTdNLUK Ag== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rqe02vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:41:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1H2QPl001084;
        Wed, 1 Nov 2023 17:41:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr7qg8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:41:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcV4r/H5PvHhTZ9Tvx4epa0v5ST/86Pnh2msUP3KjCIw0+auabhtvJPBnkViQEW3rOF9tvdWyVgW+zJ13losjIJsaXQ318+XfHYi7GkE7NdSipuisi4W/vjoVMLH0ierHfxy0AVrUHKMY6GdOiubjoRjAFy6bblGsNRQCuBBRoDvusa34J4ozYXFMPUT+3XykD8Wv8cM1juVmxApckdY5B25+W0u+sZPUfzLPc3Ei2RsDJMTcSXCdbSu+G5QSse2FY1xrPeWIbfmVLbfvSigNHoNRQoIXPvY8CULa5eaMRwHhVrSmZX3BshTTE74PuaGTqhepVLuv2TIpseaVzs+aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Xv930Xm8f9FZxGSulAtUKVWsExr10+7W3+UrX1/+co=;
 b=FQUjQlYC2s+Nbg9BUXNFhH7vixyrYdjjIXfxsG22RAUmmdkcrvu6BBa1t/EL2NlhM+/Gx+Qq4/cRPd2ulwlyXBYCoHtVFUC1vaHWJeng7NalrqBXQEZOfulXT+LM24Q4oeUCr61WLgUuLuZy4zJoaI6qEzcHuH0m3GhH82+6qD42MBIVo9+7pl5G2Z0Frkgar/olRp7YQvqf6XKKVHTdHuhc+NvXxp/DEpyF5WTHWI0a4NkwbJaA/fMhD+LLzaYjaIBSyckCIF5ZBbsZ3A1LsN00WGYQUu17UbP8ygGkdzmZY0UWFuGfORZXYlttH/Poq5yj1YgIKM0Q4VP2Ove7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Xv930Xm8f9FZxGSulAtUKVWsExr10+7W3+UrX1/+co=;
 b=LkYwlu9xlQruHy0Lc5aY3vtU98FAp7f3RjvF22mPZb+NlILcl9Xhrq1F3Wm0fCf/ksbhj7fDl8F1wOmh6/pSFfB34osxR+9Wb4yaKNXmXaZbMVjzyLAHnFO6jTBOdN9UJEotFDcWxHINHZf9RrijXhIlB8VOa9PBga9EO5pOsKs=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MW4PR10MB6488.namprd10.prod.outlook.com (2603:10b6:303:219::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 1 Nov
 2023 17:41:05 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::195d:7231:581b:2c92]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::195d:7231:581b:2c92%6]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 17:41:05 +0000
Message-ID: <c08c56d0-cc5b-49c0-815c-da49e04ba22a@oracle.com>
Date:   Wed, 1 Nov 2023 10:41:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] nfsd: allow delegation state ids to be revoked and
 then freed
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Tom Talpey <tom@talpey.com>
References: <20231101010049.27315-1-neilb@suse.de>
 <20231101010049.27315-7-neilb@suse.de>
 <4C3DBAFF-4C83-4DB4-A6C6-D9C4387BF1F4@oracle.com>
 <169880769331.24305.7672914147957308642@noble.neil.brown.name>
 <D2B988F4-D8F5-4A5A-BC97-F67D19A76C78@oracle.com>
 <169882459188.24305.13216722681220510683@noble.neil.brown.name>
 <E4C94AEE-6CBA-44C4-AA45-C56E8458286E@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <E4C94AEE-6CBA-44C4-AA45-C56E8458286E@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::8) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|MW4PR10MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: e86be239-2d64-4ab6-001f-08dbdb01b925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u+sUVRGEyIagSOOzPRDls6HSGxGBaXJg1KiKpmsGuJ3va/Ar5eKcU2Vmqfg+NDR+qgheRrw6dHqEg9ZPPpYNTCGFG2pjqvQ0uss9RGrplNz/Rl1nXrtg/Cg92MHpaKE2q/ey/4yeXsS/qj0Eoi5T9Gbg8JEB+cxOeTaozjTvKH+d1YVpCLb9Is6xdt1Z9S7rJzuznl12zea6khkGgdXI1Qw23bPyK56mDbC36p9vEX3l5MtUErRxkD7gIBYPn7sr3l1Fl7imlzMN36AF+x0afWOj6f+UrXEs25FPdfYpAGFVsE71pbtEykgCw48OTn7z1qEEPT6nNGPbNr07JziZ6IOEGVJcwaUJYPnu2cJE/vnyOsUn9n0PXtQXGHiQlOuR4zPq/Rf8boZPSydxjPuyxQrCW6oFPQ0tOkhz7v3IPve/GuORjmfrEo7E/4Oas09RR0bFW+2sjL+2oJDFfOvnbh7g5UBgnhapf3ZoyLuO6EWuwwrWPfbj9wZSaOy0ThpKQfRZ7BQb0c4cNFeX2oBznFFmYo/ItagCJ1ZohD2fXYC7K4RNDqAULh4f67a/66ZoSVgEsZ9xOj3k/RDLCAX6WJey6OXgR25LWmTXsciFtSbPVYORp8hMCUanHC55eZiv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(41300700001)(31696002)(2906002)(54906003)(316002)(6506007)(66556008)(66476007)(2616005)(110136005)(6486002)(66946007)(9686003)(83380400001)(478600001)(8936002)(38100700002)(86362001)(5660300002)(8676002)(53546011)(36756003)(4326008)(26005)(31686004)(6512007)(66899024)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S21KMFZ0NENDeXB6Q0QzbkUxQXlqNjZBWTdGVkNlLy9kR0Uwb3M0R0dWa1B1?=
 =?utf-8?B?SzNWL2YrTnZVNWxZSDJGdzYvRXZxMTB3dDY5RnhvOHN0VHRZU2lLTHVnbzkr?=
 =?utf-8?B?RUJWejVmeFBoRmQzWjFiblcwcUJlU0pKM2dWWDg4MzJsT0Q2YjYzdldKM3Ux?=
 =?utf-8?B?N3RwTHhWZHpIZEJpQ2s2L0pPZGRxK1VNTWhNM084Y0Jjc3RVTUhBZ2ZnZldQ?=
 =?utf-8?B?Z3c3SjRZNCt1VUxNZDFtUk4wcDV4Y0FnMEdmLy9BVDZDTGxkTk1yUU9laE9P?=
 =?utf-8?B?a2s1eXZYcmkxRENGSFpvdG40NUtFWXE0eWJzOFlEblVhRjVEaUZsRlJUbDFq?=
 =?utf-8?B?eGxlYzFaQnpOak9RNGd6VHJwZ2sxcTQ3OHhxWks2MUZjUnNUUGczYnFjUWo2?=
 =?utf-8?B?NDRBUXU1Tk4wQnFtUlRiTnJVVjg1WlZ6dEw2eHRlTG1xK1JJdDFud2Nkbkk2?=
 =?utf-8?B?b1NYcSt3ZW5IL3lDTEVsRWRkekFzamkzREl5U28zUGp6M0F4SkdPQmxvTzRp?=
 =?utf-8?B?elhoUXZuNFp1QVhTWTkrcDRjTzYzN2o5Ykg3QVllRmlJKzA4WHZPd1Y0d3k1?=
 =?utf-8?B?TFBldElPKzlLSWNKblNBa3pZUThQaEd5b1RORXVzS1FabkdPUGEwZDBQbXNU?=
 =?utf-8?B?cmpIUitHSUtKRDN4VlRtSHFKNW9QekpFb24yMzhLVDhlb3hNZVR6UXlnOFFs?=
 =?utf-8?B?R05SRHNpMnpRMGhGWUhBK3VKZSs3TXZNWElvdDVRdURuSm1SZEVrQUlxbnN3?=
 =?utf-8?B?ZlFhR3RLSkNyL3hKV0hVcWpIN0ZZUjNWc2phSVNHajNtOFhjZ0xEYXNYa2d4?=
 =?utf-8?B?dnZ0T1pJSXM0UmoxQWp1SXE1UnVZVjZEK1d3SFFzY3VLRDFrV2dXb0ZveVkw?=
 =?utf-8?B?WGQ1Zy9neDNlclB6RTFRKytnS0ViQVJWSE40N25IWEVadjRmYkszYjNiK1VP?=
 =?utf-8?B?YXVNczBncWNtQTFwVnAwR1RFNkJrWi9RVkVJcE5DZ1djYjMxcEFtaStuUzJs?=
 =?utf-8?B?T0VTQXVnK0JsUlVpU2p1QUZreHRkMUp1VGNPQWRZN1JsYm9RNUd1c256Q3lt?=
 =?utf-8?B?MGdWNlhNQmwzVjJWN3kvVTMwT2NPQVZhTGlzaDVXRG9lem5lWU5JT0RTSTk5?=
 =?utf-8?B?ekFrTkppd2Y1THZFdDdVNVlQMWFZQXBIalg4eHdBdnU5bVJ1UGRTWGg4bUxa?=
 =?utf-8?B?ZjBsMkt6YzRCY1l5V1ZwOGZsZDZnQmFUOW5kR1pHMDJnOU5vNFpUVHhIK3hu?=
 =?utf-8?B?T2RYREZ2UzZ6bzNXYS9ObHA3Q2dZVklxSmRUWmtDSFVublY0RjF6TFpFS3J5?=
 =?utf-8?B?YW9vam1zdVozUWUrYlduNzJGWDdDVkdZTk91N1pSNlpoRm1sZ1FmbFZhbVJh?=
 =?utf-8?B?dkhReUpGeU9ITXJIQ2ZHNDJzVjFpMzAwNWorRDljbmVSc2U2bVE5cUdTV0FP?=
 =?utf-8?B?Nzk4MlhxTzdqY01PTElYcHcyT1YxL0lxazF4OGlFZXZxNGpPMzRuTzI5YS9s?=
 =?utf-8?B?SDFmbTVQQ0JOWW5HakdkQkRaZWM5cjNOL0Uvc0dyRk5LUW1vZ29RVmwwK04v?=
 =?utf-8?B?MVR5MmlnZFMvcXU3czYvOFBGcng0WUJhVVpnRmYwUzRzemRxMVZOb3VPK1hh?=
 =?utf-8?B?ejg5bjkrbkYvYmdaTFpWKzRYc3hwSlYvbVFNZ1FDQ1lVNnFBWmRGVUhHYmVF?=
 =?utf-8?B?ckNCUkd3NElZbERPNTBuVXhLeDByMWpKdnNhMnAwaTl6b05lQit1RFlMSi82?=
 =?utf-8?B?YVRMdGhrVmhPdTVQQ1lrQ2ZoK2lDR0Y5UDcrd2tNZHllU0prSmFHY1k5RElV?=
 =?utf-8?B?eHFUakc4TXpXOUgyOFpiUUxSSzVFeGJxYk9aZE93YlNCWnVIYURBVm9OeEdt?=
 =?utf-8?B?UXNjSGw2eXlYc2ZoVldNQk1oZE5NTlZjcHFycmdheW85d3RaVG9PVkx0TTE4?=
 =?utf-8?B?RFk5cWpxcU44SFg0aE56d3RUcC9MYXBFVWxYblBGVXF3eVRNS1FXWTlucmg1?=
 =?utf-8?B?ZzdQVDlkTEUrZ3hMTHE2bkVZZG5SbzNzbWVYZ2lkMUJBQmlzQ1Q5dHpXRllt?=
 =?utf-8?B?M2pTa0Zra0lObHF5WE5EL1pKT3dMdklpL3JmcDhVYWpDeXdUTllaSHN6TklG?=
 =?utf-8?Q?9dUkQYAszFvrtPymCIY6lQiBC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Yy46+KGDVsPmVOoKxHhyAmugwQ+nKo3y2WA8LUyVP/KzcgplqlKJ+9ZIVmMIs+VzKzHkvCk67tByhflb4uoLWla3twsA3tLbpXvApnW4Yos7gdzTj93J3R0UZs7fvQnKQAQ27nuiH0+klyUBcDdgiNi7xVPWr+DAUvp6NswzQgc9LhFgICa0y6Uu4uqcAshtFrFSi/GdEBnS9htdYxwVsMrgg2WBda1hs880iXZDt92tWDoM8QRyb1RVFzl3YRNKnvv4/jnCZXEqz3rUdOzSklul3ah5NcmWhyKlREgzZgmNB8YJEhIewuXAKoNsjBQo2H+MT+flSE71+y7t8Sigg9GHTS0+U/5oU3lPk/jQAziDy6xW8j4vKK6Tm1DEafURjNG6wmpaZRJIdHv4FH5tW/mEcJEz7zAgc6VR/XtiHdrHRqDdIFnFjAB/5oaKKq2j4W3q+4HyyQyEuuI5YbdDnE25rfm0GYVnxxkXSEaBcgNV3vwDXQnxH7JYlXh6ldAROrDZsiL5JKbv2C3uIDwiVsEQB9zG75sBDL2XtwWmujC/yE5CQe0zGwtSnzFhBVP5WzLOqp6AKSFkigMLeuLxWpWMP4OKpmI2UKGmDUG3S5ifol90JxqI94Tl3gLXTZvMt58qHpP3VW7ztmwzIdalnrl2BlxNuXprfAJOKJO0vGJuSB9SmDHFhDHxB0eFzBmKG/R3CimK3ciFDfTdf7oiN3+1kFrs8L5wJqM3a/NPYS6FVurFI3tIl0qZseITWNgmk1GNvajNRwSt4Vv2mIPINdsHTPRKD+Blmp2TWMTqVQ9Z/t675lJ6HwaE53ow6ZKdc7KLr1S5G8DcBB93BPZv+ovHSdAlMIGbptNZMIBlyuyzLTfjHjR3slR4Gqv/beOh
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86be239-2d64-4ab6-001f-08dbdb01b925
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 17:41:05.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KSlw8acWUtL0i3hUkfJerFccSDDlPTOlgcMs24w9hktlcZpDiGhIUzMJgucve63hzKHIx+n1JrVDOLS71jXKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6488
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_16,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010135
X-Proofpoint-ORIG-GUID: En-VsktQRiVCxR9U0WO1_GEJ9e0VBZJf
X-Proofpoint-GUID: En-VsktQRiVCxR9U0WO1_GEJ9e0VBZJf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 11/1/23 8:41 AM, Chuck Lever III wrote:
>
>> On Nov 1, 2023, at 12:43 AM, NeilBrown <neilb@suse.de> wrote:
>>
>> On Wed, 01 Nov 2023, Chuck Lever III wrote:
>>>> On Oct 31, 2023, at 8:01 PM, NeilBrown <neilb@suse.de> wrote:
>>>>
>>>> On Wed, 01 Nov 2023, Chuck Lever III wrote:
>>>>> Howdy Neil-
>>>>>
>>>>>> On Oct 31, 2023, at 5:57 PM, NeilBrown <neilb@suse.de> wrote:
>>>>>>
>>>>>> Revoking state through 'unlock_filesystem' now revokes any delegation
>>>>>> states found.  When the stateids are then freed by the client, the
>>>>>> revoked stateids will be cleaned up correctly.
>>>>> Here's my derpy question of the day.
>>>>>
>>>>> "When the stateids are then freed by the client" seems to be
>>>>> a repeating trope, and it concerns me a bit (probably because
>>>>> I haven't yet learned how this mechanism /currently/ works)...
>>>>>
>>>>> In the case when the client has actually vanished (eg, was
>>>>> destroyed by an orchestrator), it's not going to be around
>>>>> to actively free revoked state. Doesn't that situation result
>>>>> in pinned state on the server? I would expect that's a primary
>>>>> use case for "unlock_filesystem."
>>>> If a client is de-orchestrated then it will stop renewing its lease, and
>>>> regular cleanup of expired state will kick in after one lease period.
>>> Thanks for educating me.
>>>
>>> Such state actually stays around for much longer now as
>>> expired but renewable state. Does unlock_filesystem need
>>> to purge courtesy state too, to make the target filesystem
>>> unexportable and unmountable?
>> I don't think there is any special case there that we need to deal with.
>> I haven't explored in detail but I think "courtesy" state is managed at
>> the client level.  Some clients still have valid leases, others are
>> being maintained only as a courtesy.  At the individual state level
>> there is no difference.  The "unlock_filesystem" code examines all
>> states for all client and selects those for the target filesystem and
>> revokes those.
> Dai can correct me if I've misremembered, but NFSD's courteous
> server does not currently implement partial loss of state. If
> any of a client's state is lost while it is disconnected, the
> server discards its entire lease.
>
> Thus if an admin unlocks a filesystem that a disconnected client
> has some open files on, that client's entire lease should be
> purged.

Ben is correct, courtesy state is managed at the client level. The
server does not deal with individual state of the courtesy client.
The courtesy clients and their states are allowed to be around until
the memory shrinker kicks in and the worker starts reaping clients in
NFSD4_COURTESY state.

-Dai

>
>
>>>> So for NFSv4 we don't need to worry about disappearing clients.
>>>> For NFSv3 (or more specifically for NLM) we did and locks could hang
>>>> around indefinitely if the client died.
>>>> For that reason we have /proc/fs/nfsd/unlock_ip which discards all NFSv3
>>>> lock state for a given client.  Extending that to NFSv4 is not needed
>>>> because of leases, and not meaningful because of trunking - a client
>>>> might have several IP's.
>>>>
>>>> unlock_filesystem is for when the client is still active and we want to
>>>> let it (them) continue accessing some filesystems, but not all.
>>>>
>>>> NeilBrown
>>>>
>>>>
>>>>> Maybe I've misunderstood something fundamental.
>>>>>
>>>>>
>>>>> --
>>>>> Chuck Lever
>>>
>>> --
>>> Chuck Lever
>
> --
> Chuck Lever
>
>
