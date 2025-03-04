Return-Path: <linux-nfs+bounces-10442-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EADA4D19A
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 03:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E63F16CDEA
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 02:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6245C185E7F;
	Tue,  4 Mar 2025 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MXA8MLdD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XJNR8Q7k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C2711CAF;
	Tue,  4 Mar 2025 02:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741055138; cv=fail; b=YRZGFK9RWlNQOhuB5as5mnPZQROwxJg8dwfoFe3pJjQ8wnrU7hpFFInSZfAKKgFzYmwvqZ4nanzDLo3UEeZ+Ol7kkJ52t3B/lY/JFtljHpfJnp3GKDkpjRSYM4l8IUhxuMyKt1qQthTEJ0LTHq1zCQuuYGs2FkBd5LSw5e+IVCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741055138; c=relaxed/simple;
	bh=/cIIMHWyABUVxagOa0D6tKzHvoombbQalNaPjR9/VDA=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=UCJfDxSFUlZ0o2d3c0uZ4D3T4hnzp5+p76cxEppHltqcrnhpBAfDwqSnuhZ/MB4CnSRa8Iq6gnRaVmimRJQ1ChuT739UVc3LGvdMp99MWsuiPC69VphkaesmZGHWx/iMM7qY1kqbfJuDu0cmtEmSPILxSaCNs6HBYODSvQkz6DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MXA8MLdD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XJNR8Q7k; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5241MbFu007212;
	Tue, 4 Mar 2025 02:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=T2anW+/OVx7w44L5Wz
	nVy5AagWc0teA8PfCwXtzX648=; b=MXA8MLdDaoeI5/rUGHaOrzW1zK1Llhx2Hs
	OCC7Ta/YJ7eGoIqn6jDFBRvzK7vDDtQni2OMXErdfNMw92Q10f3N/rRmZWGz+pmN
	fxWN/35puIujwaSWN9MfuL/RagGOrbyz+p/ao68ULqmS6UAwY28HFe69cWJxkuwY
	t6WU3kU6pVvU1YTDgaz/zVTALLOXxivkeYP6Mt2XsXRj6YrwWN5PbPT+eb4mMA/2
	IdGVXzRWaLtj+cNpwnUSrIxdZeHhaUeR5/h2acLHZpqirOb/vrRvOqqzyRxmRnVe
	QUOcuKGLNYtBgGct7U5btmt1Hqz6iIc3Jl4fYKXzYYqOP5WqgoUA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4541r43tht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 02:24:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5240FkBP038291;
	Tue, 4 Mar 2025 02:24:47 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpek5f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 02:24:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ya780oaD8S9eHPLmWWaU40Wo2g5/Z6Q69Tk8MAKcx2tj2NwOvAN5taM6kHBdfZxzUvKWHsI5i9FPozGyO89uhSoGjJKO+6o/sEvCl8zcQHZgUpGHn+YE7FlKhLnl/2Lbc0LfuCJeJC/ps6VsKNzYu6xhQ5Xyy/KhjYM3XRHw0mzcPWqkR+PCdRVTQzg7CWXhXEoV4XHzGXGMRa/qSBbo/KUqw9BoIYJxQj1kcuzg8rIjEv3BMI8LYnGycA7H2W7F1xCesmxCu2vVAv3aGCRiV4dB1aZBZbE7BlcOCVbEuOYWzzupAWpxFaCFUWZKeQvEx8pLZw6VUMQwtmUzAQ5H/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2anW+/OVx7w44L5WznVy5AagWc0teA8PfCwXtzX648=;
 b=pOyUm0CTmXkWaYHbODfusqHRnjN5FIrsx0xbMxzuj6q2eRlylx9l1vB01+TSDn2oko3pvRxVbqF+Bcio8K+02Zlzmd9ILCuH3Herf47Yy4w1iBphgxgPNU1Az44QDE2BQkOEmcpxmvHPE9+olMiEcqOmn3AKqRTYudt2RJibsygCFGOFe4IAcS0IsDZSOvVgqED3T8VLk5t+Vj+fwGO0Nu7X8zYEk1S/qk5+VzGFnKSC9ptecSjvs8A+9yxqFiLEWNdJOv4mmcnI2VgqiqRcEbx6O0berBDQfAtf44KbEmqquKibS/6S1JGCeUUSYu8KlDVDRYnhCfX3qOFZBSjA5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2anW+/OVx7w44L5WznVy5AagWc0teA8PfCwXtzX648=;
 b=XJNR8Q7kpJ+o8Q2msOFQKAxI3of6X8xagDq6d6l6Esc1h8sHCYvpxbpBtPCKrNGigScwToG2piB0KEEi5ekwfNcSPoe3YOds13h9AHpFfnKxbHmOGeLkjpzW+X4fYzJPLE3GZN/kTbGAWzP7jsqYptvJXsVbuMw9MsiBEpJM9Ys=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by CH3PR10MB7258.namprd10.prod.outlook.com (2603:10b6:610:124::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 02:24:45 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 02:24:45 +0000
To: Joel Granados <joel.granados@kernel.org>
Cc: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, codalist@coda.cs.cmu.edu,
        linux-nfs@vger.kernel.org,
        Nicolas Bouchinet
 <nicolas.bouchinet@ssi.gouv.fr>,
        Joel Granados <j.granados@samsung.com>,
        Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "James E.J.
 Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jan Harkes
 <jaharkes@cs.cmu.edu>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton
 <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey
 <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker
 <anna@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Zhu Yanjun
 <yanjun.zhu@linux.dev>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian
 Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 4/6] sysctl: Fixes scsi_logging_level bounds
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <rgh2ffvmp2wlyupv6vw5s3qexuipgu6vdr2qsitgnbn6syk6ye@ln74xh26jdwp>
	(Joel Granados's message of "Mon, 3 Mar 2025 15:04:19 +0100")
Organization: Oracle Corporation
Message-ID: <yq134ftv8h4.fsf@ca-mkp.ca.oracle.com>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
	<20250224095826.16458-5-nicolas.bouchinet@clip-os.org>
	<yq1y0xubz40.fsf@ca-mkp.ca.oracle.com>
	<0a9869e0-d091-4568-a6e7-8d7d72b296a9@clip-os.org>
	<rgh2ffvmp2wlyupv6vw5s3qexuipgu6vdr2qsitgnbn6syk6ye@ln74xh26jdwp>
Date: Mon, 03 Mar 2025 21:24:43 -0500
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00016417.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:5) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|CH3PR10MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 5318e8d8-faa7-4d9e-0b3e-08dd5ac3ba5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?skE4iyxg9NhKY+NpoLbWF6qV0m3VHN6JpS87XrQi9hVG5AebgZcQmVTRn7IU?=
 =?us-ascii?Q?IkSudKBSvc//L3len6g7E0PhnF84HmmG5Hx5OMsf3GYCEBASdROALIblLxe0?=
 =?us-ascii?Q?Jc+Z6j2Zh5GCpBTB+D1tTxT0Q7YscP58Pqky8FRHL7bGgBxeE7kKj+KMMljW?=
 =?us-ascii?Q?v9EyU7jCKvsXRAOI4Gxuff/IPxstGyHi9BVdDBWPhYFlGgqQBB1QoV/RnZUc?=
 =?us-ascii?Q?yjuW7YSkD/1OmHhoVBjsipYDmKX0F8SQxlaPb7mgif3cduTONcRyaPwNhKNF?=
 =?us-ascii?Q?BpF2UpAFpYHKlv3cioP8X9dCZ3st8EV+YX2yNnv4pdzR+ihCh8FL6bm2+gMh?=
 =?us-ascii?Q?/+FMtH6jk2LaxYArnNiG1dGy0kl/6yhZiqUt4zHVK92UMSyoDke4MWdFniMu?=
 =?us-ascii?Q?pYW1lLzSylTX8yee+XeSSm66o07nHZ3FQA05ztcWj/Z2N98tkQPh8DR27nRS?=
 =?us-ascii?Q?eeBjpklcvXYQwL2CWmIOwNX2n9/qmiBQuFh9V8lrM3RUd4cewK6aG9YVgo1i?=
 =?us-ascii?Q?mBKUS0TNUXEVnlGG7R9Mf1yi2Q6jSAsLbA61QkGWe+ZRtt/ajhikf+UbGGIC?=
 =?us-ascii?Q?cV0UfMkBKM2ayAPSj0UKtX0RYbBuefcOT9ZSyKM2w1kh5GV7Bom8+vPhTfYV?=
 =?us-ascii?Q?O9V7kGilGKI0PRqembGY6z4CYLdxkPNAKtPrxz8DRfPMJG/tL6m8GzvJuIcD?=
 =?us-ascii?Q?7aBj+YnZpdPFvodSUvmK8KZFd5uf0igO3p7Qq5PikZ1uxTieZxFykPkh5UNZ?=
 =?us-ascii?Q?I0VFrkxDstC+qDBoaBfkh7ifCRXCMhNzP9B/q/qshv6KnxyO30S5RJJmh6Ra?=
 =?us-ascii?Q?PhJR9fsyN02GzawPrTA1NvDG5+sb+pZYDFWkaefyBGVL5CxMK+cC/ftwC9pj?=
 =?us-ascii?Q?A0DISOaihhLm+C1ulWvdfkn08DZHjO5Gnk1Xzhy8qPJ5lOx1VSwYhl/iqe/f?=
 =?us-ascii?Q?SZE7FbsYyk1kDZkXbDaMaQc9WczAsDk3nqTRmhzT5F5nS3l/TN0o+dRE7B/z?=
 =?us-ascii?Q?KH9B89SXZxwGNhgAJ1qMuwaqDtQEsggvNEQknthSfaCx8nXsuLQKPOSGHPXr?=
 =?us-ascii?Q?Jpp0RG7G0Um9vZrF3dIESedQcLIXGQwCK1393Luc7HTZhTDUKjIypwzScSZt?=
 =?us-ascii?Q?BqpeTGeFuY2zlo/Zirvu0zwM0MM/SKOA/Ki9qZcSh1Avtg01uYTCCd+9ep6K?=
 =?us-ascii?Q?0iMJ1IZDFsKZWQZ3KBo+0qUBWz3aOF7ET4Mje4xguw31pEnSHxqyystjNTJ7?=
 =?us-ascii?Q?561Xp0K33Z67Ihjde/a6/lUDj2Qx+fu7YsSJ0JOtmdVIkN3V1lpfp+w8259P?=
 =?us-ascii?Q?xWhit7U8gunsUgUWd2vrPyAKIx2ObHxDyKic9/x1zB7j/yR9+5HS9R+rIJef?=
 =?us-ascii?Q?xHkHNhXqFtxUr2Unu/bsVFe3R9kO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GY0PjWI222IkRlaTugppDfkfB7fFrtWxG9oU0Bry/9RiDkEXTHDJw9aDPV04?=
 =?us-ascii?Q?hInhn1YxTBLLlGxfJ3+Zrcn3oIqHLPMD/86MTsRnwFsIKg1bBbVuc3ANjduW?=
 =?us-ascii?Q?T9MRKUuL2SDWkfgELLIRl0nnNwxbvbIDwMdtu5R0/OJ0F/39q/4scdRavWyd?=
 =?us-ascii?Q?uLYVZBE06NdTAScQqpgPD5z2zQOAfQPvFXriyTJ3iVa6+TJ5/iJ0hgKDRhy2?=
 =?us-ascii?Q?Y2PbZkBWYj+2CpjLK6rHpFD7qyOzUwZX3E7heJ+xpQ7VM+enClahcouaiW3u?=
 =?us-ascii?Q?u2SlihNLl2G4wqglCIJNd6msc/yMEW1AlC5KZN2oLt6aewiU4PLz0bM639DX?=
 =?us-ascii?Q?Un4Mr2R5+ctgzVkU0sm4xn1f37iJyS+/wKq2M+JkS9gqP+hBvv7bxPhagoKp?=
 =?us-ascii?Q?1sD/HZxke9uoRbny1gWyiCCVjbxppQyLzMuZYDLXdz00TAK4IDEkaMuOfjKV?=
 =?us-ascii?Q?rCUm0GZLcFsoTZcJ2vzyegQwblVPQjfm2M/vykRfwsJoBoYq9zDcp+eXvhyl?=
 =?us-ascii?Q?u8UFR49TNBzKT+vQay6+OFUP9DuXSYWDWOp4QkEW/CJ9J/Wxic0H6LFzlJvi?=
 =?us-ascii?Q?dDhu+c2j8EXek34AJZoqB61Lg7PrNFQ5eDjTP56d1UDjU0gPw19lAZYnOOAU?=
 =?us-ascii?Q?ERILPTJrVZMTtjzZ6Cfrb/NgulLLEmDehktztLKNAaLaKWaH8cQs2uaWBLhb?=
 =?us-ascii?Q?eFTgh5oCJWz3wKlyLu00upbOkAsWpPyZ+unBDyb5IxtgJr2YG4u+HbiLdgU9?=
 =?us-ascii?Q?qlDOSE1u+rTZDw1gFvipa/m7DbPljuKTT7LZeVDLQ+LwZCfDN9BTf37M6F/d?=
 =?us-ascii?Q?QK8AbMUt1p6oPpPgYnJohSzTeual7T+0I/k0GIiL5xmf2lVH7q3A45faw1Hj?=
 =?us-ascii?Q?4FAvCJaBxNZPyCqQeVV8z2vxnUjQ8qbSfuN+47MJMe5YJ98KgDK40JJeCcbR?=
 =?us-ascii?Q?ZQHROCfy60HMJOhYL2vlZO1no5OMCB6wRe/yZDTTp2bbRLPEHE1ttQ9hg0qK?=
 =?us-ascii?Q?lUjc6Lfk3Ies9Ku3T3tY+tFZKdY09wexGfVHRgAJVUQyNuTI9pOxP1q0g13V?=
 =?us-ascii?Q?mwx8WgTjQCMv8SXUpi1DxktBOenEQY98bhnZ/OqGVSOktyy0fCpmHJeegZwr?=
 =?us-ascii?Q?VAR0JM/DMQnckBjm5UvS/BiogONHA7z1U1Vn0SPqxI4WbPabGVzUXBa2rqFQ?=
 =?us-ascii?Q?O+YSnB61M/TA/rJTxZ2NKxjp7gVKPH/gijGA0IYWIZEpx6rLP+1mtXiIY5IR?=
 =?us-ascii?Q?jKWaNLHK7btAEp9VNUzZgj++d01DB8AtQ3aN2ZZr0faIPfFK9OgaZpCC+asQ?=
 =?us-ascii?Q?c7rL//2tbGWJGWi0YyujLv690cstKYUjyo/hi80w/cm4vwz1QFPqWRfOtbsC?=
 =?us-ascii?Q?AclkgKyYyrJ4Mxc794ozk44Ib9JIoYg7zB0OgIB1njf/CEjCEGSpTQyKHUb8?=
 =?us-ascii?Q?1Q26GluAs0lSKR/s1yhC77FNx6F5mCZSHzAv9zMGiWojqip85maAFQnECYpv?=
 =?us-ascii?Q?SaY36+OXHURnzcx85UB1LnOMD+DenK9RTinzOo46Tvlpxg+izjo5OB1oYjhA?=
 =?us-ascii?Q?G6Or0so4qNCdywkLPIxNpNlPrzG7IxlV3XPR41hsSc3rZINfSCTmyNVvmnsW?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gxND69Fk5ctcH3+N/5xhF+RBbmEnAGwM9wvj9hmtvOGEOuaIdKUO0AR2nW4AUm/Pfh3FV1ZBq3S0AvQhu1vOgQXATcyuGfEoJADfGkDROuZ7xTjw8ozjcSsg3Y0aP/+PW5FXC6HpldVHhjStXvHzG17oNcTw3dLZX6Dr4LkShlGE5WsMkqJPVUa1Kg8I+e2JZYbjSRdGi2CYP2St69At2kyprAUqWfH/9qa5o/YDrDqMwX45t4B7GcBentCMGfnzashPPgqoHFZI1SyVY1pW3khqhV1GBloctztCgeQ776GmsYPhDRkdJmJHQeOVDT/H4L0h7a4isbNwZrDiTHQy530cHQ55icxlTtziIl8vPsh4fzyK0g1qdWXfC2jhN+HyMP0rqesoEJEK1wB43X+uxDFayqDum0wYsZ+SV2k6KU8NasFqfEaV2EDY6ZTcM0h8AgwasMPtRhzvAC9KGW3Nt/8JEsgdqlLyS2cvtrwM39DSYWGbFJBxuB2C5fXOhSXfbc2m1p3pCq5qD79QGpakI3d1oS0mPuqt5q9m2ol5RAleHv95iR/rP4rF/T+iRZPHp552LfJQkmgG9X/AA7zrioaOdi2D+Fcmrm/jddtTncE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5318e8d8-faa7-4d9e-0b3e-08dd5ac3ba5c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:24:44.9550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LD6PXVF2c0HVUUnQBuO7ZRLeYrb3gN6AD+fsLEJT8IXahgsszOojGh8KEKtOkeKcYnDjhUnPpyMOzEr5dhCj6pABJvGo63iOVbEHt92CWpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7258
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_01,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=929 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503040019
X-Proofpoint-ORIG-GUID: 5WA9QpFoOR-FrJACgyrXVIGCU6ynnUVX
X-Proofpoint-GUID: 5WA9QpFoOR-FrJACgyrXVIGCU6ynnUVX


Joel,

> 1. Having the upper bound be SYSCTL_INT_MAX is not necessary (as it is
>    silently capped by proc_dointvec_minmax, but it is good to have as it
>    adds to the understanding on what the range of the values are.
>
> 2. Having the lower bound capped by SYSCTL_ZERO is needed as it will
>    prevent ppl trying to assigning negative values to the unsigned integer
>
> Let me know if you take this through the scsi subsystem so I know to
> drop it from sysctl 

Applied to 6.15/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

