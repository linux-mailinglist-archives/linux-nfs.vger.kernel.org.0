Return-Path: <linux-nfs+bounces-1435-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B097883CDF1
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 22:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274981F23BC6
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 21:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C987135412;
	Thu, 25 Jan 2024 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jDFxOJVy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e85ZQNd5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B071386B5
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216499; cv=fail; b=E4y58KpMCQ+ttL8oC9207ybtMtT9u0Aq/wCfeQxhxWOSSqfI3PnslRi8HiOQ4EL38VhOGbQ/83smcAJULkLe/9UzC0dfviW1aLjCecdRVCiIGbVU8taDiqWIyCPTL0A6j46cwU6zNtTQPpHRGsVeHVGTZqDKnASEyx655ZhHQaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216499; c=relaxed/simple;
	bh=zTY4fSwolz7iHvQ2pzyJ0njq1vL+OkVX3YMlfrUHqRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k85iZa9O1lSCjB58bohDRzd0FWgjcHo1c5XWqdUakWhGPZ+YZVg516mIfV4Gm3GM+gWrHcI6Sx7hbB9KcHl0IFQI9ZJMXTtMtm50JCA0x/ImUrLLAr37nAXV5QIww/TKdCAScwVVM0brjMNZI16EiX0WAoC2P2wn2NCrzKdFt68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jDFxOJVy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e85ZQNd5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PK3va6004490;
	Thu, 25 Jan 2024 21:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=cms3megIEVZCb7HigpTuAg0fua/a6km92R22hzv/r4Y=;
 b=jDFxOJVyR/olFgveF4WALAX3xIU493p7hjAUAAzyosPpZSA+ZHvAKA6+lzsrdjB9lMze
 1H0z9DMvTYb3UjV5h1A6aHOBpEJ+pqf68a4HUoK+FD/C8iYG6lV52aCeGaOpfsJCk5+/
 LZkEGBW4G1KhJ734WRbm+QzTtMLe9PbdZwAVSOm5HS/jwFUJ4hiTzvs2Faf9E6cFZd20
 dAVuObAUpt9xiNxLL05bEUQ6rLSVNdqp8qNM3tLxojF1+aAcCTtRp6cFpP4iy4jiGflE
 x5zKloEk6mdPJgaWvYTD0th8BiS7R6ZAtTyPM1Men2E5l4seLAY5MvfJ1rIJXLRwEhpE qQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vutwx0v64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 21:01:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40PKPRkx003970;
	Thu, 25 Jan 2024 21:01:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32v1m7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 21:01:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRENe/tzR5kwxjAoiD8M8tvsXXMdXWG2WtEctelgR1lRUkBRp0pdYiM4JnWDYvy9TEZ+H7kchHYPaxew8eWN+H2KH1+AdEI9Tx4nlhluIa+KsNccbPQu1918OwuHhqLLFAA3Zz8DweQ1XysRXYDZ16BW/MfVOnP2+uIMtCT2T8iqPdeAipH0GjsYcr5ErdnNcpZu4TMc0U8nPp9X9jef9RxZMASNqiZXv8xZTJpWUxGk5i+ns/FgC8SkZITxcf0SYTIlZCOZWXRGvAXfYMjxmIoaiTBqybAr/NAlfUis6wCe2f7NMWC/fOECz1PIU01eM1j2j8Ig2toE8J52CLJ9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cms3megIEVZCb7HigpTuAg0fua/a6km92R22hzv/r4Y=;
 b=k2fg0aGK93Ao8osXbH89Q2gXhWu+VZ8X98FPJ1XB7i0aWNYuFucqKufSBzsyij4vzthUgfD8PtRD4/kZCs5Q6BPYIa+pqhWk2sqVvPa7t54slRt8WPhUP/9VEdMJo3Rz02vwPU9fOPERdE36UhmKIpkj+qU5jLs1sOTyQ/IrtLfCH0nCW2Qs0zoRVch+eZXmtqNo+fNTeCG7JKZCjqAmAOnGx1TBupGJp7DuIdTpjSIBHwrECwxlYBTXYKzOiunA1l+SkOWNcBCIDLFQ1RvyR/Wo1UnkPbdW8lWDZwcJ6Mp3J/YOZpiPEqjl+zcg3nX9No/t+5fMYzVqld7lmGMfPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cms3megIEVZCb7HigpTuAg0fua/a6km92R22hzv/r4Y=;
 b=e85ZQNd5vHKNK62vslu+oz96TElsSxKIOHKCDzM7ta7i7sCcAEKi9ORUoh/0/tgircQTzuIT6DSYRUXVymD8bliO67jW43xrvi7Q77YrwCOdB9KPpvsw1B8ghLDH2yMwLYXGxvL8DdzP/mQxERJTrJXfJKhzIycmTjMtR6h6y9w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB6963.namprd10.prod.outlook.com (2603:10b6:a03:4cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 21:01:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%7]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 21:01:30 +0000
