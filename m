Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745E6747809
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jul 2023 19:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjGDRtE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jul 2023 13:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGDRtD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Jul 2023 13:49:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963BC197
        for <linux-nfs@vger.kernel.org>; Tue,  4 Jul 2023 10:49:01 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 364HDqHL010664;
        Tue, 4 Jul 2023 17:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=lb0tu8EvYJdhvFTemhQ+vqmiAU+ZcBa1AvUVGFG7cDc=;
 b=kEZtKe1ewlWwZ/iazKx+7RJKi9/7Q5xQw8gZRaEQB5DVYsi5drCln5VACmADegD2ApwD
 3vE/jkraIoP73SriEzo/BFfBv2epPHfqgKQVjPoChmnLHUqRFOKsDVF/CcB+x5uSFt0L
 czDbzrKgWfuLG6XNvUTinC+AUrWLNyyN/FENqBI2vfoLjZJiQKCpjDMY2GrsBZlPK9dP
 mn3EZa+ntyRyD+/tU9ZxfhK/HKczJi2sqof/4kgz9PIKb4Ruo/g1w2WzTgAQVF+er4ud
 XBoc1m4EwUwQ/nS9QQ9DitPcqLAHR/XQan37MI6tTz5ZQ5YzveBngJPOIS68lDUZ0L7v rA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjbrtcybb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 17:49:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 364H4WO6039223;
        Tue, 4 Jul 2023 17:48:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak4mgmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 17:48:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBXkPQV91+ZZKkQaelYaCf5BWr01sIbJgIO67XsUAvgB2GMPpMO5PEPHejNi8tJyAhI8WueHN34dHo3+sAW3wyz8+4zvqPWuE47ebyCi/QlljRNF/r37jVMu5O8BI0qHl5ZMNigWbLzR9dixS0nZtLnvxEEsvVYTiG5fBwbwInecSKq4cSZ5CPkp8rtBm0scY/yyH55FmARZv7Sp7AAeXGymINIWJQMHp0NnvRiE9645ZG4RU5AhhKtijyAtVSN40XbAUoXwax8ACR0ql7FKQdmtr14/8LbenPJs9ki5WlQ4zES3jK58f4W7REz9HbDwtsYBORRKHSAJL7Be+JoeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lb0tu8EvYJdhvFTemhQ+vqmiAU+ZcBa1AvUVGFG7cDc=;
 b=MdMGxvgzmCe2QJZhPbi1mxKfh3mkJQSN69hqPKPoxExAeqCQwCVOFrzFAUWRZFoj5NJ57OezuprAvWZCZuot10XMItu1v0LVmEL+55Ov8+3QLJ6/tywUGKYKwrtt+P7O+/Cz22fVngr1ZOXy8mdFjTrSq/0rLM32x6UUWk5IH3UcTNlko3Xulu1os76EkV9Lh8SpQIJuqpj5KDj5BpYshJQgYFstn16YyW1XF7cdgd3Tk7hU54onq5JB+h24Kkh++DA1xa9uVZ+DMphhmyGmEHEu1W6YLo5HMaeOcmVexRgZ+e3Zni+yUgr0B/IjvPUXk8iRyn0iaoNRT0INinwXgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb0tu8EvYJdhvFTemhQ+vqmiAU+ZcBa1AvUVGFG7cDc=;
 b=nTcGSVlw5LfGYq0EIXlKqz25HV7ZcENt9w0Ip+tQF65w1dSwc/nuAYJoNErAwCEIqmIW0kupi5tr45b5hooj5zWKnAJpZVeGKlWgKfWG3AMzhps4lznfBlte7M0ojcXQyYGUtjSNvoD6aV2a69wxunZaBUl47qW7xRPbdbVDb80=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by DS7PR10MB5040.namprd10.prod.outlook.com (2603:10b6:5:3b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 17:48:57 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::1b0f:fad9:3eb1:95e8]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::1b0f:fad9:3eb1:95e8%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 17:48:57 +0000
Message-ID: <284e5b86-1903-4073-fb3e-de60ad5d8f20@oracle.com>
Date:   Tue, 4 Jul 2023 10:48:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: nfsd in D state, another case
Content-Language: en-US
To:     Miha Vrhovnik <miha.vrhovnik@visionect.com>,
        linux-nfs@vger.kernel.org
