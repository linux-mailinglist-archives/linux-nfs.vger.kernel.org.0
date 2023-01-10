Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2D7664C06
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 20:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbjAJTIw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 14:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbjAJTI0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 14:08:26 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7127D2F7A8
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 11:08:00 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AJ3qS8012336;
        Tue, 10 Jan 2023 19:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9LVd4jB9h5qFblw8aifpLK+eo5sN3MZeeqTee6zp9rU=;
 b=xiW3mSCBbHqKXLa+sgFGJm6L7gUeHF2WaQpydt+F0/p3hPkWyCQkk5MZ8gUIbOsLzh2x
 ie5NiYWk05dkm/Iy/gqD6JxNseYp0qB31LeYGiVGLq3sQl4/4Nb6iFJl2FFAYsN0Ay0G
 60JpoXBQz3ZYEBP2L9N9WR+sFL5H0VFPclVPCWj064i7i223L1llk1pATMDVnIIkiA47
 vxY5vv5mug6Hp8Pypwx7fMQZMxhcosuBhPAqb2MWLvwLMXEB8LBt38BDDgx1cJNWItsR
 typa24SoDfYsnL0MBTkvpTcV3s9YiPTAWeDU7ly7WEF3LXpEeBhsoqUxUgsVL+fi+KzB GA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1cbq88a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 19:07:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AIXYlm020893;
        Tue, 10 Jan 2023 19:07:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1ddbhkac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 19:07:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaEGxCx3TTY4RLMUGVdfZiz6pDhlR5PYi+Pyupl7gxI758ztsZANQiU36zDitIHDJKV/Qec/tCu9jdVllaHbDMGSLXFLnoOIssY0KOANLCzCyR6CMiP4Et3cQm+FGmpJa9Wsi0e6yKDQyIKssd9sPO4uppZOUxdfShr12OVRpfvobfJamCDAwafw5dYZV9LZpZx6N0EfpOt3MJ2T5coQvbRtP/a99YuNIW+UWTTmveGhbsqDa8grKqaxIYzDcLxNRqKlWDWp+aX89OhNgipO1IWBErxQhQOu51KwP5orOzMg449GJx9D9xfPctraqsBIwlGEgHlzGRko9tpaeJ3+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LVd4jB9h5qFblw8aifpLK+eo5sN3MZeeqTee6zp9rU=;
 b=YXn7VaK68ChZaror/9zl/4IiwCXFzuwrX6yc+1Nt55MjJyXtLavwoH4DWjgA5yAszlpfjftsf1hP2cE/Xwmffm/PdOcsFAJ4GzB3XLTHYxa7ALoSHLMuhQJvk43lG1q8cAC0GiZc05AWJ9xq4RQMh76PwpKthILJciCtRgp4GWemewdwdi/73vcj7MZdT43kkMzHV8iJUzdnQeeUCbMYaPRO4tjsFq/o783I9zV7XLhjdTsM6iB1wBALVTZQeFzU3IycAYd7IwbXIhnE4/ED3q5Wbrn2qhUnB3LvG4skU+rnbHw0KjHFG5nOrCFiCDOOn0IQAJRqzq7Cpl4ljPbBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LVd4jB9h5qFblw8aifpLK+eo5sN3MZeeqTee6zp9rU=;
 b=UDoIkPyWNFgAyHohoUYtV4TdxlXK3v3QXkgmxpfzBMJLQALHEJSTdf7IhROj/HTWgpTpRbXN+5GSc4+t7OjCoxQEkosiplSnmHAcZR+xLnGImJGZGeKy1CrAE6D2JhONBmR/Y5enN/aymiKelx9vcMnAKB8RVvJDZiUMfjk9c4g=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ2PR10MB7084.namprd10.prod.outlook.com (2603:10b6:a03:4c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 10 Jan
 2023 19:07:52 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%7]) with mapi id 15.20.6002.012; Tue, 10 Jan 2023
 19:07:52 +0000
