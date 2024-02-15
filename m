Return-Path: <linux-nfs+bounces-1978-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D508857096
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 23:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0678F28493D
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 22:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D871E4AE;
	Thu, 15 Feb 2024 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c9xm+JyB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rdahUQ5g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3DF8833
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708036426; cv=fail; b=UmZS4ixiVA8tJwo5Kibv3iS4zMOgFrf5dZanX+0vAgh3JP3qeUgeehLxzuFkQko89CNbBlhJQ/ypLOfYxztB7gxEbq6FbesLH8WPexUL/BzyLSrHtNFz+I5S/ztlyeksiRB7aPlVl0YKr+w5JGvH0QxXAixHLeMJ48TTQFTmIhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708036426; c=relaxed/simple;
	bh=iNOjLsFhnCnX0qdVRwh0UDDcco+QvhAywlu+bZbJePg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kGLpFXNmAb9hp4ANEvu3dbHmnXINqbhitajTREK3/IopOS2Sq18KaVfhl9uGBnDG94i4W22Vw01Er9meAV6HKX0H1/qmnM4qjuLXvm+19OjtRGkW/0wlB0uWL2dWRt3CAnjJR8qtMPDnZ5qE4WuXFxXEggk/fvUdHl7e8g8Y774=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c9xm+JyB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rdahUQ5g; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLSGIe029250;
	Thu, 15 Feb 2024 22:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=7A6tYJFeYEzn0xHBufZ16yR4xqQA6hhj68g0veT9OA0=;
 b=c9xm+JyB7e+uiNp4Key9cfB9Wuyn6qTWYi9+tC8Pqs1x9H72B+mEw/5ViOWKeYpoHkI/
 h8Mp9YICTu2is0XrxBiSMFyHqqcR4Q9ENs89APDdL7T0n+lkdg27R5csfWIez3VYE0zj
 t+blMv4lEQRTO3b4u/LXMedBK0n9i6VpZQEd2hhmqRdOPMBJN5KeM1itzG88tkos4H4h
 d6Bgen2DB7zx7iqA4pT06Bj2zgyedYTnkCUE8IDzI93xng9lks0YUTtKE1SIzFtVc+/b
 r895iPIBGi2ytYcBSyASI+WmGxZy7A5kJq/ZYfvSHli3yTI7jCBiDcT+Zigaq6FGuH4I tQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92ppkg84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 22:33:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FKtnoU014946;
	Thu, 15 Feb 2024 22:33:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykaxv0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 22:33:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSRtTSvjScPDmAppPgY2eIdR+qk3VeeGZ60Q+hY8XvZQXLsYfIdA1a2WQOHkIwRoYMXNUUAmzXYszZO1/Wl4AJnb7jCE4gEaIYCW5LTFJfdmpQjHrcs3+273dohMAeDEF8M41l+BtmOd2789ekzP5pa/pZnS88GB4xeHBk5kVbGbjKadbPXIr3HoFVjaeoWRk/0EzTTExR/KZDJ2hF0ormEwCdRMXZn5Mo3bh8+qEaULuIxOneCD4AY1qOJtwMVMpT5FHxXePnf+0vKOr1Nwkt5ue8VHnpwq2F0Rs7UGzIeSMc8SFCtDDP5RlNTWUtb4zZMDUl0XlXLQ5vX8xzPzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7A6tYJFeYEzn0xHBufZ16yR4xqQA6hhj68g0veT9OA0=;
 b=jAHOsJp101Co99eNM/X4XNmEtqJ6zuLyAwLrGB57ft63kWurGgnMre/uzbnE9oJ/A/C60UiF7xrnTPZnuxGQMcpCsJyXvMdimNoKpWCFctwXJstL+bJ6BEYjdgQX7OjZ4x7R06h0WkXyRQEDQkhyCMBwZTxKgky0axztAenchoqPQVbbWse4wpWyt2aVagPC/7L7rjjJxb8gRGi/fIRpoTqIdT3oBGImh6iO+5LNaM4eySlhFHhDcMtFJB8SwYhEdL9p3g8AcfUxgWv6+jQ/w3P6iX3HAPk57+LJREKG1t4zb+DFjtNdbTYhncqp2k7Q418UCgTltRVB6iI4HWL+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7A6tYJFeYEzn0xHBufZ16yR4xqQA6hhj68g0veT9OA0=;
 b=rdahUQ5gwl8qRZ0DyugjLGnf8GTPwkkucjYyLxxOEUg6OxhP7+Zizm5OlMADPxbeLpitJX+VuCnuZfwtQirQ/OqT23+Opi4Ky8chPIEOoHMPfL/TDfdYCoJ51KR92MDoXpI66fgex+2qGnvHHZhCSBLTZxGm2HhPOOMUBM760D0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6258.namprd10.prod.outlook.com (2603:10b6:208:38d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 22:33:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 22:33:39 +0000
Date: Thu, 15 Feb 2024 17:33:36 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: "Perry, Daniel" <dtperry@amazon.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Backporting NFSD filecache improvements to longterm maintenance
 kernel release
Message-ID: <Zc6RQBTnUblpJcvo@tissot.1015granger.net>
References: <3AFDD198-5391-4EF0-BD54-A0CD0AE77FAC@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AFDD198-5391-4EF0-BD54-A0CD0AE77FAC@amazon.com>
X-ClientProxiedBy: CH2PR17CA0023.namprd17.prod.outlook.com
 (2603:10b6:610:53::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BL3PR10MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e4f9a7-f80e-4cad-2421-08dc2e762807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1P9EGtLno/hKBmawNPeO4l/N+VKzfiFqXduzGsAVFgjetfXHO34DHWwevZf0ZLsiLY4sCugoG/8rtKTfJpkhMI6XLX+iScTtbg0N60Dp6N30kMsjhcb7GG1rhlGwombhu3N0HzUxi4ufGO4jN2cJljgyKvrKdvOUnSeNW90WH4mM61pTVbbnviPFGs0EEsDo109qqYIOiyowFfP2SD1O5pq2BEEn/hZSgPIivxg/WqiAsY/LcNtawHRuBi0vb4lHXGA1hIBCbHh3A1cNsUEky/jFmob/m+kMgfZNv5O3BaRICphl41X9kJuq2w8ayC2ptNAI1bKHVzEypdE/IWOEeGZ5h13RIsquBcYipS2kJ0UIjP4FT//mJcaN9/r4rrvPcXN3II6JulxYbuNkipGcY5uasFdSTuiN7geO8HbPtKVim+h1tkHQMWy9tX4Pu14/s5Y3Qi+ntfO3ERVpaTid+MKOmmKIefAGDOfz7amo2fzvlwMoWziA6ClL+D8ss9Y+3KFkw0s2n6Xo9SAENcJ3DodcvF0/b53sDy6ms/y7/6Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6506007)(6512007)(6486002)(966005)(478600001)(9686003)(41300700001)(2906002)(6916009)(4326008)(5660300002)(66476007)(44832011)(66946007)(8676002)(66556008)(8936002)(316002)(86362001)(83380400001)(26005)(6666004)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6ysQHqHVsO9hUpbcoUlTd6BR2WTzUihRPkggoxJJ8rNneycAolR84ljbwdd+?=
 =?us-ascii?Q?ah9JiYfAIJohE0S3fyOmwPdHqb+lhrY5pGPvwbKJpIlt8GGuXIETbpIVdRZO?=
 =?us-ascii?Q?d+bXOdUW/xAMokclZG8CMgeHh1mII31MhLeZ66sHT2ddvo2Mv9oiookKyxsR?=
 =?us-ascii?Q?TyY4bgdFZSeivhUc2hS2pYOvMV/mL7Vs3YimLK92mVQyovlmyvt/fkrW5uTc?=
 =?us-ascii?Q?lF7qdJuiHE4KyE8EacpSRgmYNv/DcBPir9ouaAbAtkwg0xleK2fPA94KROzs?=
 =?us-ascii?Q?O6HiNXxEsEa/i+kTqTbuPkM+cqNszy1Ujts6YfxGxBjWuYUubadMKMVlCXB2?=
 =?us-ascii?Q?adHtGjYE1PYLXdqI4ULJ5JDp/LzWceu8J79rKhX4UB6wCOIOrr6mslxQIFTi?=
 =?us-ascii?Q?EI3YXmrV4fY17humxusFdUcSVafFh9c7CKjlHBpSu/VxJ7j5jvIeNunYL4Kz?=
 =?us-ascii?Q?lQrbkSFZk3VAtrsWmo11FqF34bUIQ3VstcU5/KB2D5KFXkVXgR/FgiZFhmyh?=
 =?us-ascii?Q?fXhfIjjI9SucFmeBsxySu3TMxTBa8/3HRRnh4mwuOw27Dfdq4lk0N8JURw69?=
 =?us-ascii?Q?A7twbNADuQvoS1FwSK3CvSXflBQijYLuDo/1E4GbVxB4rTDtkOFHiNlVW+zK?=
 =?us-ascii?Q?rL+wIB34FYkYhAMZT1GJtSvlxfZ8lCNk2jBgc4okEMK5wRT/IOysW3oo+gWA?=
 =?us-ascii?Q?ZNz4tKmeuYZ+HLzb9xTkCjKcEpXTqyhLrckuyinL6ZZ3peuXKBLu49e49j1d?=
 =?us-ascii?Q?cK4H7cawqqqw99eETQ7qsR118Dw8LzAfCf5X5cUkg5QJ8esG7f20qEw0Dmgt?=
 =?us-ascii?Q?Z2oRmtGMJ+XlJwSQHwQ+hG/mrPLgsGe/o4XmckKTiPrsNGx4t2DE5hq8rXKV?=
 =?us-ascii?Q?tuvQfOQ5tcmAUL8P2sB4oU8sgkrTRJK83sDzljVz3escvROI1Gl77vmNDPzA?=
 =?us-ascii?Q?gvPohDhgBEyBluuAHxhBeLjpi5D08CBvx2HJLKst0A9DXF6E/dpTQs7abHqF?=
 =?us-ascii?Q?8tlr8+plSWNZsAbZxjM8s7KvKbeLicGs0aqaZJZxLhbPkVh+ibhVi2J7Avp2?=
 =?us-ascii?Q?/lFqj3CKc2uoeWGyGXaHVUvKMtmOjNKBKwi2g9JcTkBvIPS5F7u5JpKu2YkI?=
 =?us-ascii?Q?2GR8GSyXZk3srljbaTiZce7I0rh0W+GGvKtQeM0RxVh9uZdzj6ZkxKkmEKQT?=
 =?us-ascii?Q?AYJtQZskbp8hC0He7ImbfN8+EUstBT7r0fZiH5+n7DT6bn1Kgf8t8hjyjO+p?=
 =?us-ascii?Q?LXZPzyyn4fcA+XKu5RC9tKEJhM9V0+UmIWtPlRF0huwk5MdMUw9+Hr7LOnlS?=
 =?us-ascii?Q?POsXiTxwQ10HAMloSHR+d/mNn17u8XsbLK4uWRg2N5SuMf8eKeKglqvf3aNH?=
 =?us-ascii?Q?IRV4Ie1rCDatzdL5urOyiJifhO7GnqNkx14LhPBJEchEPHxYsiDb549pLaZL?=
 =?us-ascii?Q?sNSGa+GcFzEuSvvq1V/bHIW3gY6gBrbx4F+3kt9zdSgJTa4TjQr6+w1dZLLE?=
 =?us-ascii?Q?8JeCMgk4eKh7B2ycsbT8XsumXW0NUfQbtE7y1CNUMXA2g2+8AAH6B+9r80RC?=
 =?us-ascii?Q?/HJfHBzHoIrfslI/Oas8CbmGrIFD1TcxO0BULifhYThv17U3fza14ydYAmQx?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UrHlBKNlF6zn1+lxLYKug15WlW44Olid8pHfMRGlJ6ypSkKpU9rYbjQbLQycwGHaxDCs3QsEn/cBUE8eGdV4xotTIcFt+DpB5JZX2qAJofVfnd4HiIOi3V4STWieJtuAqD/C7nD+MRVaW/DfmDZzI31aUgG54rbxzi4aSJRvMbMdAJxoXxpt+jUanVi9ZIpdgP7jg+HHsHL2ZENTZG0OTSgPp2c9qcs8WbgxRuPvirwA14+XjG9eM47I8xrYWSi7YziJaJbEBT7irysAqabKE/L5Mqu6cgYo/npe/aPoeBKzZ8w/AAhA1fnstggAtnZkMGp0UBiEkKtMXXiGFS5D7Chw/4iiRPgvRVtu7YUfy4W7NFAhXP7euAmJ7XwtZKy1qx5Xg9j0DOLP/rZK9bZL6dnknt0QUFsZa7mkts9e2BEreDfjm/0rI9jX3CZX1O5JF6/IVxYNVnJnBSqgPymDn45gFPNRWK7L8vl/TvjYK0t5eF9KGED1NG+Gl3MJlY9tCkgOgMp+t8RXUWZicQUFtzW+LZyY8/uWVFq2UiPBacojaLVjbg7cm06V24CQIzRKl2XVjW5H9U9TQp+QYtinXjPvrUcs8Z6aTZO34O/DHzE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e4f9a7-f80e-4cad-2421-08dc2e762807
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 22:33:39.3985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOeX1K1jMbFj53SxkZbI7rx7EARIaYipdYfGRS6EYSgBPoC96BfCFg1/NfMUVF0eRtFErGMLskvV4E1Bkq8Siw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6258
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_21,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150177
X-Proofpoint-ORIG-GUID: 93UoqOWAbaSYN3hevLanUOZSiZRUjCAo
X-Proofpoint-GUID: 93UoqOWAbaSYN3hevLanUOZSiZRUjCAo

On Thu, Feb 15, 2024 at 08:40:06PM +0000, Perry, Daniel wrote:
> Before we spend more time investigating, I first thought I'd ask if the maintainers would be open to reviewing a set of patches that backport the NFSD filecache improvements to LTS kernel 5.10. From my perspective, these patches are core to nfsd being performant and stable with nfsv4. The changes included in the original patch series are large, but from what I can tell have been relatively bug free since being introduced to the mainline.
> 
> I believe we would not be the only ones who would benefit if these changes were backported to a 5.x LTS kernel. It appears others have attempted to backport some of these changes to their own 5.x kernels (see https://marc.info/?l=linux-kernel&m=167286008910652&w=2, https://marc.info/?l=linux-nfs&m=169269659416487&w=2). Both of these submissions indicate that they encountered some issues after they backported, the latter of which mentioned a later patch resolved (https://marc.info/?l=linux-nfs&m=167293078213110&w=2). However, I'm unsure if this later patch is needed since LTS kernel 6.1 is still without this commit. The above two examples provide some hesitation on our side for backporting these changes without some assistance/guidance. 

We (Oracle) have been discussing this internally as well.

I'm not a big fan of backporting large patch series. Generally, if a
stable kernel is not working for you, the best course of action is
for you to upgrade. But I know this is not always feasible.

In this case Jeff and I never found an adequate reproducer, so we
can't nail down exactly where in the series the problem was finally
resolved. And I think the community would be better off if we had an
upstream-tested backport rather than every distribution rolling
their own.

Further, the upstream community now has more standardized CI that
works for not just the upstream kernel but also the 5.x stable
kernels as well.

And, I now have some branches in my kernel.org repo where we can
collect patches specific to each stable kernel, to organize the
testing and review process before we send pull requests to Greg
and Sasha.

(Perhaps) the bad news is I would like to see the performance and
stability issues addressed for all stable kernels between 5.4,
where the filecache was introduced, and 6.1, the kernel release
just before things stabilized again. Maybe 5.4 is not practical?
But I think fixing only 5.10.y is not good enough.

As long as the community, and especially the author of these
patches, is involved I think we can make this happen. Can we start
with v6.1.y, which should be simpler? Do you have testing or CI in
place to tell when nfsd is working satisfactorily?


-- 
Chuck Lever

