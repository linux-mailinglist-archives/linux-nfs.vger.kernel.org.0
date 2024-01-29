Return-Path: <linux-nfs+bounces-1549-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D588407CE
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 15:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA522813F9
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D2C657C2;
	Mon, 29 Jan 2024 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ThpW1vyn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aL1aNPzf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BC5657D4
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537110; cv=fail; b=Os1aMZws4r2KdhDHNi7t34P9Yec1jv5m5Q/wHkSLfrwoDAzEDaJfztovm0NbzRfnYa2V3+f5M5ZJ3mnOYgqIBFvsUzcxGxTXUQ+EVS6haa4ZyR+n5Xj+dzLrLGUPRNOO3xFjoKCYx3ilO2MBHmRZrHt58CwzQwNYuRUh/3eY9AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537110; c=relaxed/simple;
	bh=R6hJRJdVd/PwFgEC0tzNBEopyWIqKBOljUCnHWw4pEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rHvOkxfmzV50mdOTdae1V/n5fRqzRyo6qpVbHEO/prFWj/Kp/CHSxZt9VSU/BeMK/RexM6joijthN9wmrCk8hHC3RfdWdpqxR04RCq3zn1cAO8UtrcJxISN5Xp5f15rMMomCvyxROH7UTQcLbThMgetnE0Lc5OenGWWw98uWImY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ThpW1vyn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aL1aNPzf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40T9iYZ4021936;
	Mon, 29 Jan 2024 14:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=ZMtHOvkNf8fMcI0j4p1UNjKHyGj+ADmBujG9xiMo/IQ=;
 b=ThpW1vyneQYJNk8lKkkLqBuFwNDynsQUEeJudtynICgQK+H2WDBciwSFiHnkMN4pYzB0
 K/jVxmrd4LXVrefk1CxhUNoz7hng/JXBS27/DxobH+zMnBB+PZSeQljS3gYa791VXytx
 eKGHPf4t9e9Ns6Y/Ud79+3NseQk3cMcX7ELh9B7gNaV32WR9Btw9CEyNdV7ZHSD3u28W
 Gkyy57tZm3V+xY6CQklDG2/pzEbDwRzaHnl4wAbLp4a4ACBhH3rdJ+fdEn//38CnNU4u
 wTNVIQhLF/Aj01FIdK/A487fDfKAuSyLjxuC0sVzPYh9GuPO8oj8kyBoEP+R6bE62XX/ yw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrrcbyvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 14:04:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TDNHXe031388;
	Mon, 29 Jan 2024 14:04:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr95wmju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 14:04:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0gqQk1bWNwUpy8tlqPPHzENWOyE9QnUB4IarkUvcOEYIkQVVNFxAbf/LhJUOn7HFoNBtZqZOdTAN3VUfOWs7v7j48mTPCFH5HieKGCeEskUGv8MeP28WFZeYEekyjQZImiuaaR/whl4xVjGCLNLM35Fd/79viQrBrPayTdIXAMGDlz4BXpA56df7cX0fFYCGSOW28k4RBDg6rfB7920tHOK0+nE9dhfT64bQKvO81wO0ykFrkZdo4GvVlTjjyeqCvssoufFVYR2T//r8yc3+583JQJLi739g1xc+2tY9BO7W8UVay+CcvMyfFRfhKH4f01aLW82mkFdcflaD7yLWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMtHOvkNf8fMcI0j4p1UNjKHyGj+ADmBujG9xiMo/IQ=;
 b=GLmB4+tXUfdp40+2NBMzJh/fTMtgrg4AKhx53t/oKOlk+30729YQ3x3ojRkjLSgRFJ3KGt+CWHFX1a0Gl0QhUqOHgqLWgRMJfDdIx2RU+/C00VNH3kUV2GCQ0633gcJhoqQdaa1Fl3x4/3JIRMJOfcDSkcNPHko1IpPgbqAmR5d8b3a6xELfZOLBFeRF5X97xYAgAQnIFMKG39NaqHr48yOQALCxNeqAG0xJPokChYafVld9cair8wIjnsMFS5wqeoTfsbEzb9/uBfIvBKz9V/lSQVJT1QcBssZYdiYXNX+x1AAsM89H+PyrkbSGi1oi/mtX2QjOSJ8KBRyhBnWT7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMtHOvkNf8fMcI0j4p1UNjKHyGj+ADmBujG9xiMo/IQ=;
 b=aL1aNPzf+9k3L12VbUyIN4ojjHrAYMNxJ1/8eXYJbzzrYU0q1Nc8PBd7C+iI10+0Js4J3OAfTXu1i4olOIZ1hfv1tB8AadVQH1uTIQCKe/C6alsJCh1Fzt86pGra62iSTXvouKSZyW9Ioju8WQ+tZ6VP/6+f1v/rQqob3qC9GO8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4926.namprd10.prod.outlook.com (2603:10b6:5:3ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 14:04:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%6]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 14:04:44 +0000
Date: Mon, 29 Jan 2024 09:04:41 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Christoph Hellwig <hch@lst.de>,
        Tom Haynes <loghyr@gmail.com>
Subject: Re: [PATCH 05/13] nfsd: split sc_status out of sc_type
Message-ID: <ZbeweYmp/HeGr5tN@tissot.1015granger.net>
References: <20240129033637.2133-1-neilb@suse.de>
 <20240129033637.2133-6-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129033637.2133-6-neilb@suse.de>
