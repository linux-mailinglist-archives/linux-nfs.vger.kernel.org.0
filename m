Return-Path: <linux-nfs+bounces-1465-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 236C383DB8C
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 15:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A546C1F21CFA
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 14:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88161BF53;
	Fri, 26 Jan 2024 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bU6kYQYN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c0XoO2j7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1912B7C
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706278379; cv=fail; b=lnNgp8ghAEFMIceDZvcMjqGcCEYzEDTqxUxXjqoxJPGNg62u/U6x9VaFwcM/B84UlIU5Th7iGrDUec4dqtu2va34TgmmKlO2KDXZgNhWMoA7niKOy7Tnsp8GzNqyeu90GT5+3sb1bpuowgNUCFPPmYhmqL8cnKJWpgzkTKYOULQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706278379; c=relaxed/simple;
	bh=28EdDz77XzElb+77J0/4OSzaYa6uFkLQMCp8E2+dOnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a1J71Gyga/3o8EU8zkp/Xt1LxHlEZdnjXpN9GJuxKczlHR2P9oW3Sx2hUHsM26/+9IaQALfBx3G8xjrC5v5znolKjXvMV5J0Gz86m26+TPFq3sraE/jskMVGxstMyxXYjGPNDZZAhFeTksY5H4LcWlHj4LNhYScV2mG63x9ZIxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bU6kYQYN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c0XoO2j7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QD5JK0018545;
	Fri, 26 Jan 2024 14:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=KsRqtwlaiuF4C1EFDIJQI/1GIFeq3HEpWgXj9jp80Eg=;
 b=bU6kYQYNif92ZNdyk1E+nZl+u55bvMiYrWWeZccjmrS7Q9Hm4AmOjfijsRud1kSpNEl7
 8n22sPKXTAVQy7b6eFI6Z+BmeQXloJsi5baogilhprJ/9RZe0IsjUtGEoqem4r0iF+C7
 TXoMyHmIfJyI4t+H1yGLTW96ndvQ36DmXfSnSWmYl7B4j0GfU3L52QdKwTOzI4gOHuHl
 TnKJ+nyOwuhSKKURORkRtSgclAiY0VF4sXY/cN1lDnOnHt+6TgKGSL1h+RGjDyOQSf/e
 D4QNqonklaw0PQz7t2rkhzf5xyMRxfmyWcUf5fquUotdRNQ5d05STp0sIEay8QmbUMG8 fQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cy9j9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 14:12:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40QDlUBC030790;
	Fri, 26 Jan 2024 14:12:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs376cr1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 14:12:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igqvWZmXNbi3sIFg3rGMGzk7e18nOjWjIF+3L6b1TypRxhSVTkQauti1y7XYSAiJmqfc2Iii3YwiMMyknoyn+wvj6bp973OpUcvLop96/NHaCKpEcYx2437IPft5ugQlLM9eQtCr8A6vLiYE283BbWyxYSA+xICxzt89vp1aT87FsjmX2Ju7T9oGWSaQHQkOPlv39hokuF9IWaK+YQJc5edksik0+B+bsTd4rSKUfHRVMg/V5zxLqkPdarvOl8SJJjdfBValALtXQV0T2Jbh3XrX5lY34/ih3CMCzPoa42f9xnYJY5CCkALktnjPKktfUqHFo9A9wco8LwqNF/C48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsRqtwlaiuF4C1EFDIJQI/1GIFeq3HEpWgXj9jp80Eg=;
 b=Q6Le4oEqLv009SDhPu7AAFV3lEMnNL6FBWfkX5nHTDevkDladcB9HjdOc+vqFkaKGGB0HLRao1mWY//WPN4Dx0LqIgbGIHP4t9mVTAQfnzKccrXdZEVAvPc/yfgJA6OwILoc6ZhjRKaXPYgpLGO1hKbnaaVq7SjfCQn92tvpQVfP2TY3GZWHItejnHMoA6eA+11xalFwk2pEjjk5KoQx5cNjIkxyaYeGk0lZwp72GnIekDOaH2RqOCC8ii6bbMVrFQCeFce6QuPFiDwM/AETzodnpM+H2iSTmrKdBPfPHHOUbUSzn5ltIb+XZWxJhAXp3SEOUvaAFcwxicfwXN0WYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsRqtwlaiuF4C1EFDIJQI/1GIFeq3HEpWgXj9jp80Eg=;
 b=c0XoO2j7mtUdPGTklnU1b7S5DWkBFBa9eBuq20u0+ExbP6ViR+lqZJuq7vwz50fbrSgHu+dyyUZvlfjzxgWcX2r2iL1wGtm3LJfBBlaRk3NKxt/deyS/x+SqcMhamHpQran246V44lUCnF2YbnVd0VJPKhHnIiXj7tLWshelQA8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7117.namprd10.prod.outlook.com (2603:10b6:610:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 14:12:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%6]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 14:12:45 +0000