References: <CANbXbTt=smOsgJZHCkk8O0EzB+nBd=a7a40my9w59UKTtka0fg@mail.gmail.com>
From:   dai.ngo@oracle.com
In-Reply-To: <CANbXbTt=smOsgJZHCkk8O0EzB+nBd=a7a40my9w59UKTtka0fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0117.namprd05.prod.outlook.com
 (2603:10b6:803:42::34) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4270:EE_|DS7PR10MB5040:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d68411f-6725-4c4a-0663-08db7cb6f0d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZDiiLZBs9KYywlzwECkLYgEUbnr8eLMB68pN/a5qb/bnOV2TUDVpscfGAzI+tYi/ranePKKokb+Dm8NcrXhMj1z/bbaRUNAUwTGilXJhq9TOSdDPIPBAavhD1wGC8TaG5/2KT2/D8sYf2hhqDnPD9zfJa9xdC6wDBkLerdOPF/gYK17frNj3X5Ajh+MmUaT0FMdGETi89P8QNVXYY/OiDzz99m+qIddR3F/UNwAAQyKLCZfWWkd/zsi58UfC/D4/QZcfaoYnjlAFcENeWWpuKj378TvH8Gbg97kGe1HJ6DCW0FM90amxHIVR/y8zzAkuoHaWHamwK4I8g8Jun+MPgSX59u2ytJWId0VrPWC/PV8Qv5YQRYssjmpu3ZgqM2RDRDu6Gm2LeFouiJqB+GuZ/NB+rKz+aozzV7p9XWMk7jV7jYJ7LuwROkPIN6Q8yt3UtXTrmTLP5qS/JviEoFqWiIy5CTMn0JWalk81u+rGuQW3gIizQ1SLor8vJd08SH/iD9SBo1kVu+opWPjb+GAFwo8pjyyJzvr3+fCCf5FdK7u3vBcGSC8pkBf4kxmC0uBV/FGLQA1emDxbfgr/8JtRpD5ZgHUSc+ZTM3YDit9KQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199021)(26005)(478600001)(31686004)(6666004)(9686003)(6506007)(966005)(6512007)(86362001)(31696002)(2616005)(186003)(53546011)(38100700002)(66556008)(66946007)(66476007)(83380400001)(6486002)(316002)(5660300002)(8676002)(8936002)(30864003)(41300700001)(2906002)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXM5WFkxK2Zzd003V1lvZmxZaDViaXpxMVVkdVJhdmYvY0pUQWhFNXk4dHRZ?=
 =?utf-8?B?T2ZLdEtIWG56YlhxWXc1eG9LdjA1TnV3anlveEhjTDFma29RMGlWdmFLcnlw?=
 =?utf-8?B?Y29NNFVkM0krT0VydldTa0hkeCt5VFpMSWpzWUs5cmVjcW9VcUJEUkxjM0t1?=
 =?utf-8?B?ZnhhMGhKQmo1UGpxS3lHcFdTRVkyZGE4Uy9KQlNTL2pwK1ZaY0VGckxlQVp0?=
 =?utf-8?B?Y0J5ejV2RENJWmlja3g5dGY4R0JMbEhmcndUc2dldHZVc0s1RG5TdnFiMTdo?=
 =?utf-8?B?Znl1L0tyeGxOQ3p4Q1AyK2tkakU4U2tCRmFzSGlobTAvK2VVd1J0ZTlzNGhk?=
 =?utf-8?B?TzhaOFUrQTIzUTR3OGNnRStKWStSeGJqQ3FTR3VOb1c4YWdBZ1JvUFU5bnNO?=
 =?utf-8?B?WnZlcnNtMlNJRGZEdjZBaXRoOGt5TURyQ0U2Nm9uUjcvK1ZOMGpEZERmTzU2?=
 =?utf-8?B?akNHajI4ZGJSOE1xelFLRStBMVFYZmorNU8vSVJBTTFRUUR6dXJpSFVXOWpR?=
 =?utf-8?B?K1lVZWdrMmJueVZ4Y29ObGRGN3VaVFVXTGl6bWdjVTcvMnIrWEJBMHp0M3JF?=
 =?utf-8?B?VXIwd01hbXJyREpkNjhrUmJsdzhmdUVVTnJHRHc2Q0hGc05uVVovTU8wM1Zz?=
 =?utf-8?B?N2d5V25oTUJxei9OWXFuTzI2UzBjb1YzN1RReEFvSmFLNHkwekNjb0JlYnRN?=
 =?utf-8?B?SUFkMjlOY2hjbi9MQThZaHEwQ2h5b2RqcHM4NTJrRE5QL1ZKSUYwMmxvU0x2?=
 =?utf-8?B?YlNERnh0T2xHcTZ1MWVVS3BKb3JwYjVoYmRzR2dNUlI2TzAwRGlHYmg1WEtO?=
 =?utf-8?B?cXN1emRBYTBXdEZtK0RnNlZLS2x4SlArUDBPSXIwaERsRzBxZlVieWZxVFRL?=
 =?utf-8?B?YzFHRlc0bGZSQkJEUmtsOGQxV3pjalN3dUdOTy8vZitWVmJwa1djM0V2V25D?=
 =?utf-8?B?OGdvaXZzMWZ5ekJZdCtnSzU0L0RrQjNmd0x3Z1dTWXlWVVgrWWc0VjAzeDFG?=
 =?utf-8?B?dHNUaVMzL0RpVG1kY2RLdWhJMUpHYzU4OWlGZXgrRm5oNUxBeTJTSEFEbjYr?=
 =?utf-8?B?Q21SeWpSV2dJYzFYNG9QS0ZUTTV5L1pNQWpmc0c2b3VDRUQ4TVRaY0IrNDgy?=
 =?utf-8?B?MWpxK21CdGdUMzF6QU5GNit6MVV5OFEySHVwMGxNUmF3OVp2cGRYejdtZ2Jy?=
 =?utf-8?B?MXNCY2p6TnFYVHV1N3hKais5dlZKYmxwM1hRQjQ3aFRtc1FJeURaOWo2QzdK?=
 =?utf-8?B?czduWm5KTG1wUWV2M0NtREtudEtDQTNDTkxNdFhLdnliVkgxMHBrTk5CNDRB?=
 =?utf-8?B?N1hzZjgvNit6RC9zYllpRXI4ZUlWMG45T1VMLzhvU0NUaFRPWDB6cDlzNFN4?=
 =?utf-8?B?UTlxRDZZZTVXdGNFbjNlaGhJLzh5T2pQRkNwdERNdVUxUG9MSVhUbWUyQWtQ?=
 =?utf-8?B?b0FWTFRKaFZpdjlZTk5Mayt0bmUzN3Y2QVBwdzlJcml1Z3c5Sk9NUkVuVVdI?=
 =?utf-8?B?TFB1N01oRmR5bThFUjFtSUNKMXNyL2ZoNmtYUTNCSlZTZVZMWlUyc2RyaGdV?=
 =?utf-8?B?WERPRHd4b1p3WGZvdGlsL3lUenh5eW5KMDZiZE1pNkF1NVAyYzNtVXhSUENB?=
 =?utf-8?B?RGcwNndwSVRMNlNWeDY5N0drNlFBRXJjRUd6Q1NNdlNadldzdmJzbzVJRHhh?=
 =?utf-8?B?a29SQmtSUGhQQ3E1TnNaN2hNTkhLOFN3TnJkazRSYWJwTGVhd01jekV1RFRJ?=
 =?utf-8?B?aUp2VGd6d2hFeVcycHFHME5uSFpZdzBNOHQ3OEg5RzBISXd6OE04bkkzNkxI?=
 =?utf-8?B?SUJCWWVVZ3hSS0ZpTGV1ZmdZYlNTbkVGcXk3ZlZvN2JpOGFvNHFhRGJGcFJF?=
 =?utf-8?B?Y0k0NjNvczNCTXhhaDRVTy9UdXFPclJnSkxJdVJrY2lCV2FsbklYdXppM0R5?=
 =?utf-8?B?bDZGYm9SMTh3eEFaT0xvYnhRamoxZ1VUMy9waUZSUjNIWkVIU0JXMGpBdGdH?=
 =?utf-8?B?NGZpV285MXN0RTJQTDJSK3JybzZYYTgrVGxuT2UyREJNVGVGNG1DQVp2NytQ?=
 =?utf-8?B?TS9VcTdnUEU3VHRGam95QWQzZUd4bGt3VXljcTNwcG5adDFsbzdQTjZJcVdG?=
 =?utf-8?Q?mfGTaTjd9ysfgK9fKnVhQUX2E?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UO4dQjaHyglXJwK2iEsK9/cGGWPgTNgoWrXPTTwDG5LP72iKp6rPlSZ+uFas/3OszxmheWZ+CIqkmIiGlImcwUrL/Y/QSoGJG+yzndANZvxItZeoo21EpOWGzI7A5rs2MmU7CMSLdh/LSxSOKHsODyR4Phu8Rg1PyuNoMe5ke8mFtROlwdKBEflPv8FQBwHBoWMPp48khBFQiYdqfrLRD6C7EbV6GOnEgrBCKvJmyEiQw7ePU8SwEZU4scMmZWvUwYxg9vTvcQYPynIflWgPyk3HdLG8teeGiHFhYXWPUCXwbdmR0aGcnTfH3nZhz6jTlpJ4YAZuEozYRus4oOI3UORjCOwWg91B6DYf2KFpvkZehN6SjbfiW/3R2nyaUFmVXab+/iKV1A9iy9fVpLDt+ggMrBYTAV6KXnK8zIxa9AiHlgmrLwThQwIRZ60Qr1sBcSJ6Y7nlwWX0PwxhVw5yorkDxJwxoDl66sqzEaOk87N0cjc1ho4i6ipVK3a8U0vOu4cd6eGPMRy+i8CbR2qWjJGCP7EDHrpEcQJb3/fnNmPcD+dUwAzGFQXE6mDNx0S9GaMJOy2qkIieoOgJhkdJAxIPM4PLAnu84/9GQ8r+RaL8YFu6Sa2bRqnOb4mg/qVIsuy3Xf9aNWOF+qjk9pjpOOxFXLY2b6HIVITsM1jbNifPDMtwTxi6diz629WO/xR0gw3/wE32YKt5Nqrozx+sMKhwDQetDwwGwW6Y0y78XMiT7LIP0zukhvQ5SNR3JwzHWJVzyLNVRF32kdfxf13ULD1f5GfvcLDEcXagBmwMyxg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d68411f-6725-4c4a-0663-08db7cb6f0d0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 17:48:57.4364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbVAOuUMGfPG5WZSzAJ1ixHZE3nLsiag5Cbn/w0kEaFOLh+dNd9j08hH0ci0DDQwBZNovhKu+GbhOrsYxZ9xhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_12,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040153
