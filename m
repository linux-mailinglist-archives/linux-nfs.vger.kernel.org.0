Return-Path: <linux-nfs+bounces-77-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 382F87F94A1
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Nov 2023 18:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A38E6B20B96
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Nov 2023 17:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A27DF6B;
	Sun, 26 Nov 2023 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XSqsa7BT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a8UffQEU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B130FB
	for <linux-nfs@vger.kernel.org>; Sun, 26 Nov 2023 09:36:51 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AQHYugR030693;
	Sun, 26 Nov 2023 17:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=tIwM0CIZgi3hq5TsjsBaWexQ72PWfz2vXnslLijLIfA=;
 b=XSqsa7BTRsQh+eK/Q8HQ2hh0HClsdBR3K6m8w4NowliequC8uKKDCEftavqEdEdfpywa
 9wlKQ1FMLrmpZwqXPxIgP4ZE8XrC2akKPzRA+Wf+Imkc16EB1uN3DPGY5g/KOWUPRiLT
 /g9vjQb+2kcew54EaA8cfsqsszxeEUuaZQzXnYoupHSvCutuH2f+EtM7x5HXJI4dPCtJ
 UsncU3CFkFn1/JzTCeTMCkL7WcqAFeFfQjekEXP5HAob6S8Kz9svog7RDDdag2Ro/JSX
 wzqyGIsGeXJT/NaozoDfLfOa0+Hvbzj8tHeDUQyrh5QXJzgdwsTEyNHKV4zDMjLqFLZg dQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk8yd1gbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Nov 2023 17:36:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AQGXNU3001389;
	Sun, 26 Nov 2023 17:36:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7camenp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Nov 2023 17:36:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgI1/jceSakc1kftadXolqB/Rs6ot2YhsJzJvph8qXl7sfKlYWv6T9qtjGg4t3cJSLttWSbveGo/KON7Ix2p5cseQ/fYl0+49TsjTsVqCARoQ6l/IAPPNA+dTlgObVesMqps6BgnLkyLtfGdq3pQww50lWx4ss9B5UCvGLsLOIAD3MAVBhrsm1zMQaAflSOYfnBRP2lzjEsdlL+efbjQvL6Bejm/cwM2Q6PopB4jurQlDefOnybGXUjjWgPJIMxAKcP1wKJLlimlebVkOriVDY+Yj0+Bts1g8IsxgUzmfFGOH1Ud/E1ai0HTpG76QKYPAPDPP8QGwVGE+YaIiYJ5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIwM0CIZgi3hq5TsjsBaWexQ72PWfz2vXnslLijLIfA=;
 b=S/e43nEYqdtFbQ55SzbNHT3zbz7OEVcYhqrmuOGVjoXy885BQhR8l5/PTK1F9siKWT8Sx6if3VVIFPndLMtUhviXb4cEFp3NLNTTWpGlTvG5oheUYPkZlY6nkDj8Y6Bmpf1DenM0DB0TAPkKxR0Nw8QGG5bryI9dm+fFtZC7wQsEXMWqxdYXsLYWoGEmO571kBWV3j+7H5TVMz5s2qqG8OuwRIh5nW0dYPSXyjtApV2vyTLMy45qOwwiqjDAppGYpRYYT4BBPlWJATxwdl/5XH2fAPPg62BfXlQlHekkdncMSbJI7l3EoQSePEeRydk6fcap5thJkFjKGuaYBqMQnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIwM0CIZgi3hq5TsjsBaWexQ72PWfz2vXnslLijLIfA=;
 b=a8UffQEU5bsfxooDAdM9IhinVeaYmWkzlcbyjOouRcBvG4MaK8qmayzSAOfU6zO7DuG1PICMeKhUUs0ltgFycoX4hTvx6Xn4PAOs5djtx/WUQlYMBU7Uwfvd0UoJvytUKMYISAmmfqE7OtO5eUR/nsr/ebyiutqwi8ZWERyuAwk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5106.namprd10.prod.outlook.com (2603:10b6:208:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Sun, 26 Nov
 2023 17:36:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7025.022; Sun, 26 Nov 2023
 17:36:25 +0000
Date: Sun, 26 Nov 2023 12:36:22 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 05/11] nfsd: prepare for supporting admin-revocation of
 state
