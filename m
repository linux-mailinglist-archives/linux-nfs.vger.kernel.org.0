Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B9C6D6ABE
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Apr 2023 19:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbjDDRha (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Apr 2023 13:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbjDDRh3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Apr 2023 13:37:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099414C06
        for <linux-nfs@vger.kernel.org>; Tue,  4 Apr 2023 10:37:11 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334Dwqvc004137;
        Tue, 4 Apr 2023 17:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : subject : to : references : from : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=oarIs00OSyvtzKNNN6JGWpW82DO6TrCnvivGc/dx+Wo=;
 b=1oBemnFIA72b346Rwbfrp3V06yTzT3t8htuoABlwLIMSfGyNeFziPFlHKGaDOQcD2h0R
 oKKD3BepgK4DlsMJPjBxPN48X0dQUvIQnXn1gP336KcrPlxB28030kPE+ONjAbhQxqOf
 pOWQwQCCsv5SvWih3mR2JibHgkj1FGQIXNEFFLK/l/uaFWY656MbX6u1a8BkrXwg39+o
 yaKM9CuWFRmkzPqz9aYg5VcTOs68VvmWjBPuNFy6/f0z3xlTGA1LcKM7v9jUaor4QduH
 JMMfX59tsVbcK3zpkqndIaPTIeOD3wm+D9gLsMsL9d0/9EAcixMVWrWxwbTIDxwHrvtj PA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcncxfmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 17:36:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 334HHCwh017868;
        Tue, 4 Apr 2023 17:36:45 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptp7fawb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 17:36:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gp7xGFZgczGNhCn5+DOBoz2KYyDBnvqbbub53UHkgWebS8EiyEe/dr7CPnwMhENtma+busu3e8rIonulddsbshKAFQ4B1QWNYFiaWCPAnbhQg1LMGKsyRUm2BXZoI8NZh0BTBtC7Oezd66vLclhLUvlKHa2WGCZoE2yGfevWoMIe/Ep/s/sW+jl4Ss+x8fAA3jkz2paJV78UBwGEw8gC1OQE8f6qmg5gXXxY/vcRiInfIquSlYi6BfbPe+uv36OAYNq16e8gYtRyTTkj4m52ny15i70pz87wLiqA6GPfjye64FW5Q0XZFLV8LRrj6TSCmiXj7XEIir1KTcGd+jDH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oarIs00OSyvtzKNNN6JGWpW82DO6TrCnvivGc/dx+Wo=;
 b=dMtyhaZegre6K/LEy/TLcr3YUJw525U8+amQ9Y3cLcWqW3EcrKcVTFmKtnKF/gTs3fDUjxnY6wUvzoi1/gkIus6KDJTV3d1dKNs+LKqg7BW7O5Yrq1R3qTTt/HGsGvaiWhr9KuH6V3wCCKfLyGy7z7p2KerC/NDs17xwGJTuRHP650LoOpOMfHXiZwBafnzEE+r5hcK9vnibwsxyi6xl3W6o1Bsv0nYv/UZI5CXSHqGoXcrt2I7XsQg6FYL9xpANiurltWDdhwzNdCvaXeBZOGThB6Zeh1XzQMFMWIU/mhxOXQL3/Xng1rnQDnJDFQmfmww8BOpQ4Kmy+uMa/jzLwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oarIs00OSyvtzKNNN6JGWpW82DO6TrCnvivGc/dx+Wo=;
 b=B/Vp36G/c3fU0XKZgBJIcEU6JqJPTe1TMzn7A3Z06PSFn7XRAIuHF+fAY4xTOmdmj9bkgd/ncEVJ/V7UkYqDAd5VJIqn0HEpz2r/zygXQsyVjavZCwcXzAcsBEmo0LLI27SgMgOvFabek9XzPsSkHqPEbZZEoTw5OlJH9gGooe4=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by DM6PR10MB4218.namprd10.prod.outlook.com (2603:10b6:5:222::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Tue, 4 Apr
 2023 17:36:43 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::effd:a3fc:9fdc:a534]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::effd:a3fc:9fdc:a534%5]) with mapi id 15.20.6254.030; Tue, 4 Apr 2023
 17:36:42 +0000
