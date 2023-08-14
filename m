Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE3F77C039
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Aug 2023 21:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjHNTAh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Aug 2023 15:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjHNTAI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Aug 2023 15:00:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B71410FB;
        Mon, 14 Aug 2023 12:00:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EGTqkJ027893;
        Mon, 14 Aug 2023 18:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=vN7s1kGQR1FEBMFjAnaKv3TTB40+JIm1oiIb4T1/bC0=;
 b=3zGXUFUjkvgJUrDJXID9Q4+gVvmYdy3GPAAwgXSEa2myYyeHDAdbWUtEc3voFEWa69qd
 X86D5u0SXiTnqc6IBdiye/179HNqa6Y7zKRBQ4o3pwI+Di8o+wr1I73/dF/fZz4hv382
 ThMh12d8jO47+4pgkhkpDGRHlQ1UVTxHAZ/qA4MD42JTM8U/3wEal+5DPVwpcLzJXuJP
 H5H6k4aLYBOcTfGO70OlUzeDvNJ2UgRdE6zIzK3gY48p2rupNxHzF5Q2LtyxJm6R5jmU
 S7r/hz61IoVE6igj1pSAaezwqN2V/wivMqUydxhlAPbwa86gSItfOUOTOFFmvfEFyh5Y jA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2y2uccv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 18:59:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EIWChg019766;
        Mon, 14 Aug 2023 18:59:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3uh84t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 18:59:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBWj/hgNnXXa/oQb97OPwYtkAzpvMHLx56kfDGHEuXede64lG+1Z5PIsgkxqs4PQd9oQiPj1bjXAA0wDxaFYEHChRrpZncdOm2L9YAiXL7yIPEpj+cCx0pi+g6E/a25tuwbfkpMI3JRyHtBD/77xOYhtejS+93RSUinAcmAxPRtIGo+/Nt/U0BG4JKffefw3vQVQzBFNKqQVXhXtILr6TyjlXag4wsDiogE7sY1LK11wZVlWiRhavU8vuNASbeXLbW/rb5CwxQ+fNp87gebaJv9W2zxDGO0fKAsPZzfHRv8pvuo3Ww4mek5C2v9DgXubdsosEe1RArXK8sNkGkC5ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vN7s1kGQR1FEBMFjAnaKv3TTB40+JIm1oiIb4T1/bC0=;
 b=GtYBOyq4Et2WB29wl4Fxt+NNvUpE/z4TtOruybSM89m2WWpG2AlrS4pzdoLChabZJU+Ln9AVJcqEVTuY7M87P/dIPrjvHxa03hrLuulAFKP1SAYa696C+GPAI9TTuJ8SuxUZEtaamB27955Jsvvac7zn9m8YbSGnGOIHQApsNdsEn4bZ8HFUkgflASObTdeJXRKAA46ws5GAOQz6oWoK3AVwknJ7AbGy5Pst9f9n3+FCU1htyW502sWzXAR3u26FJqhkcgRxcpCti/Tslk10iPBdNOlYJZTtfT//IjKxe7Uge2ZO1qJt+4NSfvFAmLw7ZvFqmos+zt6xIyh5pPiKcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vN7s1kGQR1FEBMFjAnaKv3TTB40+JIm1oiIb4T1/bC0=;
 b=mx7b6rxO1kyfcgH4J1QqFw9p/aqpyP/tJAF9FsuL/pJVRs8C3Do81gTxOlIZheGyNhSx1KUCO3kpEG+c2ltaOpO549Z16TDdYGL3K+SVEhnarBURKK78azF8U5GNTHyS0DrbdDfwYGJqdDkzPHfV+XiaWsaTpmkdaoWX2Uv0bkA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4511.namprd10.prod.outlook.com (2603:10b6:a03:2de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 18:59:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 18:59:46 +0000
Date:   Mon, 14 Aug 2023 14:59:43 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sunrpc: set the bv_offset of first bvec in
 svc_tcp_sendmsg
Message-ID: <ZNp5nzfLGij7O5/k@tissot.1015granger.net>
References: <20230814-sendpage-v2-1-f56d1a25926c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814-sendpage-v2-1-f56d1a25926c@kernel.org>
X-ClientProxiedBy: CH2PR17CA0002.namprd17.prod.outlook.com
 (2603:10b6:610:53::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4511:EE_
X-MS-Office365-Filtering-Correlation-Id: f5297c96-8ca9-4773-6a71-08db9cf8a0aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yoy7crMYWVBYWrzr0vuOj6ayqgNgbrOvxjMUfMRf4XQ5cTqvYQY2G9Fgyp7Rs5mA7xCv9HcqrT6Ss0puH4dLp+nHul0O1Kuv88DztbfdIblkquxJcx5XDxZXfYnTKIVKt5dPeUvrefKps1yP+MxabpYvQFsk+S//NI4CIhSkbck2TLnh0hNhRrZ0vYH8q8mDhUCdfYKo2yWf+v0eHScjxDuGqnecziTDPtF2t8ocXU0OlBnQ+QLWfQ26ZXfy9r9eNoADZDiNaKx/NI7LOJLy/zShexKoiF/R1P54KB342sDUqJ10uWGyZgX0NlgXbyThJyAjyPvMDvGvYd32g0as4DI8O/OosSm1g12DrXg7O55BV6CdGYvf5ACVojNOR2agFvYGTgt1KwX9TcveejaAKQBMIcx6XuWPGBdPNGso/s/8Dby2HO6vMxy3wjxNRwMpjqc/6leuLhvNlll8lUyT74AFSa63D59+74YLDGEDTRCohaOknwJp2hp24ylWwlq0Xc3ppL3LRCjW2cIoayfJJG9f8J/uUucQw7J+G3cJixKLYxnQkE1BNM9ipRx0LCH0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(396003)(39860400002)(376002)(1800799006)(451199021)(186006)(83380400001)(26005)(6506007)(66556008)(66476007)(316002)(4326008)(38100700002)(66946007)(6512007)(6486002)(6666004)(5660300002)(9686003)(41300700001)(8936002)(7416002)(8676002)(44832011)(2906002)(6916009)(86362001)(478600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S5nDKj/M8d1mRwtNQvvRsGcNoIfCTa/tBWewqUSpRCtO0HGhX2zyTrGjP+yQ?=
 =?us-ascii?Q?zuMm96PTH1QwSqivBfpF+AdiGQKQZnpj/UGjf4ccDGd8yu/G7NMITFBAjJCf?=
 =?us-ascii?Q?EseSOqSiqJdBbLqJgLGwb2cQQUz13NLW7aGmqzGFVnhXo24V4Mt6rRtplV1y?=
 =?us-ascii?Q?UixXR+1wC8a4+ubiADCgn9qKMuTzXcniY8rBQeltndWx00Gzyl/j5dhGqLiC?=
 =?us-ascii?Q?ZVVa6yMTtf8RYK+e+Pq0cNt7yNpPgYU39V07v2owq7cy47GYppDs93EqdpO2?=
 =?us-ascii?Q?o6reoiX79Qv1uqnl1OBF31Q9UCpvEWwqhnoYrKs5ldJMBZa2agZZzeYnlw7M?=
 =?us-ascii?Q?mgARWHtO5Bb0x6Wv7wvKMdYv5X12b5gp1ho47aWx2bv9HkGMZ39mMc2Cf0t9?=
 =?us-ascii?Q?e+J6Cm88C9QKwESEz5XBTczqfFR7c4ZtoiflsJDQzRDHaqqJe9OeOl3A1mF4?=
 =?us-ascii?Q?h8sdViARf/4PzEaic3LgYIPRcNtD5ElEuih848YE1YARvADCE90GHI8kMhJM?=
 =?us-ascii?Q?uMzHDPUwIi51XzPYCyIe6VCeMInEiSY9YaIEzqKixHAeWEDXMFqFbgaZGgML?=
 =?us-ascii?Q?/lNyRa0wi5Ys/OysETrw7uJ0P8nkCBt6kn6ubw1H5ldBSDDZ0Sa3kduANdZY?=
 =?us-ascii?Q?5FVLV6YfQeNUg4XvOQozvvmccP4EYalcaTNFs5czf5m5DhRz981zQbjktluQ?=
 =?us-ascii?Q?uhgpm3r6CoEMAb64lsAkvsXiCQr/gt0HurHxkofreka76ss8XVUydQiWHAsF?=
 =?us-ascii?Q?KE4fUnd4DLLYiMTDADlmkvty0EiBMCYVgOL6ogi2seHt4UyZesiBEVmTkU+k?=
 =?us-ascii?Q?s2Wf/GpTIrs9mALNffVHD+wNWZKl1DGzZoQ9pbUWUqvlH46PYGZN/5/kk8VN?=
 =?us-ascii?Q?cvxfqrXDYhfctLfHHazoy7ccULaIw2hRoBenMjqef4I/JR56Epooqv5VRrc9?=
 =?us-ascii?Q?IW/Fh9WQy5R0MKA4y8dwvH7U5Rql+AnoWgqluVI44JmqBGBdyxslFKZ0gTzU?=
 =?us-ascii?Q?3ywhFbSdRqfZeNGHqegPg4EZ8xI4/F2zwPYI52moh3k/wfvM2kUZdJLmGVi6?=
 =?us-ascii?Q?nvWMQj01kczuAzvDJJULfkfmSfuJf6UsjYePbHshYg5SH2VysFWmhC5Ptpjg?=
 =?us-ascii?Q?5koShir4zc/f4eg0IH9CYjJTklimQX7JCND9rLBqcSmLRSpCNsgTFPcCuYxw?=
 =?us-ascii?Q?576fPg4NKz//tHVxCFFGlxCIvBer4KGfc/I+fqH2O48WK/5ehAXoIJjckXhs?=
 =?us-ascii?Q?RM4z8iT4HCMqiVG48B0Vao8Ta2aAegoZZQhGqieJjD9OB8ZLJGiWtdTNH7qQ?=
 =?us-ascii?Q?qmUq/lyXUIQJsvDLRLyigj3L1bzCL4gOuq2zh3V/ccEg6pBi+r6pAKCGxPXv?=
 =?us-ascii?Q?RYLpwmZqpYUijRsHWyzrUHBe0riyCCA6MHDrFY0rqzRENhc6ll6u5YmERWp9?=
 =?us-ascii?Q?VL7FelVb98fJjKtcC1eK/anbOYNr8RUaw/aGtZvsRg4BmACf33QhzsG4J7ai?=
 =?us-ascii?Q?IjJT5p4GiizaHr2z5eRc4i25ZKPjDFkUCzandlzRkQ1Ty+LYZ/4QtFfTkoma?=
 =?us-ascii?Q?hrvCjFjRe+Cp5V4wWC3UjyD6tHBbhfl4kTGdQhuwrpTRwwaeC3T65TL22oJY?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8B8Y6KF6Fqu6y1hKRMRM+DLzZc3VSRTPS1df9AC2hVkoloVP8wGg6TW3d62t?=
 =?us-ascii?Q?7L6VhE7QaIlttefFTPgef3v+Gr/D9vNfSYAu7/M/DG1xFtcUMfUP+7JrF/v1?=
 =?us-ascii?Q?D8gOsRo3DVFZQ8odoY241L9CCv6osrGXdgVJ1RTkoUR02H+rgEf982Atyxkh?=
 =?us-ascii?Q?Q4Kal4eIOuHbI4qS9wIEavsicQIUAQWSGnsjIDng1flM5w0kb0EgptwsUrVA?=
 =?us-ascii?Q?6YkpTPkk9hDuos2zCSG70DMVN79imi+a3XUCEvU1ppM4FtHVkO4i3eWxvY8z?=
 =?us-ascii?Q?cqrayfLW0zD9rs6YqB6Z+n4LTPd4vxUvyiKzsCcaDySP+Dh/x0FIQ1Vy+LeU?=
 =?us-ascii?Q?hS5epoKGvgrI7QtSjBFkWTeelp3TWg3EvhjWOiN9XDZylswQUVwbvWoNjCnW?=
 =?us-ascii?Q?c82TqRrpp05hDntdFQD/HdZLanRgDa4HV7xtbP0KsjM2D1aPrLKydstcXyvV?=
 =?us-ascii?Q?yHqJdgJGc51bP7ZX+sve9V3kzSFqR9KvvEO55YYWI2Ok8pczGBDVSdclj40t?=
 =?us-ascii?Q?5cvFramFhUvTxC6eeQiNWYwnOkG2pU2EnA19Xvv7PseCiLEHojaxYd+kYzND?=
 =?us-ascii?Q?D/4mPrVzEGy+6jwm3lJq0Gjf3WuvG8hnd8Yy1QGDB003LAclOF5Q+98Au2Sb?=
 =?us-ascii?Q?lsGIqNXRylD3PyCNJZuXBwkL3vVGT9bPKI9uQB8WmtG1JNwcdRx5sueR4dyc?=
 =?us-ascii?Q?9J+BLopJeSPGrbDFyLuJaNL/uzUetcMi/HlK/M7spLaA15TCjDDrqUTyl0gB?=
 =?us-ascii?Q?QI56LjOpz85vkNnr1bCa4+BlYm9Gp7L95fCwIhl727m8/qyKNWY//YZWrHGo?=
 =?us-ascii?Q?7ttC5VTL4D3rEPNmQx77fXbmYa1TwJT/eM0SXfjh6LZ+boWonvxmKc2VDKeS?=
 =?us-ascii?Q?NTHr7H8QnGyEuKylLIjkfqdZ2v4ntaLwY9OPa7PLJZ/M6XVNG6mxVQ32FANq?=
 =?us-ascii?Q?v7D0wB/1//48JXTb/QRLDmdfFTA7HYQ6aNaqv3WaOLjx8wac34lykFHy2r2Z?=
 =?us-ascii?Q?4TCa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5297c96-8ca9-4773-6a71-08db9cf8a0aa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 18:59:46.8478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Me5601IJHk+E3jWA+rCM1Eg4cVcDkIs+hzST3yH8T5kESszKbE11g9LmEDqzBBJ1cJelyWQ8bqjm2DMhyBlpiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4511
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140176
X-Proofpoint-ORIG-GUID: j_RwF2XQMPS2PRCMaynnR8OpENfNpnUl
X-Proofpoint-GUID: j_RwF2XQMPS2PRCMaynnR8OpENfNpnUl
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 14, 2023 at 01:36:54PM -0400, Jeff Layton wrote:
> svc_tcp_sendmsg used to factor in the xdr->page_base when sending pages,
> but 5df5dd03a8f7 dropped that part of the handling. Fix it by setting
> the bv_offset of the first bvec.
> 
> Fixes: 5df5dd03a8f7 ("sunrpc: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

LGTM. However, nfsd-fixes does not have 5df5dd03a8f7 because the
previous nfsd-next was merged into v6.5 before David's
MSG_SPLICE_PAGES work was merged.

Unless someone has a better suggestion, I'll rebase nfsd-fixes to
v6.5-r6 and apply this fix to send to Linus.


> ---
> Changes in v2:
> - limit the change to just svc_tcp_sendmsg
> ---
>  net/sunrpc/svcsock.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index e43f26382411..2eb8df44f894 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -1244,6 +1244,9 @@ static int svc_tcp_sendmsg(struct socket *sock, struct xdr_buf *xdr,
>  	if (ret != head->iov_len)
>  		goto out;
>  
> +	if (xdr_buf_pagecount(xdr))
> +		xdr->bvec[0].bv_offset = offset_in_page(xdr->page_base);
> +
>  	msg.msg_flags = MSG_SPLICE_PAGES;
>  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, xdr->bvec,
>  		      xdr_buf_pagecount(xdr), xdr->page_len);
> 
> ---
> base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
> change-id: 20230814-sendpage-b04874eed249
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Chuck Lever
