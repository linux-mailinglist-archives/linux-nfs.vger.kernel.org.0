Return-Path: <linux-nfs+bounces-382-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EAE808A7A
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 15:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E409E1F21254
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 14:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A831541C95;
	Thu,  7 Dec 2023 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hJWobh0C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RAjr2sAP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B938E1719
	for <linux-nfs@vger.kernel.org>; Thu,  7 Dec 2023 06:26:47 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7E3rrl018113;
	Thu, 7 Dec 2023 14:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=Kk1YuyzZDnKE71iDOE6eSRViry2Rr0sMaIgWU4pkZfI=;
 b=hJWobh0CLGKhLaOJKXuAr0mV4N2PmOXE5R50oRXac1sn7KzcIcKWSuhgXPKpdmEUmNaR
 m22Y64MS1aB2hAfTovlEC4U9bjP5hKyz0ynERP3cis+aqAkZIctctimS+SbBhd0Rbzet
 0o8HSdo5Nbr95oJ5DX/6+WsPctzsjLYVJJfdhT7oTIiM70Z0beQEJal9+c0gYmdZUTgY
 VrDu7c37tvmpKnQE9CGQjMq6Bjr5rO2JuzmdLRD5QjqRvzRUUSFRNkTJujRo4G4cM4T+
 fcUhU/+TiSol0+iaUhMcUW4EbdiEp4XmjLmQXKtPCZG4pJsJXpPrA0tfx/npq34h7uNw CQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdmbkvp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Dec 2023 14:26:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7CwDd9039445;
	Thu, 7 Dec 2023 14:26:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan7gtpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Dec 2023 14:26:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lo7C/0JJl5wgQae3UmGGYeLXiFFJaXKaXzQImUsdfYvjpPEdkHet988nwp7xL6mvUzkhsdVSop7dnsSxzoHMeCXeJHVX2X94rEF5SEK9b6w8MLk1Ru73pjN7/BUJ3cQGxEs31i2A9FqPofK07j3xvhWGchxONVsp7jhER9gRwoSBBecy9QkRb32x9MyJ0mJktASGnoji7dYHSjtOM968EXcN+w5DcHxGqSUOitnNwiyflJ9nwtC2LbtFk5uPP9FckzO0yJCwDZiAEWoUZz2Bq6pzpq12Cyl3QoQCfNx5gTxKcFvkfIC9ZgGuOLcrEnAR0ewh0hoFDYS+yalehSjSKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kk1YuyzZDnKE71iDOE6eSRViry2Rr0sMaIgWU4pkZfI=;
 b=hTRacrbr0C723TqHyrylxMFR+n1BCzddf38lD664ff8CK5ZZoZh8xJVTKpW8qAIH5AirgBy4G1uGwKncwqiHl5556xzRdgHVVz6iAAqg5l8lC4D+8L0n5H8hHTIxhZf41duFCCNi2CRDxm94VGoqJ2zTSaKOyxNaLXjY3mdUq/238BY9S6X+Uu1B/1sC5s8I+XpSdXr+gPg5zllADWrNudv63BYY8d9ODxbSa0HHPI5tn73pdEJc7ByAs4OtYbq0ChtBeEImDDCiYqrTxwj3D1rT6OfyhvDMa+U2RaaWEOsInrTya/c8ZtfnMC6V41I/gOxVAKpCFd7z3abinSwX8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kk1YuyzZDnKE71iDOE6eSRViry2Rr0sMaIgWU4pkZfI=;
 b=RAjr2sAP0eN8xwsNzwpS/swmQpKMjtThlwWACMWwwhmz1aHZM6HAzPuq3+x+GqH4QDrX1P+R1neSlGqGdplBB/guIMGqMjD/sqkm8HT7J1R3THRP+lyClR6RSJanSGig1K0wilA1qfoFkCe9ZYJzg0fyRtMwbncWhO4fPxK3p3U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4675.namprd10.prod.outlook.com (2603:10b6:303:93::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 14:26:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 14:26:40 +0000
Date: Thu, 7 Dec 2023 09:26:37 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc: steved@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] gssapi: fix rpc_gss_seccreate passed in cred
Message-ID: <ZXHWHUZ0ZjM4dzbW@tissot.1015granger.net>
References: <20231206213127.55310-1-olga.kornievskaia@gmail.com>
 <20231206213127.55310-2-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206213127.55310-2-olga.kornievskaia@gmail.com>