Message-ID: <0625ee6b-f705-a686-fc91-c415a1dd8900@oracle.com>
Date:   Tue, 4 Apr 2023 18:36:37 +0100
User-Agent: Thunderbird Daily
Cc:     Calum Mackay <calum.mackay@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [pynfs] Re: new git area on linux-nfs.org
Content-Language: en-GB
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
References: <821349f1-0648-8e4c-44e0-cfe856b81b1e@oracle.com>
From:   Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 gx3r8uLHNg==
Organization: Oracle
In-Reply-To: <821349f1-0648-8e4c-44e0-cfe856b81b1e@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Dk0pqzHY4Pd0qW7yHephs7CB"
X-ClientProxiedBy: LO4P123CA0214.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::21) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|DM6PR10MB4218:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f7e13c-ca70-4180-dc5d-08db35332778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rsniObcTi50lY82N/qfYkMNqNppUCEMDxe3KiN0Ai4Wjg/2WS0clLw+yFF7prZN7P0M0xEBbtoNvk93CJGNfv+H8D+/D4nwNd0WT6QLgCErjDCjeb1q0A982cAVSARYGg/zle42idQBRX363lRBPCDSGpGjnMJZoNsi7q+gOw0hPHIx5YwrXWzb86SIFZuoqYJNKYCRthgdhnz8lsvQohaWRPqFKn+0Ixu0IQC7O+nAulpVzHBLZMLOa2Nypc2oyhSDxAd/wfOj8dFePdVWUQhizjcdfTiKUW7Li4B7cL8T3sIzSKzcztadx1ltwFRLZNwNqgML9Hv7E2m4pH0XW98nrwr7PqEhjr/Fao7Z/Wd1H8EIKRALiRzZPJ/EGq91HAyu4vKFQAhWJIbv7mVOPZLiKPvmPP+0AihpJQ/SFDQBgriu+5hUByPo5JXqXQSuyctIXSfUXjlrJfWrfmeZxbJeTaVO6lfk7i4knuQbbL2HGLsrWB2TZ+AAotrx0GAcKNZEpIdWPXehbdO/MYDNm5+BugHNpcqB4/ldOzf236UG7BT4xkbzrVQhvVqenlyJmJJnCDaazt22+LPblCO7BYJAR2i4c1vw8W404X+3vsJBpxo7oPoQ3iR7aqgfC2y5fFyxHc3bC+V7vQxLPDsOJag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199021)(33964004)(478600001)(4326008)(66476007)(66556008)(21480400003)(66946007)(110136005)(54906003)(8936002)(235185007)(8676002)(316002)(38100700002)(41300700001)(44832011)(5660300002)(6512007)(2616005)(186003)(6486002)(53546011)(83380400001)(6506007)(26005)(6666004)(36916002)(31696002)(86362001)(36756003)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1hVZHFBQ3dHVXFUa3AyOWh6QjBobkhCTy9hais1eU9CNE1WeThudUdvRGRu?=
 =?utf-8?B?cVBUd2pDOUJWdFJzQnBHamNVcTFjSDFjbzJNTVllYzBVMUdMTTFQMmdNMmNy?=
 =?utf-8?B?RHJ2cWRQZkJ6TWpkUWowRmtJTXZkSFhsekp5ejI2OEplRHF1WU5YMFZvcFBO?=
 =?utf-8?B?aTVQQWlLbUhUQUc3VXBDMElQUEVOVTFGbXB4S3pDRG1GdUd0eTRyUkxZWFR1?=
 =?utf-8?B?Q3Z2eXd0ZlZNWFQwWHhMWWFRazV0YWR5Y2lUVlJLRUZMSW92SUZPeHlvbk5Z?=
 =?utf-8?B?NERkMVc5MzFmRExNakpyMG9tTFFMYlZUUzR2ZElRL0IyT1ZISU5PSUdndlpB?=
 =?utf-8?B?eXBOS0lqMzJRL2pJcllPYUdFS1JSTkdDZnp3dDZuOGZ0bWpNeGFyaHhUSjdK?=
 =?utf-8?B?bXRaV3NMSENmZDU2elNEY3o5QlpIbnFNLzd0UWk5WTNxcU1xK2wwZkhXTTBk?=
 =?utf-8?B?T1pCNmo3UDNNUHo3eW1uVTM1WXoxc2YvMnplYmpacVdCVU51Rm5BdFNMQUMv?=
 =?utf-8?B?WmhiaHF6S3V5dk9ZaUxxakZ6ZHZ2MHk1Q1lDU3pXUTlHYjBMYjhpTURLWldl?=
 =?utf-8?B?VVVXYWpqMnhzUU16NXlIU0U4dXc4M1pDdkRqeFdobDM0UFRrampKK01DT2kw?=
 =?utf-8?B?UHFoSWJRaUZOaTdSbVBQOXU4QmxNNjRpd3N1N21QRlZzcGd5UEora2t6V1Q4?=
 =?utf-8?B?UWQ5VytTWDcrRnZzWkYyd0RCczNqWldJcDF6dzdRS2R0VzBCZXlXcTVXYnBs?=
 =?utf-8?B?clV3V1JBakh0SnNNZTN2SzZzTW5uVDdBbEUxUEhSb0hhWkxsSmJJNkNtZlh3?=
 =?utf-8?B?RXdXMXdqaHlTUUVIRTZQcFJFWVphOHF2YmlpeEZkRHNVR3RkS0lsbDhqSHZx?=
 =?utf-8?B?a3dsSHJaVWM1WTV4akNnSUZCT1JwQ1dPYW13OWROZHk3Rm1qYzd2UXl3anc5?=
 =?utf-8?B?UFAvdjJ0STRCVFZtT1Mvd1hCTkxadzM5N0ZjZEl5RHJkRk1xQlkwcEhyK0tH?=
 =?utf-8?B?dnVNVG5adjVST3E1THFSY0dzV3N4eEM2bnkrTkJka0lMbWJmQ0h4OFNPaCtM?=
 =?utf-8?B?dzlGeDZSd1hzSWJYWjBRcy8vYk9QRnRMRTNxQnV2cWtyRzczVUtkNHRma3lw?=
 =?utf-8?B?V25qd1ZoeE1VcXprS1ZWbkc4THkzWEVZWCtjMXlMaVVDRUxJWmY2c2FnY1VK?=
 =?utf-8?B?Qm1CVWxaYnY0V05zcUhUSmdWS1RlaStoYzAxeUthR2oxYWFTeDkzdzIzQ2U5?=
 =?utf-8?B?OVdPNjU1dnljOU1JV1FaTWFCblYwZVBkd0hnOGluV2VOZU5kbS9PZ0JhMGRv?=
 =?utf-8?B?L0VScDRSeGZqOHE0SDVLN21kaHNKeHhUOEFXSkwvaXQxNVhudE1EQWNyUGVW?=
 =?utf-8?B?UkNvOWc1WXU5dm55YVBmUFFPWlFWYXZrdklhRWdtMWVSTWpCazhXRFY1UzBD?=
 =?utf-8?B?YnVrK04rYzlnOEZ4c1BUcFAybXphUkJ6aEpBSVdSRVk3aU8zZDJ5RTJROStQ?=
 =?utf-8?B?ekdBdUNhUVdBeTgwWnJmRGRSY3VJeUg0azBUZmZTb1oyOUZocTh1Tmw2QWVU?=
 =?utf-8?B?M2lXaFJtbkpQZHlaR2liNXk1elRocnZjV3R1Q1ZTSzRBY1g4cHZVQVBBekZY?=
 =?utf-8?B?VUdNKzVZK0JhREc4UmdXbzBLZmFFeStLU3E2MjlQcG5jenZzYUxkMlRDdm83?=
 =?utf-8?B?THViL0pxaFMwcVJnemp0bHJuaWFwNkNTTVBHYXJ1ZkQvS2J1L1ZDYTN6NVQ3?=
 =?utf-8?B?bmUyVVIrOW1OK1d2WGg2cjFFeE9TaUN3S3VZMmlPZ3lpVHBlSzFnVWpWRXpo?=
 =?utf-8?B?U2pZMlRZejZCSGNzdm5wSUk3dFlsMEVqeE1na0EyczNRc0owN0Z6OGdtQTRt?=
 =?utf-8?B?dlB6a1grcE0vZ0t3eVhkMk9OUit0bm83eG81QzlIUm1mYURBSTdkNkZLdGVC?=
 =?utf-8?B?T3laUktIYzBpekdRWmo3VGN3MnB0cTZEeVRZRVNURHFXdGUwbEVpUnczQkJy?=
 =?utf-8?B?Qjd0RVNGdkFwV2xRQk9LblRhRzhRcktkN3hNR0wwb05OT1lvTExlK1hOaVVm?=
 =?utf-8?B?YU9zbHJLSWRPSHFKRWFEa1lqd010dUYwVS9CRDdFd0JaOFZzb1VIRUdtT1U0?=
 =?utf-8?B?K08yS2JwbTR6NlZHVEZGa0dRR3JnUDVqTm5uMXZpY0pOQ1NpSnF3VnZVbTY0?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 944lq7MB52kP90qGVyNLpRyVRhzwrUDDrpQp+mIYEnMsCMbqZlRZw1rwP2EPFCmUKKZS3KJ4GYWu4hB/lM36qhUn43aJ1PTdxNP1Ko8pwTNiHp7vv+zP0NO0ggciTCzktW9wX79rDJyz8rltec/M3x079W6zms0/mW/lFwZyczbsuMcl0zejx84ZzE5f6SX7E1cq5H6OT56HrVThXEv4piWGYHWFaTyUWVwzRzBMFG06FDBpG7Yac0uIL+rQXKnOXlWrABTv+rOe6iPwGHSBEAL0l+SZEQ2LtgwT5EN2sVy8hJrCD03fQk/SqdlvX5qBiuHoKOt3IhZzKLL7o+WcOA7uFRGuKfvU+tRV1ec7KGO5pvBLq6ggTQ5Cy8clOawmY4u99MOQAqf1OJoLgBCI4GscD3pt5gJI0UhlQvMtrWPH/NGTGz3Xek0fcadT7YsEwiqg+APTZTpdD4zz15K+mQaEQqgyvaJLlNoGvX8feSrznvtUO95mj9gPd4mTvXcSkFRJiQ2FJQDJoKovUV2gmF6KID+0rmT/zbJq2iEroEgP6m7YIQUSNTbb70fhZypd9z1ddalxBIvW7TV5J/aV4a2S5aJ44B0j+wzkvurmDLq9auZaBc5jpxfo77kjLIUejSYNmiIOdqHsb3jPh/1UZWbIzLSvWdc1WJJmq5vEkyjoPMnf8A/Hfeaw3Q60H154XW/3C7xpmec4zzjdtecKELkhJv8hCKFSwGYeQCU1fmpWDik6De9ctU2mvmjX1CkNTTmSF3w0Anj5fMmed0jIQtNGzNoevrMkBTYqo6XkIFAjlw6tUICrgV+ediqIt1FDX0f9BCXYzZZgVKuAZtHEzbfncx1ZFfhf3zT+xUMAgV/iWncKZgjkYUVnfp0tOFyKgol090hOlMpOjBdeZ30g3Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f7e13c-ca70-4180-dc5d-08db35332778
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 17:36:42.7670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irRn2A2kKY9T70O0cUjo+D3drF9A7gO3e/hkgEFf9AT3xcl2w0x9qRud8mnH+wHJY8C1sivDk8HhpKDYqF7w9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4218
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_08,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040162
X-Proofpoint-GUID: gWojeWZkCRAMumg6rybw9SuhHNop4tMC
X-Proofpoint-ORIG-GUID: gWojeWZkCRAMumg6rybw9SuhHNop4tMC
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------Dk0pqzHY4Pd0qW7yHephs7CB
Content-Type: multipart/mixed; boundary="------------sO8oXppJSawn9BZOWsnTTT0m";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>,
 Anna Schumaker <anna.schumaker@netapp.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, "J. Bruce Fields"
 <bfields@fieldses.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <0625ee6b-f705-a686-fc91-c415a1dd8900@oracle.com>
