Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541516E5423
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Apr 2023 23:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjDQVwF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Apr 2023 17:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDQVwE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Apr 2023 17:52:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DE6E5
        for <linux-nfs@vger.kernel.org>; Mon, 17 Apr 2023 14:52:02 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HLTcMB004149;
        Mon, 17 Apr 2023 21:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=9i1dWamsjeV4LAITFQgiTkWJBX/ihUnKlU98zPdmOAM=;
 b=11EhqBU5MeAb4Jq81a+2+ns/6USuNRHWwlBs9y+2vo6MHQDpbB8Sv+TfvDaFZUEIWHgM
 I0YLGajrfn9cV0zr2f/5zVdWnz//u2GiLM4voM1K7fJYHxXSUKGiiIEanKTtXItHHRsr
 8cCq27bt/F2jVf8DYb6WSpgW3H5fqUGwPNdhK/rIn4nBA7nq1glEc39EbFYTKqBp0JKP
 0hMJlw2fiD3GgPipdXxrvoR5Y/bArZScRCIDC4OTQBepcVxjD+ASybvOU5E6hXbN/iZq
 5nCI5guUbEvDRf15dXS9YawMlLaxJW0KdJJrHVXt8mwhmFBiVphJeTUVLPdEwYh+d0tp Vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyktam7cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Apr 2023 21:51:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33HLkjZQ017492;
        Mon, 17 Apr 2023 21:51:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcaym8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Apr 2023 21:51:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTeH2xJVJwuF7G+V6xulGbpUQ0uVzHQumEh0i919ZjehQSSylGfSzQrmd/DU9ePLTrsSki3HTfHhbbcod1zCu4wXkIZm1KlsgHzjKutxmrOA/PswO2XAg02OaOeah2pdkpcxpXkpCF4GVpKZLVYh76PtFziO8qy0pFJ4RGTjgC1+haQFRmRUGAMbrsuuh9/gtXWWJm5e2fsPdQW1oox9Tgr05hhDHB4JiJwg1uGyinHndQ81R9zSG57lxznDGSTvkD7Msjkh9Z8enb3cuZ+yYOp/ZXfctUS9SZj6z2jPNaj0a16USUPYghhzHYCNsmzhXQqSCk5Km8io/et/jLK4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9i1dWamsjeV4LAITFQgiTkWJBX/ihUnKlU98zPdmOAM=;
 b=fJAUVfWF+mdI0/gArAuHhQYq+s8LNiYWR68MCtm2TvXRgvEwDJ0KwfQN1twFFuR7BE/iYLIKAd7gUTmrj2EK9lHsASYhtFKxEIVTK73NRYke60MHIcBk4sfySggzO4s/D5IkmX4zsbDEbZCtN5VLLoPvmSBsYGKxKmOhspmSnMMbjfn8IMYWyU9KFA0Y/9NxU2T9i64IcE+yPdvrc9QpDtEhEby9TLncQq2S7c0IFsXm2POtitYlM6B/Kz8LOayPsj3I5/C7nQN1egG+Zo8AvEbPgWUo9CDYnzylfFXM86+kDsKcjauceV1O7R/ITc0QY15530ypboAQIzcI8aniTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9i1dWamsjeV4LAITFQgiTkWJBX/ihUnKlU98zPdmOAM=;
 b=X0YFkO2OfSwELPfaj2tzjjshLHkfvKHiZteRBPyjOPHLfB1bBd027ljynlD9cRd4VoJGO/isofnBjhecQyTI2yLEextPHWi808PxhqrP+uhiGpg5pZsuLxGqMYO/b5u6Q4mI50mcDvmRXBtBBl3ZQpeHhBJw4LiLeVqdK13uSIQ=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SA1PR10MB7553.namprd10.prod.outlook.com (2603:10b6:806:376::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 21:51:52 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%6]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 21:51:52 +0000
Message-ID: <19bf7b21-fc68-5281-e587-b7d290899456@oracle.com>
Date:   Mon, 17 Apr 2023 14:51:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
Content-Language: en-US
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Cc:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <1680924600-11171-1-git-send-email-dai.ngo@oracle.com>
 <ed95d6e3da7b2a27a27837f19ca39980037eb28d.camel@hammerspace.com>
 <C7FE1DB9-576A-4463-81BF-E7B1EC266E4F@oracle.com>
 <8723e01c577e257c399e8d3b6e20bca6320964c3.camel@hammerspace.com>