Date: Thu, 25 Jan 2024 16:01:27 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-nfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 10/13] nfsd: move th_cnt into nfsd_net
Message-ID: <ZbLMJxLWIvomQIzO@tissot.1015granger.net>
References: <cover.1706212207.git.josef@toxicpanda.com>
 <0fa7bf5b5bbc863180e50363435b5a56c43dc5e3.1706212208.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fa7bf5b5bbc863180e50363435b5a56c43dc5e3.1706212208.git.josef@toxicpanda.com>
X-ClientProxiedBy: CH0PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:610:e6::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 37913340-7c7b-4011-a633-08dc1de8cda6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vTpM5RcmoPs92IMLHk67yZCvEX0pGmDwgnerfYHcao0F2FN/EMNOHffpvFs64KoQOAMhDa1g4SusY8HAlrUPhWgOScxk6hpdq7WdzeRgscM9ATIAh0hhlvykcaxbpG++voDIiP9+jdI0qV/HjjD9HnPVw2FqYvrcT07cpH+lk5Be3D6bASQCwOYACH5aHTX9V5Sg6BArf1SQNXemXReUKM1gNtd752B4OKITj00QCY8swzZu+pauY//CyeAYYCoCNZjPoE2LrsarAZUrg8tuvZD7QTeXId/NNRaf+Sn1/3xjvBC8DW/YASvYP6i/MjvpB9Pd+Z/hkj844EHlXhZnid7lqXzp0xVtVqvuj23hn9Ox/zNVZASK8nMC6u5KufLVaW6qLDcpao8JCxW0Fu6Zl9T4QDEdfiLJvGIKmvQsq2Z034za26E3sm94E4rwLrFivYL1Jnl8b2+0AsVJF8Hkh0KZTTU0wBHl7Zl5FqY5ADIt9LrSbYC2c3hkbtfR1e6blVI0I0Yxqot88NCAX+ESHyZEcVTDI4EZ7x8l915i7UjrgJLfQmiLv6KlPqVP5oIY
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(346002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(66946007)(66556008)(316002)(6512007)(6916009)(9686003)(66476007)(26005)(478600001)(38100700002)(6506007)(6486002)(4326008)(8676002)(5660300002)(44832011)(8936002)(83380400001)(86362001)(6666004)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Hikhrsjalis9SL2N3ppAh474SbpozYjW4r+RxW+L/Qig6WTCY7NoAvIoPDOf?=
 =?us-ascii?Q?lXXPlQifmQeq+g6O7eNXL7nz7vQr6Ca1qygi4IhHHmvgYzPtYRuk4BpeCaiB?=
 =?us-ascii?Q?Qft+3uYsoszT9rbNmp/g0ktiM2tk7hRMdiFVLiiLeakyiuT2aMTtgrHCATvc?=
 =?us-ascii?Q?nmZWh53ePnknZLLKT47k3cy57FyW282d0ZlPsu+fd3uhXphQR6L8socIk1OL?=
 =?us-ascii?Q?tmKujmD2cYPtO+OG7NtvZ3mgFSulOscHBLQDBrJfLWqPEXeK/1+rHR9s33r3?=
 =?us-ascii?Q?6xFHo8kffPoN0D1Eegy2SAL5yr89vTkf8XEoaP3KmDnalXW/hx363O4+lKH0?=
 =?us-ascii?Q?cvrPoalzGhgWFYZxnXML8GIkbf90nWVBBJF/gVMtEgPtonWzijP+4O1j9QFa?=
 =?us-ascii?Q?xt3u7OGsntsjAeYy7zgFpEsa45NAdyxvk6v6xGmEy1k3ZUKbrwoUmpvtAJuC?=
 =?us-ascii?Q?GRUffuelr2OlUvXjTe7kFwc5Seght2mSkvoUMeDCwC9uApjbRoRoDwDUu+Qr?=
 =?us-ascii?Q?zpo79dIv89cRwJIwxHN630oTcCg3n2DRzobyrV5t6N6giHkqodbWqFhg9+7B?=
 =?us-ascii?Q?Opz7QB4wliS4+F0aNPpPXlDepnQq5K1E65VtnuJBBj6pPj3pz5553m3gyc7D?=
 =?us-ascii?Q?O5RH2ThCAyzLe6ko/Ma/DXR7hXcYaXvN/LKwxGhTzTonjj9Y2q5KHVpGXnkD?=
 =?us-ascii?Q?0pbxLUMYwqDlfJ5qGjq0RvN7gDFbLDeWsm0RghvEQSijirud4ZcBI/nre1lw?=
 =?us-ascii?Q?y1KoQXuRdbQRstl7G/R5nd+8kbXb0lpx6znZSGqhh+6rubbX54Yl6tvx8OLs?=
 =?us-ascii?Q?WomprBR6IUKhxm9FS7KkRyRcoy0dUyHbtMC7W6ad8fjh/rFVxBVzzIdd9Cy/?=
 =?us-ascii?Q?SLXCEtptv6a+H6lAWCiCuuXewQQvY6aG9B1AD4v+XBtEXfpS1EqzgvabZ0E9?=
 =?us-ascii?Q?sMORE38VP/8bvKnRro/HNDUTPcVcwWjwMBdBManAinaxl9ALrvac0HEmi8WQ?=
 =?us-ascii?Q?duvAO9BpAIHriL7jVL0slJSB822qD3mmZvdvArRP/Xy1iLDfEmAzj3T+shvN?=
 =?us-ascii?Q?VRvekokNj/1d9LAT3cNKQB4dZsxPeVEapyqW4qy/iA5G4Aug1+0smaF49Jgg?=
 =?us-ascii?Q?5JsSDuFwcK4+ONyaUTshVZd+usNXVDV1e0nFi+pn3AAoWyRwENVfkqCwZmZr?=
 =?us-ascii?Q?6D2zH2HDWs19CpxLkzEAd5R+L5r7l86cjqiIWl+9KII/vTmMU3jR/TTGLD/Y?=
 =?us-ascii?Q?mtLbP/8E8Hnd5uyK1/hXr0Y9gQnA2GcvnfwiCG7lepeOZj/ccXsY8HVCAT9I?=
 =?us-ascii?Q?ihZFslsTtxuNAB2aoqkFMaIQML+w9UxqN2rbwJK7RUjOwO2AlPS7+ul34grZ?=
 =?us-ascii?Q?5/mME78EzzTDrc6XzYTrFzVMn2DVYaPABdD+RIEdEcTdaL5yql+jl7H5NQH+?=
 =?us-ascii?Q?MWqA3c/U58cKuaKKwoWzY1MwUxjFh2NQM72p43zGTves9UtUDtNmhkS9sZhd?=
 =?us-ascii?Q?UvYcQgQHyZXfxlZf2CMQf9+fwgsrVHK/NSP1P0Bak50jOZ5lE/YOHwJnIcyW?=
 =?us-ascii?Q?+VO6+9RAgiSK0wgTTVuuTSGNNKaYYgwGDNzyzpu0z7at9u80m+05oFqRjzcN?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pHh9MKaok6CiKmaHokIBy2EcK0YE4kf7TV3bbxu62vOVoGaTcT1VEBBmFYVxVdMZUb16TJ+T/ApGoj46CxWOgINwn5qeg4H2wYBRa92GS1Hb0BTNXu18qnB1MTLGCotd6UUNr5drGIJPIjTU8NJ4e0M6GhIfeAmeIRiE0L59iSkJ+COEd27nnA5IN/RFXOTgzFwiYwPX+NireYPkipMfsc+JI92xREPPdyKwAX96rXnO2k6f3mcg+d/kAEjuypdlRb/wYjaYiT4kvGl9xTROSG5oVibYYx39uM3ysvmHu/qbMm+K9OiAgNxmpd0PWe273NwpMdiNj8Z4zv3Tg83hWbhf8NYZ6zoqG3gcrEpuhjcN+KkAdU5mzYb32ZrcbxoaSlVXhvv2JEzKa1QmZyT1dm031MifkGGzw/qygSeSBYswLyoiFaWwhTRHPc9xvHQ5njrhrped3oerNgIIGB7nn2c88XIsQkIq5DofCnwj8QbdpRf5HhBcshRi9+dKNrIOO8eb9fu7y9MLJBHYYnAEGPrefDs9UW7T0+u0VikJwgBut08w90maUhZYjfMpo5HRN8eClpgx9JeQTNdW7bcGpfsYmQ0keX8eoGOD0+uK1zA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37913340-7c7b-4011-a633-08dc1de8cda6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 21:01:30.1136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NEKMp/PqrjZp0sEb/AUILhboLP28Oed70Tle/l1QCFsoFzgdP9rMATxAVzXav0e4EN4GMcl5IuHZ6q30CGOmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6963
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_13,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=976
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250151
X-Proofpoint-ORIG-GUID: MvcAlh79f_KWpLYUGK05Ldzn4_jVbGrt
X-Proofpoint-GUID: MvcAlh79f_KWpLYUGK05Ldzn4_jVbGrt

On Thu, Jan 25, 2024 at 02:53:20PM -0500, Josef Bacik wrote:
> This is the last global stat, move it into nfsd_net and adjust all the
> users to use that variant instead of the global one.

Hm. I thought nfsd threads were a global resource -- they service
all network namespaces. So, shouldn't the same thread count be
surfaced to all containers? Won't they all see all of the nfsd
processes?


> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/nfsd/netns.h  | 3 +++
>  fs/nfsd/nfssvc.c | 4 ++--
>  fs/nfsd/stats.c  | 4 ++--
>  fs/nfsd/stats.h  | 6 ------
>  4 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 0cef4bb407a9..8d3f4cb7cab4 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -179,6 +179,9 @@ struct nfsd_net {
>  	/* Per-netns stats counters */
>  	struct percpu_counter    counter[NFSD_STATS_COUNTERS_NUM];
>  
> +	/* number of available threads */
> +	atomic_t                 th_cnt;
> +
>  	/* longest hash chain seen */
>  	unsigned int             longest_chain;
>  
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index d98a6abad990..0961b95dcef6 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -924,7 +924,7 @@ nfsd(void *vrqstp)
>  
>  	current->fs->umask = 0;
>  
> -	atomic_inc(&nfsdstats.th_cnt);
> +	atomic_inc(&nn->th_cnt);
>  
>  	set_freezable();
>  
> @@ -940,7 +940,7 @@ nfsd(void *vrqstp)
>  		nfsd_file_net_dispose(nn);
>  	}
>  
> -	atomic_dec(&nfsdstats.th_cnt);
> +	atomic_dec(&nn->th_cnt);
>  
>  out:
>  	/* Release the thread */
> diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
> index 44e275324b06..360e6dbf4e5c 100644
> --- a/fs/nfsd/stats.c
> +++ b/fs/nfsd/stats.c
> @@ -27,7 +27,6 @@
>  
>  #include "nfsd.h"
>  
> -struct nfsd_stats	nfsdstats;
>  struct svc_stat		nfsd_svcstats = {
>  	.program	= &nfsd_program,
>  };
> @@ -47,7 +46,7 @@ static int nfsd_show(struct seq_file *seq, void *v)
>  		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_IO_WRITE]));
>  
>  	/* thread usage: */
> -	seq_printf(seq, "th %u 0", atomic_read(&nfsdstats.th_cnt));
> +	seq_printf(seq, "th %u 0", atomic_read(&nn->th_cnt));
>  
>  	/* deprecated thread usage histogram stats */
>  	for (i = 0; i < 10; i++)
> @@ -112,6 +111,7 @@ void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num)
>  
>  int nfsd_stat_counters_init(struct nfsd_net *nn)
>  {
> +	atomic_set(&nn->th_cnt, 0);
>  	return nfsd_percpu_counters_init(nn->counter, NFSD_STATS_COUNTERS_NUM);
>  }
>  
> diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
> index c24be4ddbe7d..5675d283a537 100644
> --- a/fs/nfsd/stats.h
> +++ b/fs/nfsd/stats.h
> @@ -10,12 +10,6 @@
>  #include <uapi/linux/nfsd/stats.h>
>  #include <linux/percpu_counter.h>
>  
> -struct nfsd_stats {
> -	atomic_t	th_cnt;		/* number of available threads */
> -};
> -
> -extern struct nfsd_stats	nfsdstats;
> -
>  extern struct svc_stat		nfsd_svcstats;
>  
>  int nfsd_percpu_counters_init(struct percpu_counter *counters, int num);
> -- 
> 2.43.0
> 
> 

-- 
Chuck Lever