Message-ID: <81ba97c7-659b-7fb3-5a78-d9a6e14c7933@oracle.com>
Date:   Tue, 10 Jan 2023 11:07:48 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
 <57dc06d57b4b643b4bf04daf28acca202c9f7a85.camel@kernel.org>
 <71672c07-5e53-31e6-14b1-e067fd56df57@oracle.com>
 <8C3345FB-6EDF-411A-B942-5AFA03A89BA2@oracle.com>
 <a6a0b2cc-1bc0-3884-8675-f90051454f94@oracle.com>
 <EA9249DE-AB97-4919-9FC9-880D90D726B6@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <EA9249DE-AB97-4919-9FC9-880D90D726B6@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::13) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SJ2PR10MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: 098f3070-0866-439c-7d02-08daf33df8bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q3qfDkTgJ5URmz4YoxSJBmBFtPdrQAOQBhtM/06ofnhxayLAe4Q4zIg2wd0SV4y+6AXwuGTu9XaqR4cssk37KvytszS7MSQENc4fpejr0cI4PLbmW0UcQrY/cSMucO+FXT8toV6cEmxyux9Pd+qgWgBNCvK4suPs4Qn8lkffpC/wNH5Hn5h2S7zx+werLJlQSkcgzWk+4PTY6eSpBH4xR6VQ0pjdZkpPZREMaFB2Y3OaLxJi3iHOCH/Wx/++3vSHkICOHLjzFZ0cXfb+MELWRjSGx54agIzKiMSR9ttiWVhvQPn3cObymMlTP7qBmFRiudc2dgM2WbcGWisszet2EL25zS3Db/NX50H8pgvEqnRI40zGm3KHzMzW3w55Zm3pCSsY778vmvljUWGfuWaINJE65r2EeJYkNAcGYzjy8JSA/Yf2KxOWITCPac8wv0CR8AkdWxmjTVGLkkO74ByFAEntM2N8KRncf398sDVuyDND5s2u0l+tLHEmTqEFlTCOgLNHOImWHdDV0obd9ws4VH0YxbqIeFaEgzh6WufzTgriFwPMzCVZ4wTCMKa/oQb07eOOcQrzuvwvK+Kpa+Sw0dpUQ8EbAQ/5puPPhVZgWT+CelP4O24TNlwt+92tRRWA1hiRZ2OfmNxc9a4dhXcKYtqBNB3DWm5Gsq+dKuvyPBuIEw9raJvERQEQjIr5IDcnWIzoQua7tCP5hFCVdHnn+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199015)(83380400001)(2616005)(41300700001)(66556008)(4326008)(66476007)(31686004)(8676002)(6666004)(6862004)(8936002)(186003)(66946007)(5660300002)(9686003)(6512007)(26005)(2906002)(6486002)(6506007)(478600001)(31696002)(53546011)(36756003)(54906003)(86362001)(38100700002)(316002)(37006003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGR0d1NXZ0tLWmt5ejFYaUp5ZUM1S2Fna2RqQmFIYXVoVHdVa1V3anJIK1lZ?=
 =?utf-8?B?dWNGSHFwM2ZJS2w5Z3hiZGhxeW9VcjR0S1RaVUZPNU5NcnFZN1FMcEdPdmpP?=
 =?utf-8?B?d25NMXJ0dTJsMk9RSTR1K3FlWXE4OWlZL2dYM0RNeXB2L3ZIbEFjUHp0ek1J?=
 =?utf-8?B?NkduKzVvU2ZuWG5DZk9Xd1Zzc24yallHRU1iWEZSdiswaFVTeGtqTmhza1p5?=
 =?utf-8?B?bXlLS3pUM1RUSVpXZi84SmszU0xiNEx5R2MzNXpjRGE2bUd6bkx6akZiOUg3?=
 =?utf-8?B?Q3lwL20vUWQxeGJUU3VsZkhWK3k3ZlFRNnFTU3ArT1RKZkRjazdNVE4vZ2V0?=
 =?utf-8?B?QkpOQzZoMkN5Q2cxVVl1c1g5MlNBYXJnRVRhMW5taHdqVzZ1UTNVMGZuNnJB?=
 =?utf-8?B?MmU0QzVYZVJtWWZZU0huVURvVWt5NXJIekgyMW91UnJPQ0Q2dmsyMGR2R25t?=
 =?utf-8?B?TmVyOUN6b0RZcFpwQURkVnlQVGw3ZWNCNFd2OTdMQW9rYkRpakNlWDF0eTZD?=
 =?utf-8?B?am1vK0VwUDA2bm1MdWJDSHFyZEkzTHpyVDlyMVpTdzVKazdNZXllNVRncjJC?=
 =?utf-8?B?U2JuMUNMNEhURzM3dk9zLzV4V003d3FMWnFTOTliSjNHbU01Y2FVa3hWbVBI?=
 =?utf-8?B?THdGMFRQbEtSOXowdnV4U29ZZ1MyRDZGRVIxek5xdURyaEQzMUpuRHpXdkFp?=
 =?utf-8?B?Vk05a2tEVi80SWt0OVdwQS9DL2QxRTdvOWNiMWhOSVRNa3hDS2M1dmhySmRt?=
 =?utf-8?B?OE9qSEdtWWdEbVN2cGw0WVNVS1ljRE13VWN6eGQ2bDBzdkExL3dleVd0eTZz?=
 =?utf-8?B?SVJHekR5Z0dsRXlBMG5wNjd6dGgzWW8xYlp6WklLT1R4ZjB2UklKNFA4SmRO?=
 =?utf-8?B?aW5RbmhCZXBGZ2lsdnk3dFJ1Q0NkeEpHZ0YxMkt3SVBrNVJlWFUwZUxlZis1?=
 =?utf-8?B?NUpvUVpaWmpUeHErNlEySlVpeitHSGd6THBmMG8ySUx2bzlYejF3L2Jxd3Rk?=
 =?utf-8?B?REZDbjlIb0dGOHkrRW1HM21kY3BWNEkyb2ZnQTNYdmNQNGlQUUVjM2JqaThZ?=
 =?utf-8?B?bnJQRlJDSjIzN3NBWVB4M0srUXl1a1FtMUhWZVRlNU12T2VoYmtzOGU0VWha?=
 =?utf-8?B?aGZOcnp1NUc4MmVjeUhIZTJlbnNQdTdhRUFIUXoyaDZ5U0kxS3lZQkxYSnZW?=
 =?utf-8?B?M25GeXpNbE5hamZaY1dJYW5uMjMvSmFjRldvUGdyNjZOR2t0TTFSSm5GTlAz?=
 =?utf-8?B?aHNPdnBBblBFdmhrV1luR0tkMEV4V05WU2FENzlCZElBcllidjBDNmY0SHgx?=
 =?utf-8?B?MnpKR0dFOGdtRDVTRXRIeDgwY3IzQkpvdXRyeUxudHRON1dXdHV2TDdOeWZM?=
 =?utf-8?B?SnN6ZkVwNGFLSW5tZmhPYXJyaGZub0tKMkJRVW9DbWljWEpXOHpqVm1YZlVQ?=
 =?utf-8?B?eDVwc3ZUdGJEeUREUC9jSUZKVUMrTjdiVG9qUXlUYUdIazRYeWJZNnh1aklG?=
 =?utf-8?B?V3FxbkhBYUh6ZVpBWDZIMEI1YTZMdU9KNVdDK0hxN0FDSTAwNndFMTI5TUFi?=
 =?utf-8?B?TStPdjFmZjgvZFdPLzAxYW1DWnhFTGNzczNQUjQwZUdSaGkrV0lvYmFnM3hs?=
 =?utf-8?B?TDRIQ1RxeTFHZGNWenA3aC92ZlhmeDUzblpKL2RBekgrdkxBdVFEUU9OWUtF?=
 =?utf-8?B?SEF5aEgzQmVWZERyWUJFVUUzcUU2cTQrN3Y2bjAwR0ZCbzZpN1ZFUWtVWGlE?=
 =?utf-8?B?WHF3WWw5QUFuSDI4eGZKbEV0N2I0bkFZRG9td2hLVzF5KzVxcHpYWU5CT1lv?=
 =?utf-8?B?dFVQZjNIUWdETTBmdjBRU001eFpIeWhwNE5xcGljZmt4YVVCZmlhWVpuMU1V?=
 =?utf-8?B?aFMyOHQza1pDYStuVy9rSGhHNkZ6dUtVa1dCREE0R2RmYjJaK2c1Skx0RGln?=
 =?utf-8?B?czZabmttY29rL0EyMUx2eHFubXR2L3BPbmdHb214YSs2QjNpT0VjaWdRN2NZ?=
 =?utf-8?B?VlBVZVMyUjdXYnVsUCtPbzFwVm9tRnZJNkJPWmhwZVVvWHZPVzY5aC91cWNW?=
 =?utf-8?B?aUdISm1mUHJEZzhUUkJNRnh4d0YxSkQvcSt4Mis3b01uNkFLcVNiSGdoOGVr?=
 =?utf-8?Q?0Zg5b+1Navq1WShW4FvD0g3pn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q6x7mAfBR3WB0g4DKIMhUlwGDeSCWbFT7ux/LziJXnhbpwWXreitE6Wqf3KU1hirlErs9aS9NhcjAer15D8QJzcJkmH5Qv7h6FO/H+9JyjUAv2rhnWiR4XK9w7cC22haCe5kKvApZ5ukLlSS8evXY4r3ZDzuMpv9gKCeubVdsoElqGdw04qR1/A2K3RQyFu0s/jDdjkDRd01RV3aKnCX1XgAfbEMU/6sk/9Xe9LTsVjFAyt4gRjPIa0Gtaz86LYr6euXrprMjNsGo01cB+hgOnMYBYZ8TrRsUFhIGKjAGYBCZhux0Sa45xyqfje9GRAELgW5HWlpr0PybljKc0sdTTMQcvjaB7eAY+TcBeFr5oBke5TGFzyhMz6oZYup5bHAY5J2/2ErHVe+6Ihv+P1/SqnqSB4jDMyp9t9MCRDzmlCccXsda/hQljizAzdWsxIQbO6G0d0f9RFNjXYMxs8lXePkP8AY5RoKODPOZ3fvmzxdTtVDzrmOkflG3BosAunniLUtmlXA6OmYZRP6Uk1XSDlxRrnHpJFEfXM4RNj//V2NhdHaPtALW6/E91XPZ5VZjNYvCEOCAKIpq32lEL9dYdTEbuk4ZH9586bOpGYr7bYh55cSSJUl5amHznEegXkC5Ljc8yMqiKe0iEgnE6PVN/9u+JADHTYqGjXVLBc+TgWoc/jhIsF5Dg+Sv4WyyvzYmJ2AlN1G19YteVNHHHzmFwleyh968QQH2W/xKWd2O1vY78YMd0mGdMEw6UodEqJhpOhxiAY431aZD7fc+bIJQ8wF78rrW8l/CCvpGCINw1JBCYpYPLGSb8dZkZJpXAfj
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098f3070-0866-439c-7d02-08daf33df8bd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 19:07:51.9943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4u0UN9Zhmra0jHq12Rgxnasmog9ONB2R4mSIiX3JRBtZ7FwyAFVG5IdB777NInAW8qM6MWDOIFexPbJhUBQiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7084
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_08,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100124
X-Proofpoint-ORIG-GUID: tIdUqYVy4HrAyNz6dvDBaExOuPS4uwpc
X-Proofpoint-GUID: tIdUqYVy4HrAyNz6dvDBaExOuPS4uwpc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 1/10/23 10:53 AM, Chuck Lever III wrote:
>
>> On Jan 10, 2023, at 1:46 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>>
>> On 1/10/23 10:17 AM, Chuck Lever III wrote:
>>>> On Jan 10, 2023, at 12:33 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>
>>>>
>>>> On 1/10/23 2:30 AM, Jeff Layton wrote:
>>>>> On Mon, 2023-01-09 at 22:48 -0800, Dai Ngo wrote:
>>>>>> Currently nfsd4_state_shrinker_worker can be schduled multiple times
>>>>>> from nfsd4_state_shrinker_count when memory is low. This causes
>>>>>> the WARN_ON_ONCE in __queue_delayed_work to trigger.
>>>>>>
>>>>>> This patch allows only one instance of nfsd4_state_shrinker_worker
>>>>>> at a time using the nfsd_shrinker_active flag, protected by the
>>>>>> client_lock.
>>>>>>
>>>>>> Replace mod_delayed_work with queue_delayed_work since we
>>>>>> don't expect to modify the delay of any pending work.
>>>>>>
>>>>>> Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory condition")
>>>>>> Reported-by: Mike Galbraith <efault@gmx.de>
>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>> ---
>>>>>>   fs/nfsd/netns.h     |  1 +
>>>>>>   fs/nfsd/nfs4state.c | 16 ++++++++++++++--
>>>>>>   2 files changed, 15 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>>>>>> index 8c854ba3285b..801d70926442 100644
>>>>>> --- a/fs/nfsd/netns.h
>>>>>> +++ b/fs/nfsd/netns.h
>>>>>> @@ -196,6 +196,7 @@ struct nfsd_net {
>>>>>>   	atomic_t		nfsd_courtesy_clients;
>>>>>>   	struct shrinker		nfsd_client_shrinker;
>>>>>>   	struct delayed_work	nfsd_shrinker_work;
>>>>>> +	bool			nfsd_shrinker_active;
>>>>>>   };
>>>>>>     /* Simple check to find out if a given net was properly initialized */
>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>> index ee56c9466304..e00551af6a11 100644
>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>> @@ -4407,11 +4407,20 @@ nfsd4_state_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
>>>>>>   	struct nfsd_net *nn = container_of(shrink,
>>>>>>   			struct nfsd_net, nfsd_client_shrinker);
>>>>>>   +	spin_lock(&nn->client_lock);
>>>>>> +	if (nn->nfsd_shrinker_active) {
>>>>>> +		spin_unlock(&nn->client_lock);
>>>>>> +		return 0;
>>>>>> +	}
>>>>> Is this extra machinery really necessary? The bool and spinlock don't
>>>>> seem to be needed. Typically there is no issue with calling
>>>>> queued_delayed_work when the work is already queued. It just returns
>>>>> false in that case without doing anything.
>>>> When there are multiple calls to mod_delayed_work/queue_delayed_work
>>>> we hit the WARN_ON_ONCE's in __queue_delayed_work and __queue_work if
>>>> the work is queued but not execute yet.
>>> The delay argument of zero is interesting. If it's set to a value
>>> greater than zero, do you still see a problem?
>> I tried and tried but could not reproduce the problem that Mike
>> reported. I guess my VMs don't have fast enough cpus to make it
>> happen.
> I'd prefer not to guess... it sounds like we don't have a clear
> root cause on this one yet.

Yes, we do, as I explained in above. The reason I could not reproduce
it because my system is not fast enough to get multiple calls to
nfsd4_state_shrinker_count simultaneously.

>
> I think I agree with Jeff: a spinlock shouldn't be required to
> make queuing work safe via this API.
>
>
>> As Jeff mentioned, delay 0 should be safe and we want to run
>> the shrinker as soon as possible when memory is low.
> I suggested that because the !delay code paths seem to lead
> directly to the WARN_ONs in queue_work(). <shrug>

If we use 0 delay then we need the spinlock, as proven by Mike's test.
If we use delay != 0 then it may work without the spinlock, we will
Mike to retest it.

You and Jeff decide what the delay is and I will make the change
and retest.

-Dai

>
>
>> -Dai
>>
>>>
>>>> This problem was reported by Mike. I initially tried with only the
>>>> bool but that was not enough that was why the spinlock was added.
>>>> Mike verified that the patch fixed the problem.
>>>>
>>>> -Dai
>>>>
>>>>>>   	count = atomic_read(&nn->nfsd_courtesy_clients);
>>>>>>   	if (!count)
>>>>>>   		count = atomic_long_read(&num_delegations);
>>>>>> -	if (count)
>>>>>> -		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
>>>>>> +	if (count) {
>>>>>> +		nn->nfsd_shrinker_active = true;
>>>>>> +		spin_unlock(&nn->client_lock);
>>>>>> +		queue_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
>>>>>> +	} else
>>>>>> +		spin_unlock(&nn->client_lock);
>>>>>>   	return (unsigned long)count;
>>>>>>   }
>>>>>>   @@ -6239,6 +6248,9 @@ nfsd4_state_shrinker_worker(struct work_struct *work)
>>>>>>     	courtesy_client_reaper(nn);
>>>>>>   	deleg_reaper(nn);
>>>>>> +	spin_lock(&nn->client_lock);
>>>>>> +	nn->nfsd_shrinker_active = 0;
>>>>>> +	spin_unlock(&nn->client_lock);
>>>>>>   }
>>>>>>     static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *stp)
>>> --
>>> Chuck Lever
> --
> Chuck Lever
>
>
>