X-ClientProxiedBy: CH2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:610:20::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: ed99d2b6-dcfd-472c-bd22-08dc20d33eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	n+UhSSii0qiH6Q6nsLWldj0Et7UxIGYkX6L7L5+/gkNKV1MmvJkleS6qk0/lbWy1oYfUmUKN6MQezsqWpAkEzlyFxx0LHf+fakqITETacxUYzY+hY9cTGQTLtc+4aX4I4/AFIK4Ns53Fh8YGtn/mGpm7eBauDm3NXfIlF0e5HHTU7b4HiaBr6xDLuDOtUXHhm5bGlGeZMjwPU/NGGRDHYaZrY8m/wrZTUuZuo40ltIXUmb0waq5tivy+UGigBySYE6ILQzBLmT5KjA/f3zI8v4DT4LOZ4+k/lqBbUN/H5n4LhIt2QMfR9F6WTVxnezIPSYQX2Cx/gbSbcCnpIj2io0/uFsfwF73QWKGjKFz55DCpDn86WZEGQ0bQgpXs3R5XDYx40s3VDEZ6+CdeYWdHPGyRD7qyZOa8lDV2MaF0UlA/mRQENaBequFjqXNCt+2L8fuoJeSx3Lu6E2+A4mY4U5v3ENI7QQVEgkpHOiG92DTku9ioA7gBTh75P5aNIrHn2qB/DXHz4eVtuvTF4owjPiNWWZeDdIAlfAcdhg17GaafFD6tBdUIw+VM34jXvpUGAWMDVUQtQT3tZ40ka1/04Xw8BumkY2GLOLvacll59Lg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(83380400001)(86362001)(66556008)(9686003)(6512007)(38100700002)(26005)(6916009)(6486002)(6506007)(2906002)(5660300002)(478600001)(30864003)(41300700001)(6666004)(316002)(66476007)(54906003)(66946007)(4326008)(44832011)(8676002)(8936002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2SjliT0jdbA6kp/VUwCdktTDnDSHYA45VQupkdhGzqh07c46GEZZ/wHyZhoU?=
 =?us-ascii?Q?RfvtpqpHohsWzBkFuvT8xRRtCOuG2CJg0JjrjOKFNkRdiDJztQlYIuqNIBXu?=
 =?us-ascii?Q?U9vT8ZyZFcq6lIOMJxLBlEPL7I87RP54pQPIPKuve8JRodAnbYi29CBkZT39?=
 =?us-ascii?Q?eyNXshApkd5rmf5Z5uvTr3eraelbC5nXXYPaQCe0FSupDhIswIGXS5OrRnUw?=
 =?us-ascii?Q?6UU2+WwmhNBYaIdq78RPruZab9nVZNPjOcnhqKn+v+5ZirZ4TdE48USa7jyJ?=
 =?us-ascii?Q?/dVKiP9UGGwaGKZejVs8kjkqpDJA+Lke3DsxKVt24NV0Sj5fBkU+EBNxw42H?=
 =?us-ascii?Q?BHVRTk7je9KOXvYTPTnlL3/zubDf5Rq4aH2fEEahv3ZcSRjj5BmRka6SBQ9K?=
 =?us-ascii?Q?CVxHaIgOuEzT9ioPEUclRiqGKydOB9xtOsQ+evZlrXUiq4qDhx5wVdgz2kPN?=
 =?us-ascii?Q?wkrZk4rw3D2PtqqLW0g1oRe15mv4VA7tGHNV3/HAbREpbOLVEBzlmGmGCMsV?=
 =?us-ascii?Q?GR6F7YZU/lcht276c6EvYtZd3I9cihdK4wyS2jmSvAGtVQFCA0OF+YDpA17P?=
 =?us-ascii?Q?ESM6ibYxCQo1U2zH0WFCwbgSkrujl2llY45UtmLLS7JNbM4YmSQ07emvqkvt?=
 =?us-ascii?Q?roZA013vDctQBssVS9RAlcNa1nvOS67xtBmo8cxwS0iDeKnSMYYcksSXA5uD?=
 =?us-ascii?Q?3lG926CtBEPGZdbwCud0qQrFqL4X1JkqYiAxxGep9XCjBl1ZxGljy0pdzmHQ?=
 =?us-ascii?Q?on+Y7RDqBQZfyP8geWaFsNJdqx1ylAJjrpmxld078gVlKV93w90e/qNk0rTt?=
 =?us-ascii?Q?x8Hm9mANuDnynWbuMXce4WJWcRuj+EaL0t+rpwsp2rhfnrNyV5SkB7DDQLtv?=
 =?us-ascii?Q?b7pVYMZn3vxhDEeexvlwO4i6E4COPLW7mxeKq8+rcsnXmoeYr19JwrTIcd64?=
 =?us-ascii?Q?ApyTOzkC7AMATf9jTiANilCTb4/pi0pgRWEEWiv0Hp0iZQhGwQvatnKN+VAp?=
 =?us-ascii?Q?rhkh017Wg34pH1mq/mZLwSZh+AtBnofVIF6y7dtN9Oe3ONKdOjkPzNelymTz?=
 =?us-ascii?Q?6XXwRPTfRLA6c3tXZtJ9GVv51w18Jy+i+pLx1rTodbsvE81bGW/0oY7O8h8d?=
 =?us-ascii?Q?+Nn6V9M55buh9ePLq/R4MOcpcu1F9gGtura76Ly6zXu4L6KmFPaLhwJWSDMC?=
 =?us-ascii?Q?bJ5VNovwTU5qDwlNAx7TDpTcFWimQ+O8ewsGFxHLbkj5MpGojObRsOXYIlDC?=
 =?us-ascii?Q?CoQ8SoD0f7Cql1VDytgneL453S0rqnuvAAVRhXXEmQ/QF7Ll4Syc4U1pGNmf?=
 =?us-ascii?Q?tBRqJb0LLtxk4fFwLnURCRmJiWNyjfnT4AyoNbeTCZqmb2614jncI97u6aks?=
 =?us-ascii?Q?2RMvLc+7jcQyeCTwzWUAVetfk2bjCU5CzIGC8ak+JnxdKw/4z7822VFdLv5d?=
 =?us-ascii?Q?8RFqUxwiCKBijNE1UYQeVI1Uix2H5q3uTJH8RFzF0a/TeyT7OTYkatfhl4WE?=
 =?us-ascii?Q?6JuT0yrBdwVvu8MEietbiYijk2m7FWniDngpCcyAx7b5CWMvQeKwhPXX10hr?=
 =?us-ascii?Q?OoEtL87Q4NQro/SCUG4AIzSNl9N04M63VN0NssE6zIjZDIl4PsUbo5KyiKK3?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7FLGTTkhasjoQhGhaU1qbYuP/yeMoAnXhrXFgcQ+DpDxBccNIhiz1QcBj7JQw+L/Qb0sADo4BZ1xPd2Y0tF+FWIuRXI/GncQv7uCFgdP/pA3HwGvdZ+q7TBUzsVCtPSYL6FqgtWkLDrAi5kVuJe5diJJ8r8XgZ/iOZLXnjGfUoBxQiVeq472en4TVObNv3uEPBzFHFRYGBJA0xr/A0pE1jOwUY85hddru+j+43ty0DG85xOayuH99SRBGE83k7ilfQa3qIOFY4nMuag0B6pQYpK3kBLxBYeoZIltmAoUHlg6kqW9e4qlouqsrHn0YUo04dV3Gg0pSVpVR6kIhszBFS/LRMkkaPWk4vV1EA3Q9XUKObvZXnFIY7qPOEwNhvs10xbZLmN6BFLlQWtDCkyKHVuFeUHKDHAblPsfx2ZZOvGbjbJr4OBZ1joCRrenE7MFNwgShn4qB1cYJLIohjeVQaVymKK99GzuOtnUKA6wO3/6rMjBQ26WPcxoVzAA/SyJEMq1MCui2vLVummt4qAgzLzDWbs8fWb++oN/fjzw0CX68HY52G9fnNbSfZ44dJ51SHq4xiv1uuNw46TGW67e6P23JDCFpB74n0eY2gz3NFw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed99d2b6-dcfd-472c-bd22-08dc20d33eb5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 14:04:44.3380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNc60UgzWewwwg/e0eBjV3P7Tg76Tja3YIST2WHW7jIYpD0XlfRkNEuu8iW2ErjTY/tLlrq3FArs/66lE9dlLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4926
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_07,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290103
X-Proofpoint-ORIG-GUID: 1bUdLElAvFdsLi5Bjj1VY0-BoQ6FDzMT
X-Proofpoint-GUID: 1bUdLElAvFdsLi5Bjj1VY0-BoQ6FDzMT

On Mon, Jan 29, 2024 at 02:29:27PM +1100, NeilBrown wrote:
> sc_type identifies the type of a state - open, lock, deleg, layout - and
> also the status of a state - closed or revoked.
> 
> This is a bit untidy and could get worse when "admin-revoked" states are
> added.  So clean it up.
> 
> With this patch, the type is now all that is stored in sc_type.  This is
> zero when the state is first added to ->cl_stateids (causing it to be
> ignored), and is then set appropriately once it is fully initialised.
> It is set under ->cl_lock to ensure atomicity w.r.t lookup.  It is now
> never cleared.
> 
> sc_type is still a bit-set even though at most one bit is set.  This allows
> lookup functions to be given a bitmap of acceptable types.
> 
> sc_type is now an unsigned short rather than char.  There is no value in
> restricting to just 8 bits.
> 
> All the constants now start SC_TYPE_ matching the field in which they
> are stored.  Keeping the existing names and ensuring clear separation
> from non-type flags would have required something like
> NFS4_STID_TYPE_CLOSED which is cumbersome.  The "NFS4" prefix is
> redundant was they only appear in NFS4 code, so remove that and change
> STID to SC to match the field.
> 
> The status is stored in a separate unsigned short named "sc_status".  It
> has two flags: SC_STATUS_CLOSED and SC_STATUS_REVOKED.
> CLOSED combines NFS4_CLOSED_STID, NFS4_CLOSED_DELEG_STID, and is used
> for SC_TYPE_LOCK and SC_TYPE_LAYOUT instead of setting the sc_type to zero.
> These flags are only ever set, never cleared.
> For deleg stateids they are set under the global state_lock.
> For open and lock stateids they are set under ->cl_lock.
> For layout stateids they are set under ->ls_lock
> 
> nfs4_unhash_stid() has been removed, and we never set sc_type = 0.  This
> was only used for LOCK and LAYOUT stids and they now use
> SC_STATUS_CLOSED.
> 
> Also TRACE_DEFINE_NUM() calls for the various STID #define have been
> removed because these things are not enums, and so that call is
> incorrect.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4layouts.c |  14 +--
>  fs/nfsd/nfs4state.c   | 207 +++++++++++++++++++++---------------------
>  fs/nfsd/state.h       |  40 +++++---
>  fs/nfsd/trace.h       |  31 +++----
>  4 files changed, 151 insertions(+), 141 deletions(-)

This one doesn't apply cleanly to nfsd-next. Can you do a quick
rebase onto nfsd-next and send a fresh version of the series?


> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index 5e8096bc5eaa..857b822450b4 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -236,7 +236,7 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
>  	nfsd4_init_cb(&ls->ls_recall, clp, &nfsd4_cb_layout_ops,
>  			NFSPROC4_CLNT_CB_LAYOUT);
>  
> -	if (parent->sc_type == NFS4_DELEG_STID)
> +	if (parent->sc_type == SC_TYPE_DELEG)
>  		ls->ls_file = nfsd_file_get(fp->fi_deleg_file);
>  	else
>  		ls->ls_file = find_any_file(fp);
> @@ -250,7 +250,7 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
>  	}
>  
>  	spin_lock(&clp->cl_lock);
> -	stp->sc_type = NFS4_LAYOUT_STID;
> +	stp->sc_type = SC_TYPE_LAYOUT;
>  	list_add(&ls->ls_perclnt, &clp->cl_lo_states);
>  	spin_unlock(&clp->cl_lock);
>  
> @@ -269,13 +269,13 @@ nfsd4_preprocess_layout_stateid(struct svc_rqst *rqstp,
>  {
>  	struct nfs4_layout_stateid *ls;
>  	struct nfs4_stid *stid;
> -	unsigned char typemask = NFS4_LAYOUT_STID;
> +	unsigned short typemask = SC_TYPE_LAYOUT;
>  	__be32 status;
>  
>  	if (create)
> -		typemask |= (NFS4_OPEN_STID | NFS4_LOCK_STID | NFS4_DELEG_STID);
> +		typemask |= (SC_TYPE_OPEN | SC_TYPE_LOCK | SC_TYPE_DELEG);
>  
> -	status = nfsd4_lookup_stateid(cstate, stateid, typemask, &stid,
> +	status = nfsd4_lookup_stateid(cstate, stateid, typemask, 0, &stid,
>  			net_generic(SVC_NET(rqstp), nfsd_net_id));
>  	if (status)
>  		goto out;
> @@ -286,7 +286,7 @@ nfsd4_preprocess_layout_stateid(struct svc_rqst *rqstp,
>  		goto out_put_stid;
>  	}
>  
> -	if (stid->sc_type != NFS4_LAYOUT_STID) {
> +	if (stid->sc_type != SC_TYPE_LAYOUT) {
>  		ls = nfsd4_alloc_layout_stateid(cstate, stid, layout_type);
>  		nfs4_put_stid(stid);
>  
> @@ -518,7 +518,7 @@ nfsd4_return_file_layouts(struct svc_rqst *rqstp,
>  		lrp->lrs_present = true;
>  	} else {
>  		trace_nfsd_layoutstate_unhash(&ls->ls_stid.sc_stateid);
> -		nfs4_unhash_stid(&ls->ls_stid);
> +		ls->ls_stid.sc_status |= SC_STATUS_CLOSED;
>  		lrp->lrs_present = false;
>  	}
>  	spin_unlock(&ls->ls_lock);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index dbf9ed84610e..6bccdd0af814 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1260,11 +1260,6 @@ static void destroy_unhashed_deleg(struct nfs4_delegation *dp)
>  	nfs4_put_stid(&dp->dl_stid);
>  }
>  
> -void nfs4_unhash_stid(struct nfs4_stid *s)
> -{
> -	s->sc_type = 0;
> -}
> -
>  /**
>   * nfs4_delegation_exists - Discover if this delegation already exists
>   * @clp:     a pointer to the nfs4_client we're granting a delegation to
> @@ -1317,7 +1312,7 @@ hash_delegation_locked(struct nfs4_delegation *dp, struct nfs4_file *fp)
>  	if (nfs4_delegation_exists(clp, fp))
>  		return -EAGAIN;
>  	refcount_inc(&dp->dl_stid.sc_count);
> -	dp->dl_stid.sc_type = NFS4_DELEG_STID;
> +	dp->dl_stid.sc_type = SC_TYPE_DELEG;
>  	list_add(&dp->dl_perfile, &fp->fi_delegations);
>  	list_add(&dp->dl_perclnt, &clp->cl_delegations);
>  	return 0;
> @@ -1329,7 +1324,7 @@ static bool delegation_hashed(struct nfs4_delegation *dp)
>  }
>  
>  static bool
> -unhash_delegation_locked(struct nfs4_delegation *dp, unsigned char type)
> +unhash_delegation_locked(struct nfs4_delegation *dp, unsigned short statusmask)
>  {
>  	struct nfs4_file *fp = dp->dl_stid.sc_file;
>  
> @@ -1339,8 +1334,9 @@ unhash_delegation_locked(struct nfs4_delegation *dp, unsigned char type)
>  		return false;
>  
>  	if (dp->dl_stid.sc_client->cl_minorversion == 0)
> -		type = NFS4_CLOSED_DELEG_STID;
> -	dp->dl_stid.sc_type = type;
> +		statusmask = SC_STATUS_CLOSED;
> +	dp->dl_stid.sc_status |= statusmask;
> +
>  	/* Ensure that deleg break won't try to requeue it */
>  	++dp->dl_time;
>  	spin_lock(&fp->fi_lock);
> @@ -1356,7 +1352,7 @@ static void destroy_delegation(struct nfs4_delegation *dp)
>  	bool unhashed;
>  
>  	spin_lock(&state_lock);
> -	unhashed = unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
> +	unhashed = unhash_delegation_locked(dp, SC_STATUS_CLOSED);
>  	spin_unlock(&state_lock);
>  	if (unhashed)
>  		destroy_unhashed_deleg(dp);
> @@ -1370,7 +1366,7 @@ static void revoke_delegation(struct nfs4_delegation *dp)
>  
>  	trace_nfsd_stid_revoke(&dp->dl_stid);
>  
> -	if (dp->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID) {
> +	if (dp->dl_stid.sc_status & SC_STATUS_REVOKED) {
>  		spin_lock(&clp->cl_lock);
>  		refcount_inc(&dp->dl_stid.sc_count);
>  		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
> @@ -1379,8 +1375,8 @@ static void revoke_delegation(struct nfs4_delegation *dp)
>  	destroy_unhashed_deleg(dp);
>  }
>  
> -/* 
> - * SETCLIENTID state 
> +/*
> + * SETCLIENTID state
>   */
>  
>  static unsigned int clientid_hashval(u32 id)
> @@ -1543,7 +1539,7 @@ static bool unhash_lock_stateid(struct nfs4_ol_stateid *stp)
>  	if (!unhash_ol_stateid(stp))
>  		return false;
>  	list_del_init(&stp->st_locks);
> -	nfs4_unhash_stid(&stp->st_stid);
> +	stp->st_stid.sc_status |= SC_STATUS_CLOSED;
>  	return true;
>  }
>  
> @@ -1622,6 +1618,7 @@ static void release_open_stateid(struct nfs4_ol_stateid *stp)
>  	LIST_HEAD(reaplist);
>  
>  	spin_lock(&stp->st_stid.sc_client->cl_lock);
> +	stp->st_stid.sc_status |= SC_STATUS_CLOSED;
>  	if (unhash_open_stateid(stp, &reaplist))
>  		put_ol_stateid_locked(stp, &reaplist);
>  	spin_unlock(&stp->st_stid.sc_client->cl_lock);
> @@ -2230,7 +2227,7 @@ __destroy_client(struct nfs4_client *clp)
>  	spin_lock(&state_lock);
>  	while (!list_empty(&clp->cl_delegations)) {
>  		dp = list_entry(clp->cl_delegations.next, struct nfs4_delegation, dl_perclnt);
> -		unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
> +		unhash_delegation_locked(dp, SC_STATUS_CLOSED);
>  		list_add(&dp->dl_recall_lru, &reaplist);
>  	}
>  	spin_unlock(&state_lock);
> @@ -2462,14 +2459,16 @@ find_stateid_locked(struct nfs4_client *cl, stateid_t *t)
>  }
>  
>  static struct nfs4_stid *
> -find_stateid_by_type(struct nfs4_client *cl, stateid_t *t, char typemask)
> +find_stateid_by_type(struct nfs4_client *cl, stateid_t *t,
> +		     unsigned short typemask, unsigned short ok_states)
>  {
>  	struct nfs4_stid *s;
>  
>  	spin_lock(&cl->cl_lock);
>  	s = find_stateid_locked(cl, t);
>  	if (s != NULL) {
> -		if (typemask & s->sc_type)
> +		if ((s->sc_status & ~ok_states) == 0 &&
> +		    (typemask & s->sc_type))
>  			refcount_inc(&s->sc_count);
>  		else
>  			s = NULL;
> @@ -2622,7 +2621,7 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
>  	struct nfs4_stateowner *oo;
>  	unsigned int access, deny;
>  
> -	if (st->sc_type != NFS4_OPEN_STID && st->sc_type != NFS4_LOCK_STID)
> +	if (st->sc_type != SC_TYPE_OPEN && st->sc_type != SC_TYPE_LOCK)
>  		return 0; /* XXX: or SEQ_SKIP? */
>  	ols = openlockstateid(st);
>  	oo = ols->st_stateowner;
> @@ -2754,13 +2753,13 @@ static int states_show(struct seq_file *s, void *v)
>  	struct nfs4_stid *st = v;
>  
>  	switch (st->sc_type) {
> -	case NFS4_OPEN_STID:
> +	case SC_TYPE_OPEN:
>  		return nfs4_show_open(s, st);
> -	case NFS4_LOCK_STID:
> +	case SC_TYPE_LOCK:
>  		return nfs4_show_lock(s, st);
> -	case NFS4_DELEG_STID:
> +	case SC_TYPE_DELEG:
>  		return nfs4_show_deleg(s, st);
> -	case NFS4_LAYOUT_STID:
> +	case SC_TYPE_LAYOUT:
>  		return nfs4_show_layout(s, st);
>  	default:
>  		return 0; /* XXX: or SEQ_SKIP? */
> @@ -4532,7 +4531,8 @@ nfsd4_find_existing_open(struct nfs4_file *fp, struct nfsd4_open *open)
>  			continue;
>  		if (local->st_stateowner != &oo->oo_owner)
>  			continue;
> -		if (local->st_stid.sc_type == NFS4_OPEN_STID) {
> +		if (local->st_stid.sc_type == SC_TYPE_OPEN &&
> +		    !local->st_stid.sc_status) {
>  			ret = local;
>  			refcount_inc(&ret->st_stid.sc_count);
>  			break;
> @@ -4546,17 +4546,10 @@ nfsd4_verify_open_stid(struct nfs4_stid *s)
>  {
>  	__be32 ret = nfs_ok;
>  
> -	switch (s->sc_type) {
> -	default:
> -		break;
> -	case 0:
> -	case NFS4_CLOSED_STID:
> -	case NFS4_CLOSED_DELEG_STID:
> -		ret = nfserr_bad_stateid;
> -		break;
> -	case NFS4_REVOKED_DELEG_STID:
> +	if (s->sc_status & SC_STATUS_REVOKED)
>  		ret = nfserr_deleg_revoked;
> -	}
> +	else if (s->sc_status & SC_STATUS_CLOSED)
> +		ret = nfserr_bad_stateid;
>  	return ret;
>  }
>  
> @@ -4642,7 +4635,7 @@ init_open_stateid(struct nfs4_file *fp, struct nfsd4_open *open)
>  
>  	open->op_stp = NULL;
>  	refcount_inc(&stp->st_stid.sc_count);
> -	stp->st_stid.sc_type = NFS4_OPEN_STID;
> +	stp->st_stid.sc_type = SC_TYPE_OPEN;
>  	INIT_LIST_HEAD(&stp->st_locks);
>  	stp->st_stateowner = nfs4_get_stateowner(&oo->oo_owner);
>  	get_nfs4_file(fp);
> @@ -4869,9 +4862,9 @@ static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
>  
>  	trace_nfsd_cb_recall_done(&dp->dl_stid.sc_stateid, task);
>  
> -	if (dp->dl_stid.sc_type == NFS4_CLOSED_DELEG_STID ||
> -	    dp->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID)
> -	        return 1;
> +	if (dp->dl_stid.sc_status)
> +		/* CLOSED or REVOKED */
> +		return 1;
>  
>  	switch (task->tk_status) {
>  	case 0:
> @@ -5116,12 +5109,12 @@ static int share_access_to_flags(u32 share_access)
>  	return share_access == NFS4_SHARE_ACCESS_READ ? RD_STATE : WR_STATE;
>  }
>  
> -static struct nfs4_delegation *find_deleg_stateid(struct nfs4_client *cl, stateid_t *s)
> +static struct nfs4_delegation *find_deleg_stateid(struct nfs4_client *cl,
> +						  stateid_t *s)
>  {
>  	struct nfs4_stid *ret;
>  
> -	ret = find_stateid_by_type(cl, s,
> -				NFS4_DELEG_STID|NFS4_REVOKED_DELEG_STID);
> +	ret = find_stateid_by_type(cl, s, SC_TYPE_DELEG, SC_STATUS_REVOKED);
>  	if (!ret)
>  		return NULL;
>  	return delegstateid(ret);
> @@ -5144,7 +5137,7 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
>  	deleg = find_deleg_stateid(cl, &open->op_delegate_stateid);
>  	if (deleg == NULL)
>  		goto out;
> -	if (deleg->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID) {
> +	if (deleg->dl_stid.sc_status & SC_STATUS_REVOKED) {
>  		nfs4_put_stid(&deleg->dl_stid);
>  		status = nfserr_deleg_revoked;
>  		goto out;
> @@ -5777,7 +5770,6 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>  	} else {
>  		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
>  		if (status) {
> -			stp->st_stid.sc_type = NFS4_CLOSED_STID;
>  			release_open_stateid(stp);
>  			mutex_unlock(&stp->st_mutex);
>  			goto out;
> @@ -6169,7 +6161,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>  		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
>  		if (!state_expired(&lt, dp->dl_time))
>  			break;
> -		unhash_delegation_locked(dp, NFS4_REVOKED_DELEG_STID);
> +		unhash_delegation_locked(dp, SC_STATUS_REVOKED);
>  		list_add(&dp->dl_recall_lru, &reaplist);
>  	}
>  	spin_unlock(&state_lock);
> @@ -6408,22 +6400,20 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
>  	status = nfsd4_stid_check_stateid_generation(stateid, s, 1);
>  	if (status)
>  		goto out_unlock;
> +	status = nfsd4_verify_open_stid(s);
> +	if (status)
> +		goto out_unlock;
> +
>  	switch (s->sc_type) {
> -	case NFS4_DELEG_STID:
> +	case SC_TYPE_DELEG:
>  		status = nfs_ok;
>  		break;
> -	case NFS4_REVOKED_DELEG_STID:
> -		status = nfserr_deleg_revoked;
> -		break;
> -	case NFS4_OPEN_STID:
> -	case NFS4_LOCK_STID:
> +	case SC_TYPE_OPEN:
> +	case SC_TYPE_LOCK:
>  		status = nfsd4_check_openowner_confirmed(openlockstateid(s));
>  		break;
>  	default:
>  		printk("unknown stateid type %x\n", s->sc_type);
> -		fallthrough;
> -	case NFS4_CLOSED_STID:
> -	case NFS4_CLOSED_DELEG_STID:
>  		status = nfserr_bad_stateid;
>  	}
>  out_unlock:
> @@ -6433,7 +6423,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
>  
>  __be32
>  nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
> -		     stateid_t *stateid, unsigned char typemask,
> +		     stateid_t *stateid,
> +		     unsigned short typemask, unsigned short statusmask,
>  		     struct nfs4_stid **s, struct nfsd_net *nn)
>  {
>  	__be32 status;
> @@ -6444,10 +6435,13 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>  	 *  only return revoked delegations if explicitly asked.
>  	 *  otherwise we report revoked or bad_stateid status.
>  	 */
> -	if (typemask & NFS4_REVOKED_DELEG_STID)
> +	if (statusmask & SC_STATUS_REVOKED)
>  		return_revoked = true;
> -	else if (typemask & NFS4_DELEG_STID)
> -		typemask |= NFS4_REVOKED_DELEG_STID;
> +	if (typemask & SC_TYPE_DELEG)
> +		/* Always allow REVOKED for DELEG so we can
> +		 * retturn the appropriate error.
> +		 */
> +		statusmask |= SC_STATUS_REVOKED;
>  
>  	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
>  		CLOSE_STATEID(stateid))
> @@ -6460,14 +6454,12 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>  	}
>  	if (status)
>  		return status;
> -	stid = find_stateid_by_type(cstate->clp, stateid, typemask);
> +	stid = find_stateid_by_type(cstate->clp, stateid, typemask, statusmask);
>  	if (!stid)
>  		return nfserr_bad_stateid;
> -	if ((stid->sc_type == NFS4_REVOKED_DELEG_STID) && !return_revoked) {
> +	if ((stid->sc_status & SC_STATUS_REVOKED) && !return_revoked) {
>  		nfs4_put_stid(stid);
> -		if (cstate->minorversion)
> -			return nfserr_deleg_revoked;
> -		return nfserr_bad_stateid;
> +		return nfserr_deleg_revoked;
>  	}
>  	*s = stid;
>  	return nfs_ok;
> @@ -6478,17 +6470,17 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
>  {
>  	struct nfsd_file *ret = NULL;
>  
> -	if (!s)
> +	if (!s || s->sc_status)
>  		return NULL;
>  
>  	switch (s->sc_type) {
> -	case NFS4_DELEG_STID:
> +	case SC_TYPE_DELEG:
>  		spin_lock(&s->sc_file->fi_lock);
>  		ret = nfsd_file_get(s->sc_file->fi_deleg_file);
>  		spin_unlock(&s->sc_file->fi_lock);
>  		break;
> -	case NFS4_OPEN_STID:
> -	case NFS4_LOCK_STID:
> +	case SC_TYPE_OPEN:
> +	case SC_TYPE_LOCK:
>  		if (flags & RD_STATE)
>  			ret = find_readable_file(s->sc_file);
>  		else
> @@ -6601,7 +6593,8 @@ static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
>  		goto out;
>  
>  	*stid = find_stateid_by_type(found, &cps->cp_p_stateid,
> -			NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID);
> +				     SC_TYPE_DELEG|SC_TYPE_OPEN|SC_TYPE_LOCK,
> +				     0);
>  	if (*stid)
>  		status = nfs_ok;
>  	else
> @@ -6658,8 +6651,8 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
>  	}
>  
>  	status = nfsd4_lookup_stateid(cstate, stateid,
> -				NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID,
> -				&s, nn);
> +				SC_TYPE_DELEG|SC_TYPE_OPEN|SC_TYPE_LOCK,
> +				0, &s, nn);
>  	if (status == nfserr_bad_stateid)
>  		status = find_cpntf_state(nn, stateid, &s);
>  	if (status)
> @@ -6670,16 +6663,13 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
>  		goto out;
>  
>  	switch (s->sc_type) {
> -	case NFS4_DELEG_STID:
> +	case SC_TYPE_DELEG:
>  		status = nfs4_check_delegmode(delegstateid(s), flags);
>  		break;
> -	case NFS4_OPEN_STID:
> -	case NFS4_LOCK_STID:
> +	case SC_TYPE_OPEN:
> +	case SC_TYPE_LOCK:
>  		status = nfs4_check_olstateid(openlockstateid(s), flags);
>  		break;
> -	default:
> -		status = nfserr_bad_stateid;
> -		break;
>  	}
>  	if (status)
>  		goto out;
> @@ -6758,33 +6748,34 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  
>  	spin_lock(&cl->cl_lock);
>  	s = find_stateid_locked(cl, stateid);
> -	if (!s)
> +	if (!s || s->sc_status & SC_STATUS_CLOSED)
>  		goto out_unlock;
>  	spin_lock(&s->sc_lock);
>  	switch (s->sc_type) {
> -	case NFS4_DELEG_STID:
> +	case SC_TYPE_DELEG:
> +		if (s->sc_status & SC_STATUS_REVOKED) {
> +			spin_unlock(&s->sc_lock);
> +			dp = delegstateid(s);
> +			list_del_init(&dp->dl_recall_lru);
> +			spin_unlock(&cl->cl_lock);
> +			nfs4_put_stid(s);
> +			ret = nfs_ok;
> +			goto out;
> +		}
>  		ret = nfserr_locks_held;
>  		break;
> -	case NFS4_OPEN_STID:
> +	case SC_TYPE_OPEN:
>  		ret = check_stateid_generation(stateid, &s->sc_stateid, 1);
>  		if (ret)
>  			break;
>  		ret = nfserr_locks_held;
>  		break;
> -	case NFS4_LOCK_STID:
> +	case SC_TYPE_LOCK:
>  		spin_unlock(&s->sc_lock);
>  		refcount_inc(&s->sc_count);
>  		spin_unlock(&cl->cl_lock);
>  		ret = nfsd4_free_lock_stateid(stateid, s);
>  		goto out;
> -	case NFS4_REVOKED_DELEG_STID:
> -		spin_unlock(&s->sc_lock);
> -		dp = delegstateid(s);
> -		list_del_init(&dp->dl_recall_lru);
> -		spin_unlock(&cl->cl_lock);
> -		nfs4_put_stid(s);
> -		ret = nfs_ok;
> -		goto out;
>  	/* Default falls through and returns nfserr_bad_stateid */
>  	}
>  	spin_unlock(&s->sc_lock);
> @@ -6827,6 +6818,7 @@ static __be32 nfs4_seqid_op_checks(struct nfsd4_compound_state *cstate, stateid_
>   * @seqid: seqid (provided by client)
>   * @stateid: stateid (provided by client)
>   * @typemask: mask of allowable types for this operation
> + * @statusmask: mask of allowed states: 0 or STID_CLOSED
>   * @stpp: return pointer for the stateid found
>   * @nn: net namespace for request
>   *
> @@ -6836,7 +6828,8 @@ static __be32 nfs4_seqid_op_checks(struct nfsd4_compound_state *cstate, stateid_
>   */
>  static __be32
>  nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
> -			 stateid_t *stateid, char typemask,
> +			 stateid_t *stateid,
> +			 unsigned short typemask, unsigned short statusmask,
>  			 struct nfs4_ol_stateid **stpp,
>  			 struct nfsd_net *nn)
>  {
> @@ -6847,7 +6840,8 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
>  	trace_nfsd_preprocess(seqid, stateid);
>  
>  	*stpp = NULL;
> -	status = nfsd4_lookup_stateid(cstate, stateid, typemask, &s, nn);
> +	status = nfsd4_lookup_stateid(cstate, stateid,
> +				      typemask, statusmask, &s, nn);
>  	if (status)
>  		return status;
>  	stp = openlockstateid(s);
> @@ -6869,7 +6863,7 @@ static __be32 nfs4_preprocess_confirmed_seqid_op(struct nfsd4_compound_state *cs
>  	struct nfs4_ol_stateid *stp;
>  
>  	status = nfs4_preprocess_seqid_op(cstate, seqid, stateid,
> -						NFS4_OPEN_STID, &stp, nn);
> +					  SC_TYPE_OPEN, 0, &stp, nn);
>  	if (status)
>  		return status;
>  	oo = openowner(stp->st_stateowner);
> @@ -6900,8 +6894,8 @@ nfsd4_open_confirm(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		return status;
>  
>  	status = nfs4_preprocess_seqid_op(cstate,
> -					oc->oc_seqid, &oc->oc_req_stateid,
> -					NFS4_OPEN_STID, &stp, nn);
> +					  oc->oc_seqid, &oc->oc_req_stateid,
> +					  SC_TYPE_OPEN, 0, &stp, nn);
>  	if (status)
>  		goto out;
>  	oo = openowner(stp->st_stateowner);
> @@ -7031,18 +7025,20 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	struct net *net = SVC_NET(rqstp);
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  
> -	dprintk("NFSD: nfsd4_close on file %pd\n", 
> +	dprintk("NFSD: nfsd4_close on file %pd\n",
>  			cstate->current_fh.fh_dentry);
>  
>  	status = nfs4_preprocess_seqid_op(cstate, close->cl_seqid,
> -					&close->cl_stateid,
> -					NFS4_OPEN_STID|NFS4_CLOSED_STID,
> -					&stp, nn);
> +					  &close->cl_stateid,
> +					  SC_TYPE_OPEN, SC_STATUS_CLOSED,
> +					  &stp, nn);
>  	nfsd4_bump_seqid(cstate, status);
>  	if (status)
> -		goto out; 
> +		goto out;
>  
> -	stp->st_stid.sc_type = NFS4_CLOSED_STID;
> +	spin_lock(&stp->st_stid.sc_client->cl_lock);
> +	stp->st_stid.sc_status |= SC_STATUS_CLOSED;
> +	spin_unlock(&stp->st_stid.sc_client->cl_lock);
>  
>  	/*
>  	 * Technically we don't _really_ have to increment or copy it, since
> @@ -7084,7 +7080,7 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
>  		return status;
>  
> -	status = nfsd4_lookup_stateid(cstate, stateid, NFS4_DELEG_STID, &s, nn);
> +	status = nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, 0, &s, nn);
>  	if (status)
>  		goto out;
>  	dp = delegstateid(s);
> @@ -7351,7 +7347,7 @@ init_lock_stateid(struct nfs4_ol_stateid *stp, struct nfs4_lockowner *lo,
>  	if (retstp)
>  		goto out_found;
>  	refcount_inc(&stp->st_stid.sc_count);
> -	stp->st_stid.sc_type = NFS4_LOCK_STID;
> +	stp->st_stid.sc_type = SC_TYPE_LOCK;
>  	stp->st_stateowner = nfs4_get_stateowner(&lo->lo_owner);
>  	get_nfs4_file(fp);
>  	stp->st_stid.sc_file = fp;
> @@ -7538,9 +7534,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  							&lock_stp, &new);
>  	} else {
>  		status = nfs4_preprocess_seqid_op(cstate,
> -				       lock->lk_old_lock_seqid,
> -				       &lock->lk_old_lock_stateid,
> -				       NFS4_LOCK_STID, &lock_stp, nn);
> +						  lock->lk_old_lock_seqid,
> +						  &lock->lk_old_lock_stateid,
> +						  SC_TYPE_LOCK, 0, &lock_stp,
> +						  nn);
>  	}
>  	if (status)
>  		goto out;
> @@ -7853,8 +7850,8 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		 return nfserr_inval;
>  
>  	status = nfs4_preprocess_seqid_op(cstate, locku->lu_seqid,
> -					&locku->lu_stateid, NFS4_LOCK_STID,
> -					&stp, nn);
> +					  &locku->lu_stateid, SC_TYPE_LOCK, 0,
> +					  &stp, nn);
>  	if (status)
>  		goto out;
>  	nf = find_any_file(stp->st_stid.sc_file);
> @@ -8292,7 +8289,7 @@ nfs4_state_shutdown_net(struct net *net)
>  	spin_lock(&state_lock);
>  	list_for_each_safe(pos, next, &nn->del_recall_lru) {
>  		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> -		unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
> +		unhash_delegation_locked(dp, SC_STATUS_CLOSED);
>  		list_add(&dp->dl_recall_lru, &reaplist);
>  	}
>  	spin_unlock(&state_lock);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 41bdc913fa71..ffc8920d0558 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -88,17 +88,33 @@ struct nfsd4_callback_ops {
>   */
>  struct nfs4_stid {
>  	refcount_t		sc_count;
> -#define NFS4_OPEN_STID 1
> -#define NFS4_LOCK_STID 2
> -#define NFS4_DELEG_STID 4
> -/* For an open stateid kept around *only* to process close replays: */
> -#define NFS4_CLOSED_STID 8
> +
> +	/* A new stateid is added to the cl_stateids idr early before it
> +	 * is fully initialised.  Its sc_type is then zero.  After
> +	 * initialisation the sc_type it set under cl_lock, and then
> +	 * never changes.
> +	 */
> +#define SC_TYPE_OPEN		BIT(0)
> +#define SC_TYPE_LOCK		BIT(1)
> +#define SC_TYPE_DELEG		BIT(2)
> +#define SC_TYPE_LAYOUT		BIT(3)
> +	unsigned short		sc_type;
> +
> +/* state_lock protects sc_status for delegation stateids.
> + * ->cl_lock protects sc_status for open and lock stateids.
> + * ->st_mutex also protect sc_status for open stateids.
> + * ->ls_lock protects sc_status for layout stateids.
> + */
> +/*
> + * For an open stateid kept around *only* to process close replays.
> + * For deleg stateid, kept in idr until last reference is dropped.
> + */
> +#define SC_STATUS_CLOSED	BIT(0)
>  /* For a deleg stateid kept around only to process free_stateid's: */
> -#define NFS4_REVOKED_DELEG_STID 16
> -#define NFS4_CLOSED_DELEG_STID 32
> -#define NFS4_LAYOUT_STID 64
> +#define SC_STATUS_REVOKED	BIT(1)
> +	unsigned short		sc_status;
> +
>  	struct list_head	sc_cp_list;
> -	unsigned char		sc_type;
>  	stateid_t		sc_stateid;
>  	spinlock_t		sc_lock;
>  	struct nfs4_client	*sc_client;
> @@ -672,15 +688,15 @@ extern __be32 nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
>  		stateid_t *stateid, int flags, struct nfsd_file **filp,
>  		struct nfs4_stid **cstid);
>  __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
> -		     stateid_t *stateid, unsigned char typemask,
> -		     struct nfs4_stid **s, struct nfsd_net *nn);
> +			    stateid_t *stateid, unsigned short typemask,
> +			    unsigned short statusmask,
> +			    struct nfs4_stid **s, struct nfsd_net *nn);
>  struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *slab,
>  				  void (*sc_free)(struct nfs4_stid *));
>  int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy *copy);
>  void nfs4_free_copy_state(struct nfsd4_copy *copy);
>  struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
>  			struct nfs4_stid *p_stid);
> -void nfs4_unhash_stid(struct nfs4_stid *s);
>  void nfs4_put_stid(struct nfs4_stid *s);
>  void nfs4_inc_and_copy_stateid(stateid_t *dst, struct nfs4_stid *stid);
>  void nfs4_remove_reclaim_record(struct nfs4_client_reclaim *, struct nfsd_net *);
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index d1e8cf079b0f..fe08ca18b647 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -641,23 +641,17 @@ DEFINE_EVENT(nfsd_stateseqid_class, nfsd_##name, \
>  DEFINE_STATESEQID_EVENT(preprocess);
>  DEFINE_STATESEQID_EVENT(open_confirm);
>  
> -TRACE_DEFINE_ENUM(NFS4_OPEN_STID);
> -TRACE_DEFINE_ENUM(NFS4_LOCK_STID);
> -TRACE_DEFINE_ENUM(NFS4_DELEG_STID);
> -TRACE_DEFINE_ENUM(NFS4_CLOSED_STID);
> -TRACE_DEFINE_ENUM(NFS4_REVOKED_DELEG_STID);
> -TRACE_DEFINE_ENUM(NFS4_CLOSED_DELEG_STID);
> -TRACE_DEFINE_ENUM(NFS4_LAYOUT_STID);
> -
>  #define show_stid_type(x)						\
>  	__print_flags(x, "|",						\
> -		{ NFS4_OPEN_STID,		"OPEN" },		\
> -		{ NFS4_LOCK_STID,		"LOCK" },		\
> -		{ NFS4_DELEG_STID,		"DELEG" },		\
> -		{ NFS4_CLOSED_STID,		"CLOSED" },		\
> -		{ NFS4_REVOKED_DELEG_STID,	"REVOKED" },		\
> -		{ NFS4_CLOSED_DELEG_STID,	"CLOSED_DELEG" },	\
> -		{ NFS4_LAYOUT_STID,		"LAYOUT" })
> +		{ SC_TYPE_OPEN,		"OPEN" },		\
> +		{ SC_TYPE_LOCK,		"LOCK" },		\
> +		{ SC_TYPE_DELEG,		"DELEG" },		\
> +		{ SC_TYPE_LAYOUT,		"LAYOUT" })
> +
> +#define show_stid_status(x)						\
> +	__print_flags(x, "|",						\
> +		{ SC_STATUS_CLOSED,		"CLOSED" },		\
> +		{ SC_STATUS_REVOKED,		"REVOKED" })		\
>  
>  DECLARE_EVENT_CLASS(nfsd_stid_class,
>  	TP_PROTO(
> @@ -666,6 +660,7 @@ DECLARE_EVENT_CLASS(nfsd_stid_class,
>  	TP_ARGS(stid),
>  	TP_STRUCT__entry(
>  		__field(unsigned long, sc_type)
> +		__field(unsigned long, sc_status)
>  		__field(int, sc_count)
>  		__field(u32, cl_boot)
>  		__field(u32, cl_id)
> @@ -676,16 +671,18 @@ DECLARE_EVENT_CLASS(nfsd_stid_class,
>  		const stateid_t *stp = &stid->sc_stateid;
>  
>  		__entry->sc_type = stid->sc_type;
> +		__entry->sc_status = stid->sc_status;
>  		__entry->sc_count = refcount_read(&stid->sc_count);
>  		__entry->cl_boot = stp->si_opaque.so_clid.cl_boot;
>  		__entry->cl_id = stp->si_opaque.so_clid.cl_id;
>  		__entry->si_id = stp->si_opaque.so_id;
>  		__entry->si_generation = stp->si_generation;
>  	),
> -	TP_printk("client %08x:%08x stateid %08x:%08x ref=%d type=%s",
> +	TP_printk("client %08x:%08x stateid %08x:%08x ref=%d type=%s state=%s",
>  		__entry->cl_boot, __entry->cl_id,
>  		__entry->si_id, __entry->si_generation,
> -		__entry->sc_count, show_stid_type(__entry->sc_type)
> +		__entry->sc_count, show_stid_type(__entry->sc_type),
> +		show_stid_status(__entry->sc_status)
>  	)
>  );
>  
> -- 
> 2.43.0
> 

-- 
Chuck Lever