Date: Fri, 26 Jan 2024 09:12:43 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 07/13] NFSD: Add callback operation lifetime trace
 points
Message-ID: <ZbO92zZkNpRomQqq@tissot.1015granger.net>
References: <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
 <170620016455.2833.5426224225062159088.stgit@manet.1015granger.net>
 <86789B68-0271-4AEB-9941-CFDB956E84EE@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86789B68-0271-4AEB-9941-CFDB956E84EE@redhat.com>
X-ClientProxiedBy: CH0PR03CA0267.namprd03.prod.outlook.com
 (2603:10b6:610:e5::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ff6e40-afaf-4e71-2dda-08dc1e78de80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hWUTbgKPxmaDI3rRYyAIy0Gokz4e5mJ2nlPqLAuNqpiIvWZTr4ftCUDL3nrtq2oOkk+S5cN97veO0h0gR5Sb3K2Dlc36WShebfGJMWJ0DU+BRyE05x70S5ijr6/P5qZDJGagWO7XnxnSLnMv+EX3PR2bZgZ2qqRvFDe2UNwOx5BAm87lsMbDAEPskeeQNgyD7ktq5u6Rm5w2ZdaWeI/3I2Dd48Ykii41IoJ727X/8jyZu98bkd8m66Un5tFPfF2U8jl97nukD2wVX8QK5WGQ57RPN2LGq9zvzjMoIuEQR/Lr/IJJByTISSeIczJyaES2sECS9GhsFplxWvxkyCg+o6cAs9pFaSCS9ODqDYUyJuOk68EcduyPn6OKDj/SmfrsHlg433xnJlaU/wQ4AU/MUXidOx+q34Z6HNjyKYhFCGAtHoCHIVvEQ/d82l/k3K+16qarJ22zRpmHPBQSHynZRaI5RDhtywJ79eFCcv41U+GegOXF9tIw22ANJnrV+7l4dZan2IkiVF3U4x7vGSW0Zsa36+iOcAorq54F+G9bAKYzvzhmXUhX9uGa/eKprJK7
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41300700001)(83380400001)(6506007)(9686003)(6512007)(26005)(38100700002)(6486002)(4326008)(5660300002)(8676002)(66946007)(2906002)(478600001)(8936002)(66556008)(53546011)(66476007)(44832011)(316002)(6916009)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QlAKyKYgG36sItbW5BBrQ2gE3U7CjIWwBYMjqa7EzJb/SCcccpbz/zg8Rxtj?=
 =?us-ascii?Q?0Qy7rMkHFkxG1wkeoCmFD/HBshpvko1BuXuL5lmY6VuPs/XzCacMAudjLhT8?=
 =?us-ascii?Q?8I8SRDa/pNhI+cmG9Qs+e8e1d9/Q3kD9bGtCjjpFjYldegd3r2dRqqE31HjF?=
 =?us-ascii?Q?s7Anq0HlfIkSZOSwZ7yvg5xSdOvI+dDUH46dN/1NkZoJPNn1QqP3cobd0Idh?=
 =?us-ascii?Q?bk8xQxnC8R/s5IxPXPkrZQcY1cvBkfTtu/ZUy71sebWR8amH48fKtgQqssDN?=
 =?us-ascii?Q?NWpELB8RRJ0NZGv514v2FKpje2rQuxy3kZpG+Y95mopKU9JRmMfg4ri9Ca80?=
 =?us-ascii?Q?YCdHhcutb3V7Pco4QRVH/t58p9EII6kuZPGkHTM5p1LgdLL4FgNuKnzWMN2B?=
 =?us-ascii?Q?x3r2rgyVH3P003vEbtZHJ7e5u7cCM7VS5/qqgo+S+xpYLhRFnLmSc3oYC+0K?=
 =?us-ascii?Q?UvcKxUqMkKT8RJSpLVO4rBEWCCscpijoXeWdNuKUkh7geeELxGBt5WUys+g/?=
 =?us-ascii?Q?/2vjPaYE88ZbPKVM6rrMpFB+hbPjjnmxcJe+EmkI6pY0SQii3xN8tn+uqr4M?=
 =?us-ascii?Q?pN+YTsFw9JckCg6HEfe6Z7YWfuR7HExzTeBUbaB/b4gCL/rlOqtf7T7kM8IC?=
 =?us-ascii?Q?j1TmIx25c0ttXX7J7+wMi7mq/dwAYWmzyVSaVScZ8YgzrVqxpsiDwZm71ntO?=
 =?us-ascii?Q?QnQXA2hXT0FucjVDWz0zq7i+cW9xkMQtDJxsT4coaXvC2y3mNqjAGkajpt2i?=
 =?us-ascii?Q?e9KvufTttETWL3LswtwP3H5IScZ1lWj9QYBlqhe1RinB53G4p5CDqmg87Rlv?=
 =?us-ascii?Q?Fx0S7SF98O5qKv+vJ9jI856WgzIQaNJXPweOO7OMkqp5SU9OSIvPuHhM7Wls?=
 =?us-ascii?Q?cYC+DrZXqyTxDcIC+UdSkTyCPPRh5GbiPwrGs+TTirOfawdXL6LtwlzHqJV6?=
 =?us-ascii?Q?bVLTb5uDOfvvOAhGI4h/0GtWKKPu+/jsXe5JtypybITF1IxvAVQPi17v71YW?=
 =?us-ascii?Q?VJeyCp68DuqqSdoRkka92m6+iQ/A/yGtY+h6OMXoWIFFdmPblt+rjmkFbppY?=
 =?us-ascii?Q?SCIQnrhZBkG9dC5JJ8SnWgudiL3AaBsSHHQ2OsLvwjxaimFkaQPXEexCZdFd?=
 =?us-ascii?Q?ii6+wKLBnMx19KdPE6TMF8WjGjJLwOc1QNyMudo9DYVKbdX193lh8GbGXYwa?=
 =?us-ascii?Q?fewnVftwnR1538RzX2PX0TCAZNAxaFPQPd8X0V4Jp/69UTvvkvDCzZTMOmb5?=
 =?us-ascii?Q?7UCz5wvwHzvQY+RJxJ+EIIssijeUKV5oPqdJfP4T4f9fWVXshcvSHbcd94IT?=
 =?us-ascii?Q?0wdXfwZQfJo3fbEsjiTMq5fH3f7FH4yx+Tt1gYf5UuSzggMpdgepANLFIUS6?=
 =?us-ascii?Q?Zf9myikSNk1IX6yv30xW80vvTQ/IeVlHfZoRiNSME7Hi/rvIiS6mYmxZZs6N?=
 =?us-ascii?Q?bTpB9taGCLKULRx4RsD7hPRKAcN7AYnzXFExzeJ/G832htAtlrZMZlMQ+FFz?=
 =?us-ascii?Q?Pla3Wh3nyCof9gSsoPy38kUohFmS9NCwVJfXC6AekjI+OEvigGIvGN0olBEQ?=
 =?us-ascii?Q?nweKmJUb7shXN85KyQ/WJsCrEZVNxVjUffeJ3e6Oo2FxLxDIfdwyJPfMviJ9?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jHimZjoS/V1iyiVmKUyB8ViVpu/+ud3XZkA1cNNHTlcpKIr0RUgAF5JvjiRmuqzp6Z4NytLM40d4r5FuNisrIxvtvmfcfbGBlslRfPfmhakIL2loxfKlzrpdu4dNJt+AN0kxPf7pgpxsnbZuDjKxxhd5WisrGZG7CF5067+brXMZ2qqg+a5ea21WFRWTqD3jSpA4aMkMnPOuagUEcK1R77c5V/tvDdcU4iofs3OuzGHoSpq2/U9K3Hgmwb+bBbUnmbVjnxWCUBNXD2I2Zb+Q4yu8xRu0izT5No35OExPHJGL4Uj7uNfaGSjHf+XHkmH7fQdPSshgCnyUp2LHDkTBT8ADL14uISfF3juaUU5LEiuyIqHPRH/JrWOfj7F/w8Lyq0G95ZKwiQaMh0cC0zLbUhxJlN2fbWUZW6bYW7riKaqodMOYYFXTfgXpAkE8kUGeQHA4pDOHSpMttNNPTlllCDRKr0A45EQpEdmkalcWVdCwfakqd4Hjx2CAMZa+D8J0kp6bhtvGe8n18ZPYXGJcxrpqhhBX21CPINdTtkbwqiWqjxOaHfoL/HEl3QJ8g4odIv+dG85gN0MrWhwh391A4ASvSWX7qceRNpHVMHsP6ZA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ff6e40-afaf-4e71-2dda-08dc1e78de80
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 14:12:45.8342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4D0M5KokeJ6A6yXbkAb7h5l5XLmV2hIe/lAgYfDJ0KcqX/LP4dqSjvkvcUaSlxEwpvCKRVuCa2KHMYH1b22xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=684
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260104
X-Proofpoint-ORIG-GUID: gix2UHX3JoUPUaV9CpBj6-9-SKBqRPc3
X-Proofpoint-GUID: gix2UHX3JoUPUaV9CpBj6-9-SKBqRPc3