From:   dai.ngo@oracle.com
In-Reply-To: <8723e01c577e257c399e8d3b6e20bca6320964c3.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::14) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SA1PR10MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af6ed6c-dc25-4990-45d1-08db3f8df3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 69NvXPMnjhEYTJlsGsD9K4ZYEpH4Jjx156nW6O/lppVQTFnriL9TEavyZAMuaMcZAht/dCid0K/ymfVmegKC/J+9NTVgLyH4ShSdX1HdTn+8x6b78U/GOdRBQhNIcoYydTrRuvePgSVWnzqHBDDKNchO3KYr+DJkipZIAuPpXQo5k/3x9onh+PVaPT6fB8SoKSj/RTBUawGcyWJURFxVk5djmdU4JqPdAurOVixKwIzF51xelIcX/DLGVpz6LDnpw2W/XPwkD2Q+z2Zfc/nZK4pLkWpBjYwdFKgQaQPNv54SWJJmTWwWnHrcEaq6tIHN2xa0uoQ1tmW38fKPGvowBsFW+uhGphgY18omS746pTScDqBkWdQMM6lxLtqGvvmj8MO9EIPx0UKa3abmXHSZmvgksyATiPMlrcRSUvu5PMqA+uvPN7xxOowc2FSL3rgggYkSN3Ub8KrAq+imatMtBCqUC1+PbAK6a3JGQ6TowHdHikgI6oQJx+AZkWrN6SybD6apicDqAXF+sCQQ81Ue76bABSbND4BQF8W4tkSeF/yGqvq+ohmVY/vgmkKhHtjAjlcMqlk4RcApixhRxdDNPteKS/cBIaa+NSabec38YKYEmX/UuixINYUlSN7vQZI+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199021)(478600001)(38100700002)(8936002)(8676002)(316002)(41300700001)(4326008)(66476007)(66556008)(66946007)(54906003)(110136005)(186003)(2906002)(53546011)(9686003)(36756003)(6506007)(26005)(6512007)(83380400001)(86362001)(31696002)(31686004)(2616005)(5660300002)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU5kdktwdTJUZ3pKUllKRGpFSm00MHYxNjhRbit1SGJHcFN4aWVMR3dnOWFQ?=
 =?utf-8?B?bDlqQ1VXS3ZRN2NIcVNKcFNVUTloQXJNbFkxZVY4VUJkTzhTVGVXb1VQNTFF?=
 =?utf-8?B?amt0R0g3Y2thb3RlMmFmeTF3VFlOVDlKMTNTR3F1YnAya3MyM0E2WlBYa1F1?=
 =?utf-8?B?eHgraGJuODZ4dE1XRWE5dkVFeVEvd3U5TTgwMjFEamN2MWt1K1pmekUvNTZx?=
 =?utf-8?B?dmp0LzI1T2oxNENURjhxaDI0N2lyakZ0b011Q1YwOTZlZ1dEYWlPWG1CaVhz?=
 =?utf-8?B?dU1WN3RnK2lPbllCYVZwdE1hWDE4Ym5Ga1RkVk9mc25WMU9XTFVTczdCUlVh?=
 =?utf-8?B?TFZwREEwTkpjNUdqTjlmakY2UCtKQmFBb2d2c0VjZEttVWVKU09DajIxeEhs?=
 =?utf-8?B?c0JtcGQwUTFqTVVsL20rdzQ1aVczZVRhRzVSSktJZGFyMlZnYUFIcS9LMmhI?=
 =?utf-8?B?U3dEQ0xvNTNUY0tzQ0FFdTBHRWl6US9zOUtaWFNhYWxvUVdXTXRQZ0UvaFhH?=
 =?utf-8?B?SFBVczVkZFpUOEVtTDYxaVBtekl0NzVlZHdWVk9qbzJheFpsY2ZoY2FtUW0z?=
 =?utf-8?B?YWZ3cFFLbHRIam9iUXhTZXdDUm5HbmxXSUdSMUxCWE8xQVVpL3NrT05PWGRB?=
 =?utf-8?B?SkVUUDlNN3FSK0lsTWVqL2hNRzF5OFpRSzRBZ1hTd1FsbHJiaGhqNDNrbmxK?=
 =?utf-8?B?N2ZNdUhEMlpYY0piOStXRk1ZMW1Kb3d0dlpUVnZYRDB2azdzVTVZai9Lam1L?=
 =?utf-8?B?VlIyVWZrUFE0L2c1cSt4ay9xKy9zWDlmcXZTczY3R0piZXg0Qmp2SHBaK1l4?=
 =?utf-8?B?dnVtWThNTUNoRU1vSUg4QUFJcWxXc1BHUkhscHJuYmdWR2hrZVhQK3Y5YnFY?=
 =?utf-8?B?VWt5UVdiazgvV1NIWldMTjllYysybGxXamhxWkhCdXRFZUlMV3U4VEdVaVl4?=
 =?utf-8?B?V3VpaGlqVktnRytxSzVrV1JBeDV0OHMwbXQzUElaUlljTWlpK00wOGZNVWsr?=
 =?utf-8?B?blNmZDExMFhVK1RYUEMyVjhOL2g0TVVYSm03ZDRJbmlBcjRNZ0IrdzROYlNy?=
 =?utf-8?B?emRtek1kMnQ2cW13SlNucjdnQm5URjRXWER2YURVdUQ4SGpBOTFYZHhQeDBy?=
 =?utf-8?B?TnYwOTBOMlVFNkFXN2V1ZW5DVk96SGZuK3gva2hZaVdPdElkR3VubEkreHdQ?=
 =?utf-8?B?Z3hsd25uRHByM1JSbitxVjhyVWI0Y3NlbXhBVGtpWlgwSURLemVjVXYrV0xB?=
 =?utf-8?B?WUxveWZXK3VzSlBYUVRDSHlGMDRJSmRtQ2tidEJQUkdONFBtZVhZamhsNUlL?=
 =?utf-8?B?YW5obGJ2ZDVqb05FRWNMRnE2aTVPci81RGt2Y2NNWGFBRjFNNmMzRkE4MGJs?=
 =?utf-8?B?eXZZQzBPdi9NTTRMVHVOU1FxS3BSKzRhVDRDTnVkaUZ3TlFlUEhJdm1UcnVV?=
 =?utf-8?B?dS96NWg3TC9mdHlnMW5jMFQwWnZGTzhZYlI1OGprKzNTRDU5VW12UWdCeU5T?=
 =?utf-8?B?YndSR1l1RUtjU0QzaTZkRzNrQkJTbGUxeXZsS3p6Wnh2WHB6N2NMdDBiN2Nj?=
 =?utf-8?B?RjdJNXZBcjRtd1VXbWYwdnlKUnA3RXoxTytFaTBzTmVPY1dWSUkxc3B5SDcy?=
 =?utf-8?B?MHpEMzhabVExb1A4UlNTTzBuazh4TmZCS1c5c04xU2wzKzZLOGZKd0Jhb2pZ?=
 =?utf-8?B?NzNlTG81ZjEwTWN6SnBUV3VhakZ3ZzZHNUJoSU1uMXY4djRnSzBvbVFhNVB5?=
 =?utf-8?B?ZHFJOVJtOVZpTWRPV3ZMODhXRlM0aksyVTI3ZlpuWDJLL3kwNklWU0pqUHMv?=
 =?utf-8?B?dFVKZlY2ZGxnR091WElJdHJhdTJyUkEzUFRnc3RHME1Ld25XNUt4eEI1Y0pB?=
 =?utf-8?B?SkZidHBCWnBxeTR5SSt5ejFIMW8rdFErRlQ2T0pjd045RGZPdEZlcTBLMEw4?=
 =?utf-8?B?M1lsNDk2enExZHZ6K1Y2SFlUNzNrNm8wWHB3aGxBYmhkL3liZ1JzRTNKVERk?=
 =?utf-8?B?RU9QRy9tU1NEaVF1TEVxVS9nemNBRnZ5dTRGU2hKM2lSb2Zhem15SGlYaUdU?=
 =?utf-8?B?djNBRWJUL3pjbkJtZm43bkY4cnVKd3VKWXVJUUVQNytDWU13aGdQMFBUMWl0?=
 =?utf-8?Q?dajjvl61q9o3kt4wmiVEKuSdh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RHizJosRAgris1YTifJmLmA+7csmoHq2DdNHRSEePl5VSyjUWpShuciDmuvgoLPJU37MPjSwWE4lnkWnWc8IIwIxhz9zKi4C1cNSlA0AKErTYMMHnxkm9Y52LwW+9ESmSBOD28TrHUUsg+Lyd73BYlFVAu02deHd7bAoNqQsaeDfQFFQNcVccp1aTn8sD9oBBqOvFsvdl9T/5NUCw98HjbdoRi7T8gZp4v6OfuzOJf925h2JVVfxo1G3pm7qoz5P0RNqiqGXgLfGlxza4yvRyWVVWBdiVgn/WTzsslV+eKkAl8pmfeoXSVEdMgf0oLKTB5RavAtfNMUpqQOh2tk+ktFdOF6k83p1suytEHHDhy1Pxg6hW/P7+fClswvVhF9BT41CgWKTOVvf51G/GC83pf8S6z6/HxFRxAkVstqcLVs4SOkcPdvgm9E10lpxHCN1Ms0Pz1bQADJbY0DVxwPO1WRtkx+T/CKqQRn0kDzl+W7JeKIeB3GJccBFdmcUUb4lcVj4MvqUMfpPa0CtlzkdjlQlOTLtVGdBmS6oZVklqP0rSmgdESz7S69WT6ZwsV1r8RQPtVYgM7HjGiaz9djsg6j92mDStQKmPpYz3h4D+R8PbsST4wvzX3XuqxbpCjquOvh6HTMSZmbEar0+8aWzNhi5oCgifEyrVe0KsS6D5+W8yym6C2TThFi+BmOWEPea+HAKbrxgZWflxX8ynH0qigr/mQ3mWjenkchng/TzNoTcjKvJCcnwNxDqsGE3pqVtYKdfyS9Rr18Dnny5VnWk1dI+mA3XUmDg+ifSIvQNBe0lR5oO+Njq4mbcI+n9mlJHSvicniFqwX0z9zt3GKxg4Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af6ed6c-dc25-4990-45d1-08db3f8df3ee
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 21:51:52.0622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNvTvKuOL39QLhDvNOYwCEsRC7mskF3A7UEqE03ajw02CbU+UIeiKjjWSA5EA08wGx4q5WIwpL/aAMIHdITvQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304170193
X-Proofpoint-ORIG-GUID: ONFT6uVfsX08yd3i16UsYih2WK1rJSmX
X-Proofpoint-GUID: ONFT6uVfsX08yd3i16UsYih2WK1rJSmX
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/17/23 2:48 PM, Trond Myklebust wrote:
> On Mon, 2023-04-17 at 21:41 +0000, Chuck Lever III wrote:
>>
>>> On Apr 17, 2023, at 4:49 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>
>>> On Fri, 2023-04-07 at 20:30 -0700, Dai Ngo wrote:
>>>> Currently call_bind_status places a hard limit of 9 seconds for
>>>> retries
>>>> on EACCES error. This limit was done to prevent the RPC request
>>>> from
>>>> being retried forever if the remote server has problem and never
>>>> comes
>>>> up
>>>>
>>>> However this 9 seconds timeout is too short, comparing to other
>>>> RPC
>>>> timeouts which are generally in minutes. This causes intermittent
>>>> failure
>>>> with EIO on the client side when there are lots of NLM activity
>>>> and
>>>> the
>>>> NFS server is restarted.
>>>>
>>>> Instead of removing the max timeout for retry and relying on the
>>>> RPC
>>>> timeout mechanism to handle the retry, which can lead to the RPC
>>>> being
>>>> retried forever if the remote NLM service fails to come up. This
>>>> patch
>>>> simply increases the max timeout of call_bind_status from 9 to 90
>>>> seconds
>>>> which should allow enough time for NLM to register after a
>>>> restart,
>>>> and
>>>> not retrying forever if there is real problem with the remote
>>>> system.
>>>>
>>>> Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock
>>>> requests")
>>>> Reported-by: Helen Chao <helen.chao@oracle.com>
>>>> Tested-by: Helen Chao <helen.chao@oracle.com>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>   include/linux/sunrpc/clnt.h  | 3 +++
>>>>   include/linux/sunrpc/sched.h | 4 ++--
>>>>   net/sunrpc/clnt.c            | 2 +-
>>>>   net/sunrpc/sched.c           | 3 ++-
>>>>   4 files changed, 8 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/include/linux/sunrpc/clnt.h
>>>> b/include/linux/sunrpc/clnt.h
>>>> index 770ef2cb5775..81afc5ea2665 100644
>>>> --- a/include/linux/sunrpc/clnt.h
>>>> +++ b/include/linux/sunrpc/clnt.h
>>>> @@ -162,6 +162,9 @@ struct rpc_add_xprt_test {
>>>>   #define RPC_CLNT_CREATE_REUSEPORT      (1UL << 11)
>>>>   #define RPC_CLNT_CREATE_CONNECTED      (1UL << 12)
>>>>   
>>>> +#define        RPC_CLNT_REBIND_DELAY           3
>>>> +#define        RPC_CLNT_REBIND_MAX_TIMEOUT     90
>>>> +
>>>>   struct rpc_clnt *rpc_create(struct rpc_create_args *args);
>>>>   struct rpc_clnt        *rpc_bind_new_program(struct rpc_clnt *,
>>>>                                  const struct rpc_program *, u32);
>>>> diff --git a/include/linux/sunrpc/sched.h
>>>> b/include/linux/sunrpc/sched.h
>>>> index b8ca3ecaf8d7..e9dc142f10bb 100644
>>>> --- a/include/linux/sunrpc/sched.h
>>>> +++ b/include/linux/sunrpc/sched.h
>>>> @@ -90,8 +90,8 @@ struct rpc_task {
>>>>   #endif
>>>>          unsigned char           tk_priority : 2,/* Task priority
>>>> */
>>>>                                  tk_garb_retry : 2,
>>>> -                               tk_cred_retry : 2,
>>>> -                               tk_rebind_retry : 2;
>>>> +                               tk_cred_retry : 2;
>>>> +       unsigned char           tk_rebind_retry;
>>>>   };
>>>>   
>>>>   typedef void                   (*rpc_action)(struct rpc_task *);
>>>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>>>> index fd7e1c630493..222578af6b01 100644
>>>> --- a/net/sunrpc/clnt.c
>>>> +++ b/net/sunrpc/clnt.c
>>>> @@ -2053,7 +2053,7 @@ call_bind_status(struct rpc_task *task)
>>>>                  if (task->tk_rebind_retry == 0)
>>>>                          break;
>>>>                  task->tk_rebind_retry--;
>>>> -               rpc_delay(task, 3*HZ);
>>>> +               rpc_delay(task, RPC_CLNT_REBIND_DELAY * HZ);
>>>>                  goto retry_timeout;
>>>>          case -ENOBUFS:
>>>>                  rpc_delay(task, HZ >> 2);
>>>> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
>>>> index be587a308e05..5c18a35752aa 100644
>>>> --- a/net/sunrpc/sched.c
>>>> +++ b/net/sunrpc/sched.c
>>>> @@ -817,7 +817,8 @@ rpc_init_task_statistics(struct rpc_task
>>>> *task)
>>>>          /* Initialize retry counters */
>>>>          task->tk_garb_retry = 2;
>>>>          task->tk_cred_retry = 2;
>>>> -       task->tk_rebind_retry = 2;
>>>> +       task->tk_rebind_retry = RPC_CLNT_REBIND_MAX_TIMEOUT /
>>>> +                                       RPC_CLNT_REBIND_DELAY;
>>> Why not just implement an exponential back off? If the server is
>>> slow
>>> to come up, then pounding the rpcbind service every 3 seconds isn't
>>> going to help.
>> Exponential backoff has the disadvantage that once we've gotten
>> to the longer retry times, it's easy for a client to wait quite
>> some time before it notices the rebind service is available.
>>
>> But I have to wonder if retrying every 3 seconds is useful if
>> the request is going over TCP.
>>
> The problem isn't reliability: this is handling a case where we _are_
> getting a reply from the server, just not one we wanted. EACCES here
> means that the rpcbind server didn't return a valid entry for the
> service we requested, presumably because the service hasn't been
> registered yet.

That's correct.

>
> So yes, an exponential back off is appropriate here.

I think Chuck's point is still valid. It makes the client a little more
responsive; does not have to wait that long, and the overhead of a RPC
request every 3 seconds is not that significant.

-Dai

>
