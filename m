Return-Path: <linux-nfs+bounces-2011-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51157859304
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 22:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D2E1C20A59
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 21:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB997CF25;
	Sat, 17 Feb 2024 21:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VoiTlKK3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rFLOtE61"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EFC7C083
	for <linux-nfs@vger.kernel.org>; Sat, 17 Feb 2024 21:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708206138; cv=fail; b=kxzfczaxIRlmAWWeTJasLsGoulTuhq4jAnKfJ6EcRuzXdHodHjlMgD9Qic1kcaWnLAAq+MKZ6wJNjcx8pii+ci1sbXf3kZCHy7fJkidAqqLzWN0zL57dM/FLpf37jfw9adLdmjgJi4ninPh8dJtiImwCyHaAfZvVQnuwTZsJO3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708206138; c=relaxed/simple;
	bh=AhSYBJI10oJdCmo8EmlxrFPPZ3OZyJIDfPxAgZ8wdGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TMALCczzw1C81Y1Q5zq40QQHFGUr/K54w632ir7iMTFmmQIDQl5jMnuVe2lCBBaknRSlAmBO75mu3xgM17jDUCLIQLAyN8S9ERwMGBb5MfVRzLSkH7NzGPky+HTERDOhGzjA9i+RmjYAShnLpS/V8p2mtcNv4j3pt0BgTFoNaqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VoiTlKK3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rFLOtE61; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41HCE5jF009302;
	Sat, 17 Feb 2024 21:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=CEbo0YsFlqL3voD/YfHGG9bIH+2BZOOj8FyRFdPrcmE=;
 b=VoiTlKK3d0aV21xnRN5bU7i5eeOH0iH0CYU7dJoY8X4EYKwR2eAMbg3mzx0qImH10wK5
 VLpVvtilEeQjP4nlifn4rXv3F9xEJCj28/ceGP5NW+EkwYnK1PDc89hnrLvJYAso9Blh
 9aRcUDeqG30xxmrug9lVjCyZc6ZVIOGjbU0x7PYDdQcnV3KyYxeUx3rZLOmSNhCan5FR
 mATrJUvfHSNTDAIJrYT7zD0roGwGCmC3K+29e38KVjsUJp6kAEtIyDJDcJnJdc+bdLtx
 EKwKW6/1wQHePwTgtPA0L8dmCFHsbjZYI5kRvFGWJZP6GfhQ0pQC9VmJy0OQFwa6pK01 gg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wak7e98h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 21:42:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41HK1d7R016149;
	Sat, 17 Feb 2024 21:42:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak84admu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 21:42:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZ3X2qA8ilXTNub0IPzw33eG6KtA1KQ6aTwz6cQfuzUizlJkBbdEs/v+GHSK8T/JlpeEe8NGrBuCML/v06pvMGMr8YXAxnUuijAygToRe2qDjmM4goLWkb0eMfw42HJGE41b771e1KRBkQodDQHJf6i6Ko8ARkUjpEmqX7O+/dxkhhYmDzUxPmutugSfkT5CyG8Vjb7Jg+wXAYY5w0B+Lg9BwPRO88PwDVQiaQrBNoGmbERBNFwOr7hagCQcEwNClyf1bFhp1KvsuZILPkJk20fCfm4x6rVE+UEBQqY5slDwgDTrcz+RhrRFmXnBX4g70+wFXH/aLzOzK9N6xoH/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEbo0YsFlqL3voD/YfHGG9bIH+2BZOOj8FyRFdPrcmE=;
 b=AB0iLjUorpYcIn8P8AorZLEjz6o2zJGHKOQUx7d/+Q6NcflTO2Wdb5ASkEaLxpaFJ4OLlchNsrsmjHdjyXPG3JkVxMg8dQljUoBOsdlhaFvbGKykzJMwbWamg9oiQZL+QXo5E5BW7C6fn575lMBOYHD+CA2HEHrfqGDKQZ9641q2BJy/5M3NnulBXkpJKgs7cx1o99pVRP5r7acLSvlLBl0pgbSCKhAN7uHfJg0czFpBcDSgUdWXp1jt2pRNXYwr9QfCn+9pAcI/JoOrpFl/r6rne154/0455j4NxTeJmjCXcdU4f/8+lRH/G5jJD47G87YKMZIJi4WGiM40rMjZtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEbo0YsFlqL3voD/YfHGG9bIH+2BZOOj8FyRFdPrcmE=;
 b=rFLOtE61c9QPCYiUqBYJEJvSFUO6gFknaRPPVPQ0tnD/3sGHYmkn7roGNGs+dv2Hgn6nanUfj80PdjxvKLiapTxtKld95ZF9XIUZB0cM2UCXxJoGLmJd+jDk9jR4t10IyFb4JXG73MICM40EkcC+FPwLKgERSTaEfFhpI+8WGqc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6968.namprd10.prod.outlook.com (2603:10b6:510:279::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sat, 17 Feb
 2024 21:42:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 21:42:07 +0000
Date: Sat, 17 Feb 2024 16:41:58 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: dai.ngo@oracle.com
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: send OP_CB_RECALL_ANY to clients when number
 of delegations reach a threshold
Message-ID: <ZdEoJptfpKvUOfDi@klimt.1015granger.net>
References: <1708192859-25002-1-git-send-email-dai.ngo@oracle.com>
 <ZdEgpStNxUc94j01@klimt.1015granger.net>
 <9d3c4355-3a71-4127-90a9-73d3122f92a3@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d3c4355-3a71-4127-90a9-73d3122f92a3@oracle.com>
X-ClientProxiedBy: CH0PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:610:b1::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: f825801e-8a36-4e6f-f379-08dc30014a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3V3eTSU60bFHfmIoONa7rKitpu/raQEivb+9Uhno7gmwM6st0t/nkN8+fenpyh2j238cCdvj+/aPCwXdhadiCJ48i7MZdVT8oyNngF9Yqcnsh3DLjCKuFm8J0fijrrwVpmrHgNNvF/rLEZvImyE27w2aU16NoeEvakQ66LfVClcGvay+mhmiIm+mZB95YH1pvov4cFTFUEPxzziaRjjJAcD6ft6I+cRG7Vvsu9e+4GbTRarFhE5L4pknDI6cMGHJdNVYxDZ9NICUwGQZYlOfX/U75q0AgktAELp9poakNEo8iDTw9puczKKIzsX7vAYeb9I6m6EM2ap/l1FZ8VfYc3ZCcBLoCv6R1Iqd0aWpLSkdjKiPt/u1ejo2G63vcMXOeUeftm1IBDEJKmWz6T2oQWOyER9PDcaRh6+6sr3UqdaCDZAK3fdR0wXduCPDJjqYlsN0rx2VT2gUZzoVNNHiCKeR2NGqkVzU0MqP39cz+5zcWrlp9oxNJAsiMQhHbjPKdfimMEjT4en/t/qLXWe9wWPgbv60lCqteJHR5rOwHYw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(44832011)(2906002)(5660300002)(26005)(83380400001)(38100700002)(45080400002)(6636002)(478600001)(6486002)(6512007)(316002)(966005)(6666004)(9686003)(6506007)(66556008)(66476007)(53546011)(66946007)(34206002)(8676002)(41300700001)(8936002)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yG9x1/xMRpgoGdnzjKk23ikXEReLlk6JJ/8JWgybjIxzkSy/2EXIPhXzOCHM?=
 =?us-ascii?Q?YfJLZNe8EgJHeTYhM89yfdLQYIdTT10+gWchKhJPMfEmRqD+joSaUheYQmYd?=
 =?us-ascii?Q?fIfTe46HlyT0j6xGm1qcIAZ5dcSKXTU9KNmXg1zmf6AvgHL5D5i8HuivWOVU?=
 =?us-ascii?Q?+HLpqJ/LxrK7Yys9/ErRgCznupeLk9dNfuhasOmlaiLjAdMtmxOM5DuxrRjc?=
 =?us-ascii?Q?uMLq9eBxBb4AaGe5vK8qiICPPQlLa/9NmbH5WSXc670hd4FHlh1QyxMrIRWq?=
 =?us-ascii?Q?KpjgH9rd8/Khq7hdER3Imyims7QdAjbhHrZsFaqLKxL2kXkYmYGl2dPgh+ee?=
 =?us-ascii?Q?496jg0CvKeTgowDGi6H3HixepegnhmZjV2jc95K60yU/O4I3dtX5Qstwot/+?=
 =?us-ascii?Q?twpRt68ZlbeqeuHrRk/fzxiKDH7cgmtfG+a0Jo10QgYbcF98ziz8vIrZROiD?=
 =?us-ascii?Q?I8+6tzJXsvZiOKwz1hLP22+sBxRemffA1YPJ0hAKmewwrk3bPVfdP5uTJCLc?=
 =?us-ascii?Q?bgdtUK75Zbt4HH4lVspWdLEwYzktqh8Y56ageTj6uTcNsbNLqJ0/8xmKEC+h?=
 =?us-ascii?Q?45qBy2sWUmKiFrBYk9xxwvdZ6cIzl+6faCrud4EqqHdS7JQoygHlBJw37v4p?=
 =?us-ascii?Q?RhpJUs1D2+JJvLkT6SEjODFrLaiWhAadaoQuchDgCPSgxMLaxMSs3nzCp5nP?=
 =?us-ascii?Q?Sp1Kx43BTTje2E/YAp7OPD5LBPL/DKnsjLFvZYqtUhcbwQYzdtJl926jRhoH?=
 =?us-ascii?Q?zkyHPT5p4LYKVC1MPRB26R7YFAWOlnI3V7kJdN+mbfCbVEdhsEfDS/92lPAe?=
 =?us-ascii?Q?DG+f+KN0B5pYXDQyTib7v/90Hj/z+6xGAk4hdEt0nrATKf1BRr29xaU1JkpF?=
 =?us-ascii?Q?+4ETct+RoR7MB0+ySgSYDlJinOqw18Tl1icCDHIIxpNg4WfUtO1U/aVzgaMq?=
 =?us-ascii?Q?kobTFl1N4S8w6S5jSWdQUxUIjWgxyLatAv1HVRm2eOtg4UajBVJJL0wHnXW3?=
 =?us-ascii?Q?vgvt8KYmYW+VpVgv50m4LvF/SjWVBVfkE7+TFnx3sD2t0O6l86b+vwkCqynF?=
 =?us-ascii?Q?prXvwqmj+Zs+v5OlIDVePBSRIPUAjY9G7j6NC5QhUgBWnCsh4MwAZ+6OpnIC?=
 =?us-ascii?Q?3USx2m1LNLsIQSz3vIcMeMtp5hEXe1LEpQx1F0z70hh3D/AdA/NpffRgGfkT?=
 =?us-ascii?Q?DXJiSVNdp9pbnF2E0N1kLuqf4BjustSIrNtTVXfVrIwIuFB0+5PcyqTDukc4?=
 =?us-ascii?Q?NsC/yjeQMMZZhPeuKXZxzgz5yTWDJrV+YEy2hppUJBj1oNm1roudokgT9rvG?=
 =?us-ascii?Q?6vuIFc0s8Xlc68Qx4IxvWf36AJbAUX3w3/IjFvssWhF8SJ0tpvm/6bbtuvVz?=
 =?us-ascii?Q?j+PkByjYvcozEDaYw3WY5Fb1ZW3Wk6DTD7W5fp0diQ1mC2F+fZ+pO/nvZtt1?=
 =?us-ascii?Q?+pkZO5oCKgZpI8EW28r31IyH3XmHBAbHOrJBFck0NybZ5B9ZpRWAlhEjH9zM?=
 =?us-ascii?Q?EHsNHOSEuz7/ZTff7raXOsURoDQ89J8/E2PGbjZp7QERF/jcHA+860I/Kh9F?=
 =?us-ascii?Q?gOnhpdc7braGIqs/vyfxl10EohNijF1WzvNzEoC89Pt7zFeQ7ukjglha9KSW?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lG6SWn+a3Hg+gLI+4Y4IhyNRH97l/cLjubjtcShE9nZfqtm3HvljsAqZPnd5xl3aA/VzyjB45XoFVKwt/Zg3Ok+63UyqfatuwCqhlVk1kr/sk+V2f1eYguB7KJ+oHEh7BdHkaIbTY7saVqUSGZnw03mdTdY3Hu3V6q++FyTury2OtGNSqtSdbjnQJCKCYRozECywttLGR7sP43QR/s/UbsSiVjUgD+FHnwShbHg1yfDjM7SObyby9MFG/ATKaXtsU+BTk2BTwILoj9A50wgFZTOY1k5N/N0I61k3l3FMoQZznyC9zPFPKILpEL4j0QMHIw1WnX6El37SkdaHwSnqpnsxQL6uvRyEx1D/hRRMBHWjmI6xj/0MAW2a2uqNdfEXzC9b4s4mpG8d+03XNgj5a7RZerwfnqhS/Nil0ps8fCSv4t9s5TbnsiJZDzO86zjJx08U2e+mYYcyHhVLOeHpehyyTNw3fAnkxm4Eg/wLXYVH+Tt+5wxbi3YViAs20nFW6ctUIHVXHFyC7bqQOVD8k9tbEK6fEn35tE8bBDrt4NaT7Kd9kApLJK1iP2kNBJ1SWnDbTvtUvTvHSGon6Bddbm9r94DPEbqFKOtbzWpaLrE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f825801e-8a36-4e6f-f379-08dc30014a0a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 21:42:07.5711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCicO6p8kg/68mZUXdlGmesHTgsD2tb6dgt069YfoZrbuMzFCnoSexRSWqIguZbFhCu/mmdYhlVZ1lh4EuBrmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6968
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_20,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402170179
X-Proofpoint-GUID: 2d9JtPbxn_osETFVYWPkfjetyWdDWRIX
X-Proofpoint-ORIG-GUID: 2d9JtPbxn_osETFVYWPkfjetyWdDWRIX

On Sat, Feb 17, 2024 at 01:27:15PM -0800, dai.ngo@oracle.com wrote:
> 
> On 2/17/24 1:09 PM, Chuck Lever wrote:
> > On Sat, Feb 17, 2024 at 10:00:59AM -0800, Dai Ngo wrote:
> > > When the number of granted delegation becomes large, there are some
> > > undesire effects happen on the NFS server. Besides the consumption
> > > of system resources, the number of entries on the linked lists of the
> > > file cache can grow significantly.
> > > 
> > > When this condition happens, the NFS performace grounds to a halt as
> > > reported here [1].
> > That was a v5.15.131 kernel. The LRU problems were addressed in
> > v6.2. This doesn't seem like a clean rationale for adding this
> > reaper behavior in, say, v6.9.
> 
> Do you know what commits in v6.9 fix this problem?

The filecache LRU issues were addressed in v6.2 and before.


> Regardless, I think when the number of delegations is getting large,
> it's good to ask the clients to release unused delegations. The
> Linux client keeps unused delegations for about ~90 secs before
> returning them.

That seems reasonable. No need for the server to ask for them back
unless it is under some stress.


> > > This patch attempts to alleviate this problem by asking the clients to
> > > voluntarily return any unused delegations when the number of delegation
> > > reaches 3/4 of the max_delegations by sending OP_CB_RECALL_ANY to all
> > > clients that hold delegations.
> > I don't have a strong sense of how big max_delegations can get. Is
> > there evidence that CB_RECALL_ANY has enough impact, reliably, to
> > reduce the size of the filecache?
> 
> I don't have any numbers for this. But in my testing, the Linux client
> returns unused delegations immediately when receiving the CB_RECALL_ANY
> instead of keeping them ~90 secs.

The issue is whether returning delegations in bulk has any impact on
filecache behavior. I'd like to see some evidence of that, because
after v6.2 I think NFSD's filecache shouldn't be perturbed by lots of
open files.


> > More below.
> > 
> > 
> > > [1] https://lore.kernel.org/all/PH0PR14MB5493F59229B802B871407F9CAA442@PH0PR14MB5493.namprd14.prod.outlook.com
> > > 
> > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > ---
> > >   fs/nfsd/nfs4state.c | 9 +++++++++
> > >   1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index fdc95bfbfbb6..5fb83853533f 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -130,6 +130,7 @@ static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
> > >   static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
> > >   static struct workqueue_struct *laundry_wq;
> > > +static void deleg_reaper(struct nfsd_net *nn);
> > >   int nfsd4_create_laundry_wq(void)
> > >   {
> > > @@ -696,6 +697,9 @@ static struct nfsd_file *find_any_file_locked(struct nfs4_file *f)
> > >   static atomic_long_t num_delegations;
> > >   unsigned long max_delegations;
> > > +/* threshold to trigger deleg_reaper */
> > > +static unsigned long delegations_soft_limit;
> > > +
> > >   /*
> > >    * Open owner state (share locks)
> > >    */
> > > @@ -6466,6 +6470,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> > >   	struct nfs4_cpntf_state *cps;
> > >   	copy_stateid_t *cps_t;
> > >   	int i;
> > > +	long n;
> > >   	if (clients_still_reclaiming(nn)) {
> > >   		lt.new_timeo = 0;
> > > @@ -6550,6 +6555,9 @@ nfs4_laundromat(struct nfsd_net *nn)
> > >   	/* service the server-to-server copy delayed unmount list */
> > >   	nfsd4_ssc_expire_umount(nn);
> > >   #endif
> > > +	n = atomic_long_inc_return(&num_delegations);
> > I don't think you want to modify the number of delegations here.
> > atomic_long_read() instead?
> 
> Right, it's a typo, it should be a read.
> 
> > 
> > 
> > > +	if (n > delegations_soft_limit)
> > This introduces a mixed-sign comparison: n is a long, but
> > delegations_soft_limit is an unsigned long. I'm always suspicious
> > about whether an atomic counter can underflow, and then we have
> > real problems when there are mixed-sign comparisons.
> 
> Yes, n should be unsigned long.
> 
> > 
> > But I'm also wondering if, instead, this logic should look directly
> > at the length of the filecache LRU.
> 
> Is there a quick check; counter? otherwise if we have to walk the
> list then it just compounds the problem.

Yep:

	list_lru_count(&nfsd_file_lru)

That doesn't really tell us whether those LRU items are pinned by a
delegation, though, hm. Just thinking out loud.


> > > +		deleg_reaper(nn);
> > >   out:
> > >   	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
> > >   }
> > > @@ -8482,6 +8490,7 @@ set_max_delegations(void)
> > >   	 * giving a worst case usage of about 6% of memory.
> > >   	 */
> > >   	max_delegations = nr_free_buffer_pages() >> (20 - 2 - PAGE_SHIFT);
> > > +	delegations_soft_limit = (max_delegations / 4) * 3;
> > I don't see a strong reason to keep delegations_soft_limit as a
> > separate variable.
> 
> Just to save some CPU cycles for not to recompute the soft limit every time.
> However, since this is done in the laundromat then it probably not that
> critical. Also recompute the soft limit will work correctly if the max_delegations
> is changed dynamically.
> 
> -Dai
> 
> > 
> > 
> > >   }
> > >   static int nfs4_state_create_net(struct net *net)
> > > -- 
> > > 2.39.3
> > > 

-- 
Chuck Lever