Subject: [pynfs] Re: new git area on linux-nfs.org
References: <821349f1-0648-8e4c-44e0-cfe856b81b1e@oracle.com>
In-Reply-To: <821349f1-0648-8e4c-44e0-cfe856b81b1e@oracle.com>

--------------sO8oXppJSawn9BZOWsnTTT0m
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

aGkgQW5uYSwgVHJvbmQsDQoNCkkndmUgbm90IGhlYXJkIGFueXRoaW5nIGJhY2sgb24gdGhp
czsgaXMgdGhpcyBzb21ldGhpbmcgeW91J2QgYmUgd2lsbGluZyANCnRvIGRvIGZvciBtZSwg
cGxlYXNlPw0KDQpJIGhhdmUgYSBudW1iZXIgb2YgcHluZnMgcGF0Y2hlcyBzdGFja2luZyB1
cCwgc28gaXQgd291bGQgYmUgbmljZSB0byBnZXQgDQpzb21ldGhpbmcgb3JnYW5pc2VkLg0K
DQp0aGFua3MgdmVyeSBtdWNoIGluZGVlZC4NCg0KY2hlZXJzLA0KY2FsdW0uDQoNCg0KT24g
MTAvMDMvMjAyMyA0OjQ4IHBtLCBDYWx1bSBNYWNrYXkgd3JvdGU6DQo+IGhpIFRyb25kLCBp
cyB0aGVyZSBhbnkgY2hhbmNlIG9mIHRoaXMsIHBsZWFzZT8NCj4gDQo+ID09PQ0KPiANCj4g
V291bGQgeW91IGJlIHdpbGxpbmcgdG8gY3JlYXRlIGFuIGFyZWEgZm9yIG1lIG9uIGdpdC5s
aW51eC1uZnMub3JnLCBwbGVhc2U/DQo+IA0KPiBJJ20gdGFraW5nIG92ZXIgbWFpbnRhaW5p
bmcgcHluZnMgZnJvbSBCcnVjZSwgYW5kIHRob3VnaHQgaXQgd2FzIGEgDQo+IHNlbnNpYmxl
IHBsYWNlIGZvciB0aGUgcmVwbyB0byByZW1haW4sIGFsYmVpdCB1bmRlciBtZS4NCj4gDQo+
IHRoYW5rcyB2ZXJ5IG11Y2ggaW5kZWVkLA0KPiANCj4gY2hlZXJzLA0KPiBjYWx1bS4NCg0K