Message-ID: <ZWOCFjELHrc7sTil@tissot.1015granger.net>
References: <20231124002925.1816-1-neilb@suse.de>
 <20231124002925.1816-6-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124002925.1816-6-neilb@suse.de>
X-ClientProxiedBy: CH5P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: cd780c0e-bac8-477f-0699-08dbeea636b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bPmRbhHHcxZlwG3WcdFrQkQ3ZfgjDdD9Gb6N4jH6vgez8nggXNPpGvGoSGv2Ee91e8eCsqT4Ls/vALWauPdrsa1ZZJXzxDSTm0SULjfNPLvPiAChZ1l4cBrJA2HAmVXgQF8uLu5Km4Qj4BpS2M9urdA8/5KhQeDs0NbVUPgpe4P2H1yTHZa2qegrQFjc/DUzNtW9En/fUhBqANPlc5eYplXdYsIUqz8EZRDYhu7PJbcsPaPXByTuDL4WBIlp91GIVsVkHX1A9/WU6Ibmk8OKV+i7Ci4gHrVXKkHhfV8AojP+FZ5OpFCGqjcc2JiLCqlVSc3FeTXzp+7TVhQwhJ6qC26YTFrAsdmUQXC2G6SBmiGP6IGeIpkrnNzkhdo2bJGaYdOzn7hXV15C6TNwjzQ3qASWbetIkWoEY4QeaXQq9EcKyAvrWrwqSOFSBBigygRN5nWxw//cQ1lzpT/2LX5pulnsYEfMW5rA2gOaYVaBkLv1C3Jwxw+UUratVDv25vpiFynfV2G9ka3Jm4+vc+/NMXrj8zFWYMR4bdtVFP+GvWTHhWjUcMXBqiMJqn4aTsKn
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6666004)(4326008)(8676002)(8936002)(6512007)(9686003)(6506007)(66476007)(66946007)(54906003)(66556008)(6916009)(316002)(6486002)(478600001)(2906002)(38100700002)(41300700001)(86362001)(26005)(44832011)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jCIWZXKxjHj4OkICXGsMTM/4TBliZrN7LnITdupFfLdsd8SNCSHFMdUkQWMY?=
 =?us-ascii?Q?YgyxX1ZYWuNND2A0bwmrbOcQpLbh/fNJuuMKnni9A3s1U8cY5zkLrjUW0/Sl?=
 =?us-ascii?Q?cDwNCUXVVaRXRBY59poMf24HlzY6sIZv9gUASa462nxIsEDcyo0WqhaNWpEh?=
 =?us-ascii?Q?ySDAULqL1QARpeLL/nNZB15rCYzPzjwZzLKU/51JVmJK0LqKR6CgFOKamovM?=
 =?us-ascii?Q?0PTl+zv3iJLsH2Damq3rLP9YyZsBI7V9PVBQBIr9nTyQlpIiTS1j1qGM0htR?=
 =?us-ascii?Q?sbpxA9FNM5L9nBBrJffvbI4TS0eJx8TxO+cz4DOI2G/aap0O4M+SJU35bWLe?=
 =?us-ascii?Q?tytDng/Bm2sT8cKiHzaLDvGgaknae1rMWqpOYvX5c+YbzRvBaLPw6pxIcI0W?=
 =?us-ascii?Q?/VExhtcH+Q909kxI953QvPGB1amiK7htGrWuxOXBplgDXmZGWlmRneII3SFk?=
 =?us-ascii?Q?Jl53z5sWLhWbRfWN15TyEC7dANVyj+r334oeCt739npexvAOCFmmQm0BsxCq?=
 =?us-ascii?Q?TDu8jHc0duWCZ4hwB46/uhRGDZ/ZpTrNQVhCQIjkeSv1QZV4tSFBlXLu+b4+?=
 =?us-ascii?Q?EnDmuBWKQeNr4MB0rbxFoWxS5+HIz9cWg4n0DdHn5pc++NAlfZamfQRtA6yM?=
 =?us-ascii?Q?CYjT5z8xupXM4pxsQdId5HOFVIWtVUkPJ5ycJdRqOZnRDSEPZewBteq2HcHd?=
 =?us-ascii?Q?u76pwCLZZEaNd4v1DplqaPT730ZUgOObgInPgpkyZHzPl4zmzDBF2AuYxEwV?=
 =?us-ascii?Q?BlJCWgRn+9QOBWj3Nha0jD47ZLZWPVmlStiOU5UWpzssGy3W/LUVVE81/Ind?=
 =?us-ascii?Q?3FjPmrO+qCehOymlr/6FH35DegqwUlMdJ8Z+TWEM+VU1QKfjkpygvoYuUjLD?=
 =?us-ascii?Q?6jpc40KmNWSw5JNvQW8zHkX59CFBXun4j+9NkoP+x2qpX4WV7ZLt/v3rTpN4?=
 =?us-ascii?Q?4WSzU9ohN4Iv6L3+FyeLCOAYp1HatgrNmYGYsjc17rZ17NqRC8a88wFD4ae7?=
 =?us-ascii?Q?rUuTidDLQ7YuP52oSJhpFaJzxqQsuKpn1i0ACfkULudUvbioEZ78n9fRG545?=
 =?us-ascii?Q?CXWe5YF/WumciEyCHyLmrc3Q8hEXC/ZfSBdv820vvHlPpRauhu+eirCNIXho?=
 =?us-ascii?Q?YEZqpYrNmdzE0JD9/ijdo+b3evJuLsS/PXdVOIvfb7KvxQ4Y5mj65w+ki6oZ?=
 =?us-ascii?Q?8VY9Y3IZq0NC7yKuLyODdYlS2sa6KZvMSO7XHOSobjwW6DwQAzgaUoFP+GFo?=
 =?us-ascii?Q?MmgQTGpsHC7qDgvfUXtbeo1dok91UJvy4s4Gupy33Kj08rHtcBw7SyCdp7Rl?=
 =?us-ascii?Q?wU6ULvzdKgFlRt3I/NWXyJWhKOM15AjRRiWuMIVA4gUf+YmfQphX4mMP3G9v?=
 =?us-ascii?Q?05LPx5mBAzRqOD1Y6jWU6NCaaeBB/+9Ntys5oUkfc31Ol3PD7XUNxAhEpx5Y?=
 =?us-ascii?Q?QhH+hBg7eSrMSxcr/iy/nLjSuuCUlfq3Qfb+E4HofNPohWUe3BLkZbkOpBCE?=
 =?us-ascii?Q?W1ZgoZ1K+R3k94lLimGMQD5MEZysyfVrJlrfXYCUMzWCWbXfd9o+3Rh9GO2q?=
 =?us-ascii?Q?reAWH0b0uxQGAo4uZ5GsHDYQeNYV50MDkq03gIp7+E/MRdFk4C3GsQ0WcmkD?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KLpBIb25sP4lrDPH3Q8kLbPvuJOCAx8rAwNSSB2lWUu5D+HUuuhdIA7kk7pXiba2BZLW5QrG6QL31lj6mkqoqOt/4vVh5rOO2kryEZJTmBBalqId8SoiT00XN0s32JS8UI5qS9gxxC2TkaZh+zoBiRMDjCbOA55pBTjimWJr06Q+LUwcQkjf4TBR2NdIByyY/HzAeVpqrHuk8hmeXG6MjBDtsSYQNI3aMZC3P5uwAYttNXW0gsI5Qjsm1OqlNRhzcBrYFOBjZalpyTOjdpPsfGbcNW8rNlQdJ4JF6zmIjTQ4+mG0s6GklHlbi8pVgtsLelmzDABjbmuCd4m2/VvqGyZzOiWwQSwE8dx5DPyfcEjA3L6x6+FzN/8618CL/p+ZAUlZoIKyCkGLTrpdJZ+49B7tAakrPYFpysu9idvF/j/E0+tgXIvs5dLFyPVrZ+472ysLkCjExFxgLe+G8KjPPI+gcUbumn7HjqBedTmKLI7qEdw03O+zNtWvZ/PmgrIw+EEo+xrEnLkXYAI4HFnyYiwGPUffuK8zXdb/+a802kZdUM0NdTAWNr5CN4Q7MxyqO8SbA00Xh4woPUuTwKFbd93h5n4Dvx52xckXNAmxJs1CqELCQAZSqXrSnHt/BXG+eyHKTvCkS7SiOHxauoMBnQrKrWdBlfSZPQoG+I/xiWQZu43s1gbUHSlnkoF1Rvw42M9VHRhqKtW/D2ERt3ztIsw0sBtCl9ULbC76+D2Y8dmjpjaRkz9g7oqkc6hVcPniK1s7PEQvrz7n8/u4WvGe1i0jxJEx+sfVYR4vUn3DgNCMhHfRKp1h7Gms1ys/2iWuuxy62Rd2S9oFirgrinxSsy2gncvCWsgCqStqs9//sDYKt3tPijkb2omGsLNe7oYB
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd780c0e-bac8-477f-0699-08dbeea636b8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2023 17:36:25.4765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAsSng0zK50toGDUUZ6eg5jdMteFyE5x+iPIkGvN2q0Gscm9YavF0bRg6zRZlfHFsBCgju//6+x/tIYGqXrQEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-26_17,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=523 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311260130
X-Proofpoint-ORIG-GUID: 713fWefjUVZieYrHalehfkd84qjIGHGN
X-Proofpoint-GUID: 713fWefjUVZieYrHalehfkd84qjIGHGN