X-Proofpoint-GUID: GkFqJq29EqV_IOXwbihcawhmA47B1Z9U
X-Proofpoint-ORIG-GUID: GkFqJq29EqV_IOXwbihcawhmA47B1Z9U
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Miha,

I don't have any solution for this problem based on the provided data.
However next time when this problem occurs, please do the following on
the NFS server to gather some diagnostic info so we can investigate:

1. dump the workqueues:

#  echo t > /proc/sysrq-trigger

Output is written to /var/log/messages.

2. gather nfsd and rpc task info:

# (for tt in $(grep -l 'nfs' /proc/*/stack); do echo "${tt}:"; cat ${tt}; echo; done) > /tmp/nfs_threads.txt

# cat /sys/kernel/debug/sunrpc/rpc_clnt/*/tasks > /tmp/rpc_tasks.txt


You can put /var/log/messages, nfs_threads.txt and rpc_tasks.txt at some
public place where we can get to, or you can email them directly to me.

Thanks,
-Dai

On 7/3/23 2:05 AM, Miha Vrhovnik wrote:
> Hey everybody,
>
> we are experiencing a similar issue to Dr. Herzog [1]. the details and
> our configuration is a bit different than his, but I'd assume that the
> same bug is behind this.
>
> It's a single server per region, with NFS is on local storage formatted as ext4.
> The servers don't have a swap and have plenty of free memory. 16G-20G
> used (without caches) out of 64G.
> The amount of data stored is rather small about 1G, with about 100.000
> files over 17.000 directories
>
> We've upgraded the servers from Ubuntu 20.04 to Ubuntu 22.04 about a
> month ago and we had four outages since than.Our clients are still on
> Ubuntu 20.04 if this helps
> Our setup is rather small.But the impacts aprox. 10.000 users per region.
>
> And the packages in Ubuntu 22.04 are a bit older than the ones in
> Debian 12 (bookworm )
>
> apt list --installed '*nfs*'
> Listing... Done
> libnfsidmap1/jammy-updates,now 1:2.6.1-1ubuntu1.2 amd64 [installed,automatic]
> nfs-common/jammy-updates,now 1:2.6.1-1ubuntu1.2 amd64 [installed]
> nfs-kernel-server/jammy-updates,now 1:2.6.1-1ubuntu1.2 amd64 [installed]
>
> and the kernel
> Linux redacted 5.19.0-1026-gcp #28~22.04.1-Ubuntu SMP Tue Jun 6
> 07:24:26 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
>
> Stack-trace is a different from the one provided by Dr. Herzog. But
> the same between servers.
> so only full server restart helps. And once this happened almost
> immediately after the server was rebooted.
>
> This is the first time that it happened that day.
>
> Jun 26 11:34:07 redacted kernel: [326687.684554] receive_cb_reply: Got
> unrecognized reply: calldir 0x1 xpt_bc_xprt 000000000dddae84 xid
> bb78d292
> Jun 26 11:34:07 redacted kernel: [326687.684634] receive_cb_reply: Got
> unrecognized reply: calldir 0x1 xpt_bc_xprt 000000000dddae84 xid
> ba78d292
> Jun 26 11:41:38 redacted kernel: [327139.472177] receive_cb_reply: Got
> unrecognized reply: calldir 0x1 xpt_bc_xprt 000000004df70d45 xid
> 3bfdc2ea
> Jun 26 11:44:30 redacted kernel: [327310.678539] INFO: task nfsd:848
> blocked for more than 120 seconds.
> Jun 26 11:44:30 redacted kernel: [327310.685086]       Not tainted
> 5.19.0-1026-gcp #28~22.04.1-Ubuntu
> Jun 26 11:44:30 redacted kernel: [327310.691358] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Jun 26 11:44:30 redacted kernel: [327310.699442] task:nfsd
> state:D stack:    0 pid:  848 ppid:     2 flags:0x00004000
> Jun 26 11:44:30 redacted kernel: [327310.699451] Call Trace:
> Jun 26 11:44:30 redacted kernel: [327310.699456]  <TASK>
> Jun 26 11:44:30 redacted kernel: [327310.699464]  __schedule+0x248/0x5d0
> Jun 26 11:44:30 redacted kernel: [327310.699478]  schedule+0x58/0x100
> Jun 26 11:44:30 redacted kernel: [327310.699482]  schedule_timeout+0x10d/0x140
> Jun 26 11:44:30 redacted kernel: [327310.699489]  __wait_for_common+0x99/0x1b0
> Jun 26 11:44:30 redacted kernel: [327310.699493]  ? usleep_range_state+0xa0/0xa0
> Jun 26 11:44:30 redacted kernel: [327310.699497]  wait_for_completion+0x24/0x40
> Jun 26 11:44:30 redacted kernel: [327310.699501]  __flush_workqueue+0x140/0x3e0
> Jun 26 11:44:30 redacted kernel: [327310.699512]
> nfsd4_probe_callback_sync+0x1a/0x30 [nfsd]
> Jun 26 11:44:30 redacted kernel: [327310.699566]
> nfsd4_destroy_session+0x184/0x230 [nfsd]
> Jun 26 11:44:30 redacted kernel: [327310.699597]
> nfsd4_proc_compound+0x42b/0x770 [nfsd]
> Jun 26 11:44:30 redacted kernel: [327310.699629]
> nfsd_dispatch+0x174/0x270 [nfsd]
> Jun 26 11:44:30 redacted kernel: [327310.699670]
> svc_process_common+0x2a5/0x610 [sunrpc]
> Jun 26 11:44:30 redacted kernel: [327310.699760]  ?
> svc_handle_xprt+0x166/0x350 [sunrpc]
> Jun 26 11:44:30 redacted kernel: [327310.699807]  ? nfsd_svc+0x1a0/0x1a0 [nfsd]
> Jun 26 11:44:30 redacted kernel: [327310.699835]  ?
> nfsd_shutdown_threads+0xa0/0xa0 [nfsd]
> Jun 26 11:44:30 redacted kernel: [327310.699863]
> svc_process+0xba/0x110 [sunrpc]
> Jun 26 11:44:30 redacted kernel: [327310.699906]  nfsd+0xd1/0x1a0 [nfsd]
> Jun 26 11:44:30 redacted kernel: [327310.699932]  kthread+0xce/0xf0
> Jun 26 11:44:30 redacted kernel: [327310.699937]  ?
> kthread_complete_and_exit+0x20/0x20
> Jun 26 11:44:30 redacted kernel: [327310.699941]  ret_from_fork+0x1f/0x30
> Jun 26 11:44:30 redacted kernel: [327310.699948]  </TASK>
>
>
>
> This is about 10 minutes after reboot:
>
> Jun 26 12:45:13 redacted kernel: [  373.274344] receive_cb_reply: Got
> unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000016b8f89c xid
> b4752784
> Jun 26 12:49:06 redacted kernel: [  605.568257] INFO: task nfsd:887
> blocked for more than 120 seconds.
> Jun 26 12:49:06 redacted kernel: [  605.574821]       Not tainted
> 5.19.0-1026-gcp #28~22.04.1-Ubuntu
> Jun 26 12:49:06 redacted kernel: [  605.581432] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Jun 26 12:49:06 redacted kernel: [  605.589914] task:nfsd
> state:D stack:    0 pid:  887 ppid:     2 flags:0x00004000
> Jun 26 12:49:06 redacted kernel: [  605.589926] Call Trace:
> Jun 26 12:49:06 redacted kernel: [  605.589931]  <TASK>
> Jun 26 12:49:06 redacted kernel: [  605.589937]  __schedule+0x248/0x5d0
> Jun 26 12:49:06 redacted kernel: [  605.590112]  schedule+0x58/0x100
> Jun 26 12:49:06 redacted kernel: [  605.590117]  schedule_timeout+0x10d/0x140
> Jun 26 12:49:06 redacted kernel: [  605.590125]  __wait_for_common+0x99/0x1b0
> Jun 26 12:49:06 redacted kernel: [  605.590129]  ? usleep_range_state+0xa0/0xa0
> Jun 26 12:49:06 redacted kernel: [  605.590134]  wait_for_completion+0x24/0x40
> Jun 26 12:49:06 redacted kernel: [  605.590138]  __flush_workqueue+0x140/0x3e0
> Jun 26 12:49:06 redacted kernel: [  605.590147]
> nfsd4_probe_callback_sync+0x1a/0x30 [nfsd]
> Jun 26 12:49:06 redacted kernel: [  605.590199]
> nfsd4_destroy_session+0x184/0x230 [nfsd]
> Jun 26 12:49:06 redacted kernel: [  605.590235]
> nfsd4_proc_compound+0x42b/0x770 [nfsd]
> Jun 26 12:49:06 redacted kernel: [  605.590270]
> nfsd_dispatch+0x174/0x270 [nfsd]
> Jun 26 12:49:06 redacted kernel: [  605.590303]
> svc_process_common+0x2a5/0x610 [sunrpc]
> Jun 26 12:49:06 redacted kernel: [  605.590392]  ?
> svc_handle_xprt+0x166/0x350 [sunrpc]
> Jun 26 12:49:06 redacted kernel: [  605.590447]  ? nfsd_svc+0x1a0/0x1a0 [nfsd]
> Jun 26 12:49:06 redacted kernel: [  605.590479]  ?
> nfsd_shutdown_threads+0xa0/0xa0 [nfsd]
> Jun 26 12:49:06 redacted kernel: [  605.590510]  svc_process+0xba/0x110 [sunrpc]
> Jun 26 12:49:06 redacted kernel: [  605.590561]  nfsd+0xd1/0x1a0 [nfsd]
> Jun 26 12:49:06 redacted kernel: [  605.590598]  kthread+0xce/0xf0
> Jun 26 12:49:06 redacted kernel: [  605.590603]  ?
> kthread_complete_and_exit+0x20/0x20
> Jun 26 12:49:06 redacted kernel: [  605.590608]  ret_from_fork+0x1f/0x30
> Jun 26 12:49:06 redacted kernel: [  605.590616]  </TASK>
>
> when things started to go really bad we gt another stacktrace:
> Jun 26 12:53:07 redacted kernel: [  847.232530] INFO: task
> kworker/u8:3:5078 blocked for more than 120 seconds.
> Jun 26 12:53:07 redacted kernel: [  847.239937]       Not tainted
> 5.19.0-1026-gcp #28~22.04.1-Ubuntu
> Jun 26 12:53:08 redacted kernel: [  847.246163] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Jun 26 12:53:08 redacted kernel: [  847.254308] task:kworker/u8:3
> state:D stack:    0 pid: 5078 ppid:     2 flags:0x00004000
> Jun 26 12:53:08 redacted kernel: [  847.254328] Workqueue: nfsd4
> laundromat_main [nfsd]
> Jun 26 12:53:08 redacted kernel: [  847.254438] Call Trace:
> Jun 26 12:53:08 redacted kernel: [  847.254443]  <TASK>
> Jun 26 12:53:08 redacted kernel: [  847.254449]  __schedule+0x248/0x5d0
> Jun 26 12:53:08 redacted kernel: [  847.254460]  ? available_idle_cpu+0x66/0xa0
> Jun 26 12:53:08 redacted kernel: [  847.254467]  schedule+0x58/0x100
> Jun 26 12:53:08 redacted kernel: [  847.254472]  schedule_timeout+0x10d/0x140
> Jun 26 12:53:08 redacted kernel: [  847.254478]  __wait_for_common+0x99/0x1b0
> Jun 26 12:53:08 redacted kernel: [  847.254482]  ? usleep_range_state+0xa0/0xa0
> Jun 26 12:53:08 redacted kernel: [  847.254485]  wait_for_completion+0x24/0x40
> Jun 26 12:53:08 redacted kernel: [  847.254489]  __flush_workqueue+0x140/0x3e0
> Jun 26 12:53:08 redacted kernel: [  847.254494]
> nfsd4_shutdown_callback+0x4d/0x130 [nfsd]
> Jun 26 12:53:08 redacted kernel: [  847.254525]  ?
> nfsd4_return_all_client_layouts+0xc9/0x160 [nfsd]
> Jun 26 12:53:08 redacted kernel: [  847.254556]  ?
> nfsd4_shutdown_copy+0x70/0xb0 [nfsd]
> Jun 26 12:53:08 redacted kernel: [  847.254600]
> __destroy_client+0x1a1/0x210 [nfsd]
> Jun 26 12:53:08 redacted kernel: [  847.254630]  expire_client+0x57/0x70 [nfsd]
> Jun 26 12:53:08 redacted kernel: [  847.254659]
> nfs4_laundromat+0x26e/0x900 [nfsd]
> Jun 26 12:53:08 redacted kernel: [  847.254690]  ?
> finish_task_switch.isra.0+0x82/0x290
> Jun 26 12:53:08 redacted kernel: [  847.254697]
> laundromat_main+0x19/0x50 [nfsd]
> Jun 26 12:53:08 redacted kernel: [  847.254726]  process_one_work+0x222/0x3c0
> Jun 26 12:53:08 redacted kernel: [  847.254731]  worker_thread+0x50/0x3f0
> Jun 26 12:53:08 redacted kernel: [  847.254734]  ? process_one_work+0x3c0/0x3c0
> Jun 26 12:53:08 redacted kernel: [  847.254736]  kthread+0xce/0xf0
> Jun 26 12:53:08 redacted kernel: [  847.254742]  ?
> kthread_complete_and_exit+0x20/0x20
> Jun 26 12:53:08 redacted kernel: [  847.254746]  ret_from_fork+0x1f/0x30
> Jun 26 12:53:08 redacted kernel: [  847.254754]  </TASK>
>
>
> 1 - https://marc.info/?l=linux-nfs&m=168258759703478&w=2
>
> Regards,
> Miha