--------------sO8oXppJSawn9BZOWsnTTT0m--

--------------Dk0pqzHY4Pd0qW7yHephs7CB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmQsYCUFAwAAAAAACgkQhSPvAG3BU+JB
OxAAxMveuin+0C7FNqpQkHhKEjU6YgfUXOpJJvwwlcJeVqRa6u8BFis1rQSD2jr4AAQWBUSF9BIE
IZdR32GaoePYw4OCdTN0Sd4bpXhgMG1M4VYq8LDzj7vz2lYmH4eaxjk1yhbiSvMZ3/wLRYjVK2oP
W2qMx0znwaHTZ9J3r9rN4+q6jTgUyJYKMuXnrozfXRP+1wYn5TuFbnbpC19tLZFIC4KgR7UZDt8C
tHOkPGGHw20xvVi8yYzdaisyUz4KTBMwpbOJcBy0I2bgr76trEc/ZVllBX0CaBDH+ajulpTEF/bk
VLN7R4wSleGyLALFL5/6qAm7HTKwGcNrgI7KtVTMSqIQgUjB2guWtuXR4DyupJE6yBP+V5TeBFlq
v/raHMyCYay5dfLIlNqh/M0/xcE3uUfTUvluvgr+xMJkQO8o+tv0oxl5ssWpAScsGw5kJcvFgE5M
w2Br8q4K4UV8Of7peKqlq4aQxOznlia4tVxfDlfmh9yE0fdeYrcsM3QJwELsUicrRWYSwK3oY5RH
5EvH88OEenC16V4EVSCndHqEyYXd+AYMWrkShA1uHEP1cVwWPOBbKbkzTD/ZnAmUHSv/4t3YmR0x
rjQT6tjr6PudcXqrO/ESMhq/4WR1SnWPyr/UfTryXBawfCyhgOHwWe6/P2pKwyyJEZ8B2zPJrr0L
UV0=
=XOgr
-----END PGP SIGNATURE-----

--------------Dk0pqzHY4Pd0qW7yHephs7CB--