On Thu, Jan 25, 2024 at 04:49:17PM -0500, Benjamin Coddington wrote:
> On 25 Jan 2024, at 11:29, Chuck Lever wrote:
> 
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > Help observe the flow of callback operations.
> >
> > bc_shutdown() records exactly when the backchannel RPC client is
> > destroyed and cl_cb_client is replaced with NULL.
> >
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/nfs4callback.c   |    7 +++++++
> >  fs/nfsd/trace.h          |   42 ++++++++++++++++++++++++++++++++++++++++++
> >  include/trace/misc/nfs.h |   34 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 83 insertions(+)
> >
> > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > index 1c85426830b1..4d5a6370b92c 100644
> > --- a/fs/nfsd/nfs4callback.c
> > +++ b/fs/nfsd/nfs4callback.c
> > @@ -887,6 +887,7 @@ static struct workqueue_struct *callback_wq;
> >
> >  static bool nfsd4_queue_cb(struct nfsd4_callback *cb)
> >  {
> > +	trace_nfsd_cb_queue(cb->cb_clp, cb);
> >  	return queue_work(callback_wq, &cb->cb_work);
> >  }
> >
> > @@ -1106,6 +1107,7 @@ static void nfsd41_destroy_cb(struct nfsd4_callback *cb)
> >  {
> >  	struct nfs4_client *clp = cb->cb_clp;
> >
> > +	trace_nfsd_cb_destroy(clp, cb);
> >  	nfsd41_cb_release_slot(cb);
> >  	if (cb->cb_ops && cb->cb_ops->release)
> >  		cb->cb_ops->release(cb);
> > @@ -1220,6 +1222,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
> >  	goto out;
> >  need_restart:
> >  	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
> > +		trace_nfsd_cb_restart(clp, cb);
> >  		task->tk_status = 0;
> >  		cb->cb_need_restart = true;
> 
> I think you want to call the tracepoint /after/ setting cb_need_restart here..

Maybe?

The trace point currently captures the value of cb_need_restart
before this logic overwrites it. Is that beneficial for
troubleshooting?


> >  	}
> > @@ -1333,11 +1336,14 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
> >  	struct nfsd4_conn *c;
> >  	int err;
> >
> > +	trace_nfsd_cb_bc_update(clp, cb);
> > +
> >  	/*
> >  	 * This is either an update, or the client dying; in either case,
> >  	 * kill the old client:
> >  	 */
> >  	if (clp->cl_cb_client) {
> > +		trace_nfsd_cb_bc_shutdown(clp, cb);
> >  		rpc_shutdown_client(clp->cl_cb_client);
> >  		clp->cl_cb_client = NULL;
> >  		put_cred(clp->cl_cb_cred);
> > @@ -1349,6 +1355,7 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
> >  	}
> >  	if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags))
> >  		return;
> > +
> 
> I'm in favor of this whitespace change, but did you mean to include it?

Yes, but it might be better off in one of the other patches.


-- 
Chuck Lever