On Fri, Nov 24, 2023 at 11:28:40AM +1100, NeilBrown wrote:
> The NFSv4 protocol allows state to be revoked by the admin and has error
> codes which allow this to be communicated to the client.
> 
> This patch
>  - introduces a new state-id status NFS4_STID_ADMIN_REVOKE
>    which can be set on open, lock, or delegation state.
>  - reports NFS4ERR_ADMIN_REVOKED when these are accessed
>  - introduces a per-client counter of these states and returns
>    SEQ4_STATUS_ADMIN_STATE_REVOKED when the counter is not zero.
>    Decrements this when freeing any admin-revoked state.
>  - introduces stub code to find all interesting states for a given
>    superblock so they can be revoked via the 'unlock_filesystem'
>    file in /proc/fs/nfsd/
>    No actual states are handled yet.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 71 ++++++++++++++++++++++++++++++++++++++++++++-
>  fs/nfsd/nfsctl.c    |  1 +
>  fs/nfsd/nfsd.h      |  1 +
>  fs/nfsd/state.h     | 10 +++++++
>  fs/nfsd/trace.h     |  3 +-
>  5 files changed, 84 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b9239f2ebc79..477a9e9aebbd 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1215,6 +1215,8 @@ nfs4_put_stid(struct nfs4_stid *s)
>  		return;
>  	}
>  	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
> +	if (s->sc_status & NFS4_STID_ADMIN_REVOKED)
> +		atomic_dec(&s->sc_client->cl_admin_revoked);
>  	nfs4_free_cpntf_statelist(clp->net, s);
>  	spin_unlock(&clp->cl_lock);
>  	s->sc_free(s);
> @@ -1534,6 +1536,8 @@ static void put_ol_stateid_locked(struct nfs4_ol_stateid *stp,
>  	}
>  
>  	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
> +	if (s->sc_status & NFS4_STID_ADMIN_REVOKED)
> +		atomic_dec(&s->sc_client->cl_admin_revoked);
>  	list_add(&stp->st_locks, reaplist);
>  }
>  
> @@ -1679,6 +1683,54 @@ static void release_openowner(struct nfs4_openowner *oo)
>  	nfs4_put_stateowner(&oo->oo_owner);
>  }
>  
> +static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
> +					  struct super_block *sb,
> +					  unsigned int sc_types)
> +{
> +	unsigned long id, tmp;
> +	struct nfs4_stid *stid;
> +
> +	spin_lock(&clp->cl_lock);
> +	idr_for_each_entry_ul(&clp->cl_stateids, stid, tmp, id)
> +		if ((stid->sc_type & sc_types) &&
> +		    stid->sc_status == 0 &&
> +		    stid->sc_file->fi_inode->i_sb == sb) {
> +			refcount_inc(&stid->sc_count);
> +			break;
> +		}
> +	spin_unlock(&clp->cl_lock);
> +	return stid;
> +}
> +