X-ClientProxiedBy: CH0P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4675:EE_
X-MS-Office365-Filtering-Correlation-Id: e211afe0-656e-4ac6-d2d1-08dbf7308711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2oLDTdkT4e7QY+boQ4q8t1fjbHkSBV2tikfLC21xm9dLwYPdW6nkBcQVANDDTLBmxYgZf2vl7zcdRtMwGpSHu8RiFP8oGTAeQ/jx6FWaTNG6ncUsAZa99BwRKCxduPI0ot8I7AtGEJ8/OZvVPp3CyJuMvpn+pR0V072W4DhFvAGa8UMVci9lcSn8nC/XbgOaEyT3ugRAYvcSv42S4RcX5zglfsGrj58Mdlbhl/PG6yhNJAV6Zo0wWhQEsUFot33uH87UGWf3c8gnqgHFST5yBhwZDXVP3L2irI0tVXtDGteJ4qeGW6BaoG/bCHxL/vyZzP8r98LQyejtoYmP2sDLKIuImlw2EQLDlVQe3kvNAmzqncddghUxTZgrWzeFYNfnLX5Mj60BOi0UjCw3a/AlkzjLhBRk7t29WossZzi4kpbTX0zsWO6Upp7c6sj0YrXXGERVGnUD0iCV/6K4hizTz2mtZftoChzXqgemuo+y/JPNegSaJPVjvefW6Dg8IQMskpV3236cFQPpF6FgA/9ZPd/jE17ehRVvkWdQ903ClWD2cBEImF3pm0uiVVDXCnXi
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(9686003)(6512007)(26005)(6666004)(6506007)(83380400001)(4744005)(41300700001)(5660300002)(8936002)(4326008)(44832011)(8676002)(66556008)(6486002)(2906002)(478600001)(66476007)(316002)(66946007)(6916009)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GMq4RtmQv3UONL09fkz5cAhvODdTuLQw/9O+UAmBSWBO4/us8Q2vMQ2SVF7J?=
 =?us-ascii?Q?g0jpuObQb2vsqgOGUWTXoLbrYvi28Oe1P8iJHrj13vF5itnVCn6f/HrlaZtf?=
 =?us-ascii?Q?pktc3bEI4WvAIrAyaOS2JB4CqmL4GFs2DmmYHC4Z3YR+MzjY7i1n2Q9JEKIc?=
 =?us-ascii?Q?Z8SuBcP7NJ+of82ebdhM86SA0xfN70WdU4T+lEEeonFvXksI9jz64XF8N0aT?=
 =?us-ascii?Q?iUNOdfYQ4n9+yiu3CHHq6reT9m/rRpXAOwIDuIUSQSNX6MdF4P5VFP+Db9dR?=
 =?us-ascii?Q?0lIg9+lNfhXAvP3nbY0/YOkNWEKZTQ0bDgW6si5VpmwqgAX/XCvyuXcY4rWP?=
 =?us-ascii?Q?1wBQQtGtkzTO+fTONC+rYEZbbAa28+Pl2aYtEDE9aINkWYnVGel/gsvGGER4?=
 =?us-ascii?Q?Snqj2GWoWcOcF0e8R7SkJ+638EWU0EUfqWwpTjvYzAk/fs4wyfDV90CSaJCA?=
 =?us-ascii?Q?4wt4vls3B97h3UacMMmKXFcW0lYP4Ib1BicYnd0iRK5bRIIX75fnX5c7UGik?=
 =?us-ascii?Q?G6CgWPCWT6DGTw5uXlhMpgC/PrqrEgo2L4Enve+Azoeh3k6gR8NsLOgzYqKM?=
 =?us-ascii?Q?DKskhN4qUq9inmXRyZrUJ7Jiv/j8o4XGL1CJAhltBZd9rqml0sNy7necUuCp?=
 =?us-ascii?Q?Y1luI0zCp65VQ06ssafJhOtFwJHm08y8oPV89NYK6HU8O/Rhbqlj1kT3+R9+?=
 =?us-ascii?Q?+E+UhteBCJ6WT5cRjnMuK5d9ZG9wAZGf+h+B2rRTc9X2OTIKyPGzfWzm/ile?=
 =?us-ascii?Q?asqyLCTI5W9qIQ0ZlF5n01rd7uRzAY2XyZib1oQX58+jsrB/Q/XEF2SdHP3v?=
 =?us-ascii?Q?yKwKes7HALWdy3TzOFmVbdujl2nhxKWowmmxxjXdXiNSWdiFY6DxRSk8WdBd?=
 =?us-ascii?Q?Up7Y3JjMmR2HNbaAS/aGojW9v+iIJ0ahgjQ1U8aCUMVp8SeSUq5w+VihJVDx?=
 =?us-ascii?Q?K4Geds9giWkY5JKobHXmlitgeFxFiNS7fn8iQ8PJbotT7gxLm92aN02Bk8LY?=
 =?us-ascii?Q?DwtGpCt4R6kskcKcJgzqF13BqR2TDCt9gven3Y81nNN5G/lfwxWbB0S9Pfii?=
 =?us-ascii?Q?yw1nWSGkaQdH0X/BMd6pZFkuTzr5BvbYWT+vnT87pRSBVaDRikh8szscQzKO?=
 =?us-ascii?Q?oF6QPJL0r2S1QfF+2cv+cvjnUNfc718UVhiChwkMAl9B4Ql21n87TaCtgVfZ?=
 =?us-ascii?Q?oQxBdok4qd1Yg5g3IrAkyVqPLJuqAHlY2kUYBXUFMXwM4aLqtbr/kPT3Oasl?=
 =?us-ascii?Q?qio+asFSVxl4GRpNG5DH+xB87YFTWqFjnbCbPuKcOqOIIOM7WHzvcKxor0IG?=
 =?us-ascii?Q?42ansuqanFEe3J8XvyRDwJWBjRIxq0aXj5Lwc5Q+sssNGti5o4h0AdywQjPm?=
 =?us-ascii?Q?xusMA357ZiT0gWTihn1Qf/TuAyqHGgQm7aqiLkwF45xLHbVM/Mc7VDkrmOp1?=
 =?us-ascii?Q?hsEyHzVYKpNpwcghHO77X8WEB6APH71ubMDjisIXsIzrhMXVJBoEJlu0wopp?=
 =?us-ascii?Q?4gaFYeenbahrc2k1AY33RqtEgxk+2ghvBTmfSS/jwU0pFyrmk7sTRAIby4K2?=
 =?us-ascii?Q?DhaYcR+StOCMXwCKTjPR5pkwjz04gatsiMTelFuYdkzwKfe44UC6fJQq1VJJ?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zZ0qoKLsD5utXLuyYZeFxuEK6nqCHuIkHqF4uVysdZmZwQLHsJ0eh/8GwPgfFi+gz/7Cd3MQ2vW0cG9vvknDFEZY18KTYlcNWpu8BUZ1Of01NBq5WJTOPyVL/Rb+kJ9H93On3G2YBSRtbgt18f7mh36HgotE4LK/xjuUrQcpZvU2XbmAEzZ8oRvESY70gXi9BFfqP+2DRWcXcwWRsAxr1brLhJo737loigbVsbnFMWVFXq3yu9IKAnxY1YJC2yemxy4So6V6Mxga7VnjMyFMoXWPl6CvSIVRP5sqVy1siyNibhgDLyBfwwlygVDf0LXF2hklsLDAOeckSfhowI0lc8sKiv0j3InrmTP3kUKy/WVV9wMUIIaJzfpEUeqNRKqLLc9oBFimEV3jFSASEue9trooOba1eQjez6iSKzCxOIIaRGPDXYCR3RBi00jlPjqsfMD7EqEnkXwNaF/hDjMYoVNJZOSi+uwQbBdb+KdkWQQLGNYmbuiNCkUwDyJl1XWV8jUVeIBO8UI2e74NRPyuTy+JmBUBAmpBWQXQIuGoqQFLa+5M6evE9zu/SFhIdYslfgr0Bbc1QMRHBo+tp04SaQgdWCzxkhdiyd8tPgudtUZv3KNLiOMXCVQog12iVpOVKSKQFCdCX5LKPWQyqgqDx1IcIs1L+LeyhOmU2NdnlMZbkyFGNFGYrwyoJLK4RzyLtXX2QgMUqq1nz+kuhEq5fajwKXNHL6JgtuxH0brUUJMK2n8Oz4tSciTYwIwADN45NyO5pt+GpzTKWtq91krxijHOQXAqPGwR07rWXxHoGBnnWS99X/+s1BvfMN3yb4gh
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e211afe0-656e-4ac6-d2d1-08dbf7308711
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 14:26:40.0714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gF8lQvZNjjrZ5mNKhw6H0XQsItZ1AtEsBwDGfmyh5ZKY1x42+yhTgEmZzOxSwqTs9v7blXWuMUpu22DtQhklPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_12,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070118
X-Proofpoint-ORIG-GUID: Un7bI-OCaSbej5muNFisy3m54MvaGR9Q
X-Proofpoint-GUID: Un7bI-OCaSbej5muNFisy3m54MvaGR9Q

On Wed, Dec 06, 2023 at 04:31:27PM -0500, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> Fix rpc_gss_seccreate() usage of the passed in gss credential.
> 
> Fixes: 5f1fe4dde861 ("Pass time_req and input_channel_bindings through to init_sec_context")
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> ---
>  src/auth_gss.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/auth_gss.c b/src/auth_gss.c
> index e317664..9d18f96 100644
> --- a/src/auth_gss.c
> +++ b/src/auth_gss.c
> @@ -842,9 +842,9 @@ rpc_gss_seccreate(CLIENT *clnt, char *principal, char *mechanism,
>  	gd->sec = sec;
>  
>  	if (req) {
> -		sec.req_flags = req->req_flags;
> +		gd->sec.req_flags = req->req_flags;
>  		gd->time_req = req->time_req;
> -		sec.cred = req->my_cred;
> +		gd->sec.cred = req->my_cred;
>  		gd->icb = req->input_channel_bindings;
>  	}
>  
> -- 
> 2.39.1
> 

-- 
Chuck Lever

