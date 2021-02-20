Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1948D32026E
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Feb 2021 02:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhBTBQN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 20:16:13 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48220 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhBTBQM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 20:16:12 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K1F49E019133;
        Sat, 20 Feb 2021 01:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=NC6qwmvcIqE+/0FGGdYZEK7gv2riiV336OnFV61lA/w=;
 b=XI7v6vf7VULg81AkI9L+qKU0DsDk9QzR5V27ZG8RMQ/3uWSCj42vINbIDg1+4+GfG9qo
 VcXKEP9RlzTk1zDiUAAeRUTeswgUEK803SdXCiIPOxDFQB0941aE3c6lKOokCrWfE6Ey
 cMlb2bKVCacasO3kvzjr7QeS3K/n/cWoXstMN1G8DBnjKJgDP7R1RfHQtNl3ePRJt25m
 Ow1VV6R4apiSm8bOX3hWGTgK4NFNx3JMyu29izHfDY9pCAJdtER8+I99EsCHbUWcYkOO
 AGx8vm0KbatrkqRyeapprGwGl+kYuTr1+5JHqEmPQv6rKo9JXOQnh9DVlEEi5ELtOSf3 9Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 36p66rb6c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Feb 2021 01:15:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K1AVIs170671;
        Sat, 20 Feb 2021 01:15:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3030.oracle.com with ESMTP id 36trf985pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Feb 2021 01:15:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfHtc1/lHR0Bd7xpqAxPDmsAVu6ABkngy4I1ND77NSBCBROWhqNYVrhAilSYE3cR35X22Y342dQDpfdu5zUI0t0Ru69l6Yqc3JiG1Oqvpv5zWXMY7tUCAeU7L8pMi4+F9ZBzZewVcoPRMgL1sFwmW/dDLfDaBuTi0rWQiaI2Fqc78NIXq9sN6WfRjeOrDl5xpwW6G3V3/Q2JZlXK6FDWqWF6RdNfKx0SaBrf+OGe9ojtctQBVGLLRgnkgu32aShObElbP/Sa0QPuEsW0QG+Y3gEYAjZBZs73mSVBBjwsbht60CXIBpt5/fxxXM1T8QiFym7OTRZRGzfAWHvwTR2+uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NC6qwmvcIqE+/0FGGdYZEK7gv2riiV336OnFV61lA/w=;
 b=e3/AdX6g9oFSgQdfQnU2RUum/Vrn9JBo7dohyMN9XIyC7YfqXBf6FNx60ILSToiuu/VCYHD2GyEZnxAYGbL80Ax0TX5/eJ7lrv6/sTemBFEKzsP58Outgpc0001W0xbI+YgStItDxpeEC6/1SAGXkQxQfrJXyetONenYdT8Kkk7N/Krcs0ifcCoE3PF0KVijNns85KZdrlVNsKI7HQbZqIQKJAtR5QvDljB3abBqW9FtPVQnhXnaUAmxrD4Xr0h+Bgt98FcUSHP+1g9clgHMMOIEQR2C/1o53kX1YZ1MzB47rreHQWX1+ff+Qu4pOcpe/EG5Fjte6hML+3UE+J2k0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NC6qwmvcIqE+/0FGGdYZEK7gv2riiV336OnFV61lA/w=;
 b=N2vHodXYuPCiGg2e/lgUietL7bpTNCjqIEEkomdx3tevfygHXhuTL8TWHBlEHhLmLRmrolW1kOk1+t6/Ien9xIYtcUQ0eCiv9uG0UWcOxmfm8c08xiWoQ1bg3NY7R/nqAwxVRVR3xoOVOrSHbVEMyw0JH+j8Q9w3uHWGaPgPwGs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BN7PR10MB2434.namprd10.prod.outlook.com (2603:10b6:406:c8::25)
 by BN0PR10MB4856.namprd10.prod.outlook.com (2603:10b6:408:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Sat, 20 Feb
 2021 01:15:22 +0000
Received: from BN7PR10MB2434.namprd10.prod.outlook.com
 ([fe80::20d8:7ca1:a6d5:be6b]) by BN7PR10MB2434.namprd10.prod.outlook.com
 ([fe80::20d8:7ca1:a6d5:be6b%3]) with mapi id 15.20.3846.041; Sat, 20 Feb 2021
 01:15:22 +0000
Subject: Re: [PATCH 1/2] NFSD: Fix use-after-free warning when doing
 inter-server copy
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
References: <20201029190716.70481-1-dai.ngo@oracle.com>
 <20201029190716.70481-2-dai.ngo@oracle.com>
 <CAN-5tyFnTSuMivnBPD9Aur+KDxX8fCOuSaF7qGKe6bFB7roK6Q@mail.gmail.com>
 <20210220010903.GE5357@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <275bec0d-a304-1c8a-45b2-0a1139b1cdd7@oracle.com>
Date:   Fri, 19 Feb 2021 17:15:19 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210220010903.GE5357@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SA9PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:806:a7::18) To BN7PR10MB2434.namprd10.prod.outlook.com
 (2603:10b6:406:c8::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-163-7.vpn.oracle.com (72.219.112.78) by SA9PR10CA0013.namprd10.prod.outlook.com (2603:10b6:806:a7::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Sat, 20 Feb 2021 01:15:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c373a75-8100-4547-aed2-08d8d53cfe99
X-MS-TrafficTypeDiagnostic: BN0PR10MB4856:
X-Microsoft-Antispam-PRVS: <BN0PR10MB4856776223A9D9884AE45A7087839@BN0PR10MB4856.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7WmVyjQqKQ0zJ3B+XtLravk2iRI0B1ugoIOWPinFqn9bsTFCMBA7IN6cikMZk1+wzBK8YBps6cNdlOUO2IJs8BEiv96Ie1c1W9/5+h0Al1kGBkoNOkgTYWsECJQSooU7IJJeQba98Rpfx6MY+m4hQaJeD/I8NpqOOC6zf64Jvvr4fNw+0WEuEt2232rjWipESAltTl1SipOC8/z8G4E/rBC4m/M0xxX4lH6CuZHkqnJuLxH7NOceQvtJSZaCnzpHPhhOeKYzUowa3A11lS2tHdc4JnbV4HYHJGjXkxjU5q4x9XQDzqg0Zp+dNwy+4SAWPili1Vi+Ck2owLo7uJAvEbutGhnC/k6A/ydtBbOJs+HfCO7xB6GysCsg4LFBlMAjYoilNQaH9xMzQGpL+lzgAD3X2nE283yp2KQdmJ5MZbGTrflFLXXoIbp7kB8vJWywdqlJ8scI/t2P7pWCRk99vpX8aphEUDycQjSUEmz/1OSEMK3p3bxEXxzAZBQyhTQmQMolxVZ5hwDWfp1A6FPViuK10vzcpkRysNDon6lX7kKNY5fJNzd/KDdu1PRGvsLAg3h860dKrBdpzOLh+gUX8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR10MB2434.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(346002)(376002)(39860400002)(4326008)(83380400001)(9686003)(316002)(5660300002)(2906002)(31686004)(6486002)(478600001)(45080400002)(8936002)(7696005)(66946007)(66556008)(66476007)(36756003)(31696002)(2616005)(956004)(186003)(110136005)(86362001)(16526019)(53546011)(26005)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z09IOWwzQVhybFp2Q2ZDRndncHZhOWtGR2VVY2cyL2xhRWUzaE80dytwdVBM?=
 =?utf-8?B?Wm5zR0Y4eE13WDNqRXpZMVNGVWJqeEtMa3NaSHVEZHZVdzh2Tm10MWUraXdS?=
 =?utf-8?B?dzhBV0haV3NTSVBldWJqdjYrcG1wN0JHY0lZalk4S0JPZS8xaHNOQ3ppQVpQ?=
 =?utf-8?B?bDkycmhVcnFkR1FlSk1IdmprcXdPK0tJZ3dWVDBid0R5M1pDSEhJSmpURzc5?=
 =?utf-8?B?YVFhcnVOcytHK2krSzhGc1ZQNWhXMHY4alZ5dmNmTUU3d1I0VVlLdXA4bmFR?=
 =?utf-8?B?VDBNekJuZEFyZUZnZHdCVTVXbmtzZDlJRy9EWjV2VG9TZnNOYU54ZERTZkht?=
 =?utf-8?B?eGI5b1duekIvSExPQXdsNFlpWm1wRG9IdTc2OHQrUm9Cbi9MSXZUNkFUc2cr?=
 =?utf-8?B?M29ZU245L3NxUGphT1JtV0txbXI1Nmo0L3QwbGFYcm1ibWdkamxUWmNGYkg3?=
 =?utf-8?B?SjBjU1l4WFVSejFPSFdtMi9QSU1TeFBjNDBhNUJ1Mjk5aXEyTEJjMk1FTllO?=
 =?utf-8?B?OWh5TVVRWGFsOTlwd0pKb1pIQ0dGTlVKTno1TDk5d2VaeThRRy9TWUtOcjhK?=
 =?utf-8?B?elhRaG02NE5UZ2JlYzRUTEdRd0JOUnZuQlpoOFAwVWIrRDFXMlB1TDJHSXFZ?=
 =?utf-8?B?R1p1VG1QaXVLaEZKcWQxL0Q4SGZVaWxYZmRzUGxxclIrZzNwK1ZQWU1zVjJZ?=
 =?utf-8?B?NlRjQzArN2VSM2d3ZDBsUkhrcEhTb3BJaEd2SzN1N0hoQnpRSmQvaTl1TXNp?=
 =?utf-8?B?ck9WY1JIcE5aS09qcUVKYVVTSEptV1RnMUtJNUw3SVVXTkNLdHBoNlhlZ21k?=
 =?utf-8?B?S3gvV3luNmpGRnZzbno3S3hNMG1wRE5UejEwODNWak94M2JCYzF2YmN0bHF6?=
 =?utf-8?B?S3FnZ0RCUk9UZjNKYkF0ZWdxbU90YW56cnNBV0JwVnFydTBxaWdzb1hnT2FD?=
 =?utf-8?B?YjZtbStzandzM2FmY0JiYTJlZEJZeURJbHRWblFGVGJhUzlJdXdFd28wdWZY?=
 =?utf-8?B?MnF3WFNmUCtmY2YxR2YyYWg4c25WdklBMHl5Ui9rN3hldjFUZitoSkpLMjVM?=
 =?utf-8?B?TEpPSlFvcmVFUFdXcFdwdHNBU0Y2T0Q3cGVQNWR3NlZjVXJuQUQ0ZjJlWnE2?=
 =?utf-8?B?c08wQ3FpWjQ3M3FtejdaNThiQm5STjZ3SzZqakVpVTZmSmgzQ1pDdy9zVXpj?=
 =?utf-8?B?aEVMaHFWUWJSeWtQbHNhYmpXM0tvTlYySXVqQmpQMEJlVFFnWnJZZitPc1dW?=
 =?utf-8?B?YTU1bFlWWWtXOTRzVGdxQWxsbTErM0cxY2N0Sy9pTUQ2TFlUbFR3RTBVdE10?=
 =?utf-8?B?WkdLeXZNRFgvUW5Id1YxWU5RdDhNbk5lTEJzTytOa1BkV09VWVBRQmpKbE83?=
 =?utf-8?B?YTZ5Vk1TVzRMVzVTdnBUR0h4UFpuMklvd2hNMzZ3cmMzaXdtMEFPcllCU09r?=
 =?utf-8?B?czVseHF5a3lmTm5pbUVybHpSZ21seUlyZWFNUFN1QVo4eGZPUVhRTGZ3VzBj?=
 =?utf-8?B?WENRTy9Ec3dMdWVGM3FvTHhtOWVBQUtaUFBQdjJkUUV2aFJtVWZzYW1Xc0ha?=
 =?utf-8?B?YWFmUUk5T1lzYlJKQzVCVXF1YncyYU81akU3cWY5NFdySDFmbi84UFU3Q0gw?=
 =?utf-8?B?ZmJvYm0zNnpaTll1dXVFS0oyUnZjZE53SkpoOW95bTR4OFVIN3NGNDhja2Jr?=
 =?utf-8?B?QVZKMytaVUo5WmhjaEd6UFVmcTB6aFdMaEpsOHdKcGZHNnN0SlpDSmZxMnpN?=
 =?utf-8?Q?Hd1Xf/7+BbVSK3BvcjmRQBmOODCRWzgfBfKQDvz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c373a75-8100-4547-aed2-08d8d53cfe99
X-MS-Exchange-CrossTenant-AuthSource: BN7PR10MB2434.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2021 01:15:22.0113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/K0Y5HTChBKG3evjfS0lVQ5ELIZnzmCqkjR0sXxni3KLPOiozRDkstMysAohPkF+1Tg1GKbsEaiDAI5RxnkFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4856
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102200005
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102200006
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Here is the original warning messages:

Oct  1 23:49:42 nfsvmf24 kernel: ------------[ cut here ]------------
Oct  1 23:49:42 nfsvmf24 kernel: refcount_t: underflow; use-after-free.
Oct  1 23:49:42 nfsvmf24 kernel: WARNING: CPU: 0 PID: 5791 at 
lib/refcount.c:28 refcount_warn_saturate+0xae/0xf0
Oct  1 23:49:42 nfsvmf24 kernel: Modules linked in: cts rpcsec_gss_krb5 
xt_REDIRECT xt_nat ip6table_nat ip6_tables iptable_nat nf_nat 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill btrfs blake2b_generic 
xor zstd_compress raid6_pq sb_edac intel_powerclamp crct10dif_pclmul 
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd pcspkr 
glue_helper i2c_piix4 video sg ip_tables xfs libcrc32c sd_mod t10_pi 
ahci libahci libata e1000 crc32c_intel serio_raw dm_mirror 
dm_region_hash dm_log dm_mod
Oct  1 23:49:42 nfsvmf24 kernel: CPU: 0 PID: 5791 Comm: copy thread Not 
tainted 5.9.0-rc5+ #4
Oct  1 23:49:42 nfsvmf24 kernel: Hardware name: innotek GmbH 
VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
Oct  1 23:49:42 nfsvmf24 kernel: RIP: 0010:refcount_warn_saturate+0xae/0xf0
Oct  1 23:49:42 nfsvmf24 kernel: Code: c9 82 31 01 01 e8 17 b9 b6 ff 0f 
0b 5d c3 80 3d b6 82 31 01 00 75 91 48 c7 c7 d0 d4 3a ac c6 05 a6 82 31 
01 01 e8 f7 b8 b6 ff <0f> 0b 5d c3 80 3d 94 82 31 01 00 0f 85 6d ff ff 
ff 48 c7 c7 28 d5
Oct  1 23:49:42 nfsvmf24 kernel: RSP: 0018:ffff9f71c0527e68 EFLAGS: 00010286
Oct  1 23:49:42 nfsvmf24 kernel: RAX: 0000000000000000 RBX: 
0000000000000010 RCX: 0000000000000027
Oct  1 23:49:42 nfsvmf24 kernel: RDX: 0000000000000027 RSI: 
0000000000000086 RDI: ffff88ed57c18c48
Oct  1 23:49:42 nfsvmf24 kernel: RBP: ffff9f71c0527e68 R08: 
ffff88ed57c18c40 R09: 0000000000000004
Oct  1 23:49:42 nfsvmf24 kernel: R10: 0000000000000000 R11: 
0000000000000001 R12: ffff88ed54cedcc0
Oct  1 23:49:42 nfsvmf24 kernel: R13: 0000000000000000 R14: 
ffff88ed4a4a7000 R15: ffff88ed4e93f3e0
Oct  1 23:49:42 nfsvmf24 kernel: FS:  0000000000000000(0000) 
GS:ffff88ed57c00000(0000) knlGS:0000000000000000
Oct  1 23:49:42 nfsvmf24 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Oct  1 23:49:42 nfsvmf24 kernel: CR2: 0000000000c84018 CR3: 
0000000216194000 CR4: 00000000000406f0
Oct  1 23:49:42 nfsvmf24 kernel: Call Trace:
Oct  1 23:49:42 nfsvmf24 kernel: nfsd_file_put_noref+0x8f/0xa0
Oct  1 23:49:42 nfsvmf24 kernel: nfsd_file_put+0x3e/0x90
Oct  1 23:49:42 nfsvmf24 kernel: nfsd4_do_copy+0xf0/0x150
Oct  1 23:49:42 nfsvmf24 kernel: nfsd4_do_async_copy+0x84/0x200
Oct  1 23:49:42 nfsvmf24 kernel: kthread+0x114/0x150
Oct  1 23:49:42 nfsvmf24 kernel: ? nfsd4_copy+0x4e0/0x4e0
Oct  1 23:49:42 nfsvmf24 kernel: ? kthread_park+0x90/0x90
Oct  1 23:49:42 nfsvmf24 kernel: ret_from_fork+0x22/0x30

-Dai

On 2/19/21 5:09 PM, J. Bruce Fields wrote:
> Dai, do you have a copy of the original use-after-free warning?
>
> --b.
>
> On Fri, Feb 19, 2021 at 07:18:53PM -0500, Olga Kornievskaia wrote:
>> Hi Dai (Bruce),
>>
>> This patch is what broke the mount that's now left behind between the
>> source server and the destination server. We are no longer dropping
>> the necessary reference on the mount to go away. I haven't been paying
>> as much attention as I should have been to the changes. The original
>> code called fput(src) so a simple refcount of the file. Then things
>> got complicated and moved to nfsd_file_put(). So I don't understand
>> complexity. But we need to do some kind of put to decrement the needed
>> reference on the superblock. Bruce any ideas? Can we go back to
>> fput()?
>>
>> On Thu, Oct 29, 2020 at 3:08 PM Dai Ngo <dai.ngo@oracle.com> wrote:
>>> The source file nfsd_file is not constructed the same as other
>>> nfsd_file's via nfsd_file_alloc. nfsd_file_put should not be
>>> called to free the object; nfsd_file_put is not the inverse of
>>> kzalloc, instead kfree is called by nfsd4_do_async_copy when done.
>>>
>>> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>>   fs/nfsd/nfs4proc.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index ad2fa1a8e7ad..9c43cad7e408 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -1299,7 +1299,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
>>>                          struct nfsd_file *dst)
>>>   {
>>>          nfs42_ssc_close(src->nf_file);
>>> -       nfsd_file_put(src);
>>> +       /* 'src' is freed by nfsd4_do_async_copy */
>>>          nfsd_file_put(dst);
>>>          mntput(ss_mnt);
>>>   }
>>> --
>>> 2.20.1.1226.g1595ea5.dirty
>>>