nfsd4_revoke_states() needs a kdoc comment.


> +void nfsd4_revoke_states(struct net *net, struct super_block *sb)
> +{
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	unsigned int idhashval;
> +	unsigned int sc_types;
> +
> +	sc_types = 0;
> +
> +	spin_lock(&nn->client_lock);
> +	for (idhashval = 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
> +		struct list_head *head = &nn->conf_id_hashtbl[idhashval];
> +		struct nfs4_client *clp;
> +	retry:
> +		list_for_each_entry(clp, head, cl_idhash) {
> +			struct nfs4_stid *stid = find_one_sb_stid(clp, sb,
> +								  sc_types);
> +			if (stid) {
> +				spin_unlock(&nn->client_lock);
> +				switch (stid->sc_type) {

This is "dead" code, for now. Does this stub really need to be
introduced in this patch?


> +				}
> +				nfs4_put_stid(stid);
> +				spin_lock(&nn->client_lock);
> +				goto retry;
> +			}
> +		}
> +	}
> +	spin_unlock(&nn->client_lock);
> +}
> +
>  static inline int
>  hash_sessionid(struct nfs4_sessionid *sessionid)
>  {
> @@ -2550,6 +2602,8 @@ static int client_info_show(struct seq_file *m, void *v)
>  	}
>  	seq_printf(m, "callback state: %s\n", cb_state2str(clp->cl_cb_state));
>  	seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
> +	seq_printf(m, "admin-revoked states: %d\n",
> +		   atomic_read(&clp->cl_admin_revoked));
>  	drop_client(clp);
>  
>  	return 0;
> @@ -4109,6 +4163,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	}
>  	if (!list_empty(&clp->cl_revoked))
>  		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
> +	if (atomic_read(&clp->cl_admin_revoked))
> +		seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
>  out_no_session:
>  	if (conn)
>  		free_conn(conn);
> @@ -4597,7 +4653,9 @@ nfsd4_verify_open_stid(struct nfs4_stid *s)
>  {
>  	__be32 ret = nfs_ok;
>  
> -	if (s->sc_status & NFS4_STID_REVOKED)
> +	if (s->sc_status & NFS4_STID_ADMIN_REVOKED)
> +		ret = nfserr_admin_revoked;
> +	else if (s->sc_status & NFS4_STID_REVOKED)
>  		ret = nfserr_deleg_revoked;
>  	else if (s->sc_status & NFS4_STID_CLOSED)
>  		ret = nfserr_bad_stateid;
> @@ -5188,6 +5246,11 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
>  	deleg = find_deleg_stateid(cl, &open->op_delegate_stateid);
>  	if (deleg == NULL)
>  		goto out;
> +	if (deleg->dl_stid.sc_status & NFS4_STID_ADMIN_REVOKED) {
> +		nfs4_put_stid(&deleg->dl_stid);
> +		status = nfserr_admin_revoked;
> +		goto out;
> +	}
>  	if (deleg->dl_stid.sc_status & NFS4_STID_REVOKED) {
>  		nfs4_put_stid(&deleg->dl_stid);
>  		status = nfserr_deleg_revoked;
> @@ -6508,6 +6571,8 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>  		 */
>  		statusmask |= NFS4_STID_REVOKED;
>  
> +	statusmask |= NFS4_STID_ADMIN_REVOKED;
> +
>  	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
>  		CLOSE_STATEID(stateid))
>  		return nfserr_bad_stateid;
> @@ -6526,6 +6591,10 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>  		nfs4_put_stid(stid);
>  		return nfserr_deleg_revoked;
>  	}
> +	if (stid->sc_type & NFS4_STID_ADMIN_REVOKED) {
> +		nfs4_put_stid(stid);
> +		return nfserr_admin_revoked;
> +	}
>  	*s = stid;
>  	return nfs_ok;
>  }
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index d6eeee149370..a622d773f428 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -285,6 +285,7 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
>  	 * 3.  Is that directory the root of an exported file system?
>  	 */
>  	error = nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
> +	nfsd4_revoke_states(netns(file), path.dentry->d_sb);
>  
>  	path_put(&path);
>  	return error;
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index f5ff42f41ee7..d46203eac3c8 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -280,6 +280,7 @@ void		nfsd_lockd_shutdown(void);
>  #define	nfserr_no_grace		cpu_to_be32(NFSERR_NO_GRACE)
>  #define	nfserr_reclaim_bad	cpu_to_be32(NFSERR_RECLAIM_BAD)
>  #define	nfserr_badname		cpu_to_be32(NFSERR_BADNAME)
> +#define	nfserr_admin_revoked	cpu_to_be32(NFS4ERR_ADMIN_REVOKED)
>  #define	nfserr_cb_path_down	cpu_to_be32(NFSERR_CB_PATH_DOWN)
>  #define	nfserr_locked		cpu_to_be32(NFSERR_LOCKED)
>  #define	nfserr_wrongsec		cpu_to_be32(NFSERR_WRONGSEC)
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index bb00dcd4c1ba..584378c43e0a 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -112,6 +112,7 @@ struct nfs4_stid {
>  #define NFS4_STID_CLOSED	BIT(0)
>  /* For a deleg stateid kept around only to process free_stateid's: */
>  #define NFS4_STID_REVOKED	BIT(1)
> +#define NFS4_STID_ADMIN_REVOKED	BIT(2)

The names of these mask bits are now getting to be visually
indistinguishable from the stateid type names. The subtlety of
where the _STID_ falls in the name makes me blink a few times when
reading this code.

It would be a little more friendly to add _STATUS_ or some other
infix that makes it easy to tell these are not stateid types. I
know that makes the names longer and more unwieldy.


>  	unsigned short		sc_status;
>  
>  	struct list_head	sc_cp_list;
> @@ -388,6 +389,7 @@ struct nfs4_client {
>  	clientid_t		cl_clientid;	/* generated by server */
>  	nfs4_verifier		cl_confirm;	/* generated by server */
>  	u32			cl_minorversion;
> +	atomic_t		cl_admin_revoked; /* count of admin-revoked states */
>  	/* NFSv4.1 client implementation id: */
>  	struct xdr_netobj	cl_nii_domain;
>  	struct xdr_netobj	cl_nii_name;
> @@ -752,6 +754,14 @@ static inline void get_nfs4_file(struct nfs4_file *fi)
>  }
>  struct nfsd_file *find_any_file(struct nfs4_file *f);
>  
> +#ifdef CONFIG_NFSD_V4
> +void nfsd4_revoke_states(struct net *net, struct super_block *sb);
> +#else
> +static inline void nfsd4_revoke_states(struct net *net, struct super_block *sb)
> +{
> +}
> +#endif
> +
>  /* grace period management */
>  void nfsd4_end_grace(struct nfsd_net *nn);
>  
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 568b4ec9a2af..281aeb42c9eb 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -651,7 +651,8 @@ DEFINE_STATESEQID_EVENT(open_confirm);
>  #define show_stid_status(x)						\
>  	__print_flags(x, "|",						\
>  		{ NFS4_STID_CLOSED,		"CLOSED" },		\
> -		{ NFS4_STID_REVOKED,		"REVOKED" })		\
> +		{ NFS4_STID_REVOKED,		"REVOKED" },		\
> +		{ NFS4_STID_ADMIN_REVOKED,	"ADMIN_REVOKED" })
>  
>  DECLARE_EVENT_CLASS(nfsd_stid_class,
>  	TP_PROTO(
> -- 
> 2.42.1
> 

-- 
Chuck Lever

