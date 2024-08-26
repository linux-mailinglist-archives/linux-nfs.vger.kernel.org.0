Return-Path: <linux-nfs+bounces-5777-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2CB95F6A4
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 18:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8195E1C20C0B
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 16:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14D61946A8;
	Mon, 26 Aug 2024 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZBhSKsg0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AkyOaoKR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009D51865E7;
	Mon, 26 Aug 2024 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690102; cv=fail; b=Aqt25MpmObIwW7BOq6ujsPl7wxyPM/J8AI6aZmR4i2YQscIXfx6raXZKrbu1Sk8laXh1bjJnbAYOs6T8vr5iVbeHu5VO/xj09KUGyRpj0MN2nmHG/FrddTsOCAf1wRvLhYQCuWhotqlvBr//VtYMTZE8XMbhP1PH82OLP5yPYrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690102; c=relaxed/simple;
	bh=ZGQxVBantjJ/1q+hY/Us9xTf+rMeIkMYPzB0fziuhYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S76wNaqJ7BUxkLC2S5fYGNdrwsRHRzbzaQ8e9K0mpVe2JlIb3umlAIQYKWtDAsK7ZnjU+Ytabk1PlMJHfsIwr8z3wnr8vgEM7o56qkP2BHOG2CJWMpac2BSO+/tamMZdReOn7X00/nT+dtDCBpWDDymbm9PoRpdqdA0ZZsrlyoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZBhSKsg0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AkyOaoKR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QEfTwF020543;
	Mon, 26 Aug 2024 16:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=g3tk5vQjpHJtE3+
	tAQoWaD610XPoSqAcQHvGBCbgp/w=; b=ZBhSKsg0dpN15JlGorz6zUYX2xcG9te
	yWZsRUf5Q3Azn+Lovs7BWz/pPJ0q9X9lEQZ5abq0ewy542/X5jxJSfLH1CIfrkwB
	TXw79cI1b+3g3nlyhW4uGbbN7LvVCtCv9z9AVB0MuXikwkcdkd48inQjPUgOpxNU
	zMYu9tPqR2sCuxd4mN1jWuXv9rJQQFtYYFir5n7kO8NMxBI1gcIbEuAquK66auuI
	TC3DmMzMpD471jjUAq3OcED0q7bwRmMfPPiRdJWMZXfsHeFw4JxY5jeQvm9MGDZm
	ZFXTwGT+PvBeUtPXsrbtWYUzpTBkTtyMMe0c2A/nhpLWWOeP1KHXuuQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177u6kmc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 16:34:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47QFBFFn032584;
	Mon, 26 Aug 2024 16:34:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0srhcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 16:34:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vldziI6OBDF9XI1y+uHcNEluZiksA42UXc9nonasQfWfzEqXb5AJ4GvwjqE439JM/6x90bifTWmXPXsMCYbhQwLf4/JkR8VFvCTQ2uqUlRvnWdMcHsvvld7gAAIawkJQ+iZGRVQebjbdB+YFXAmb8sM+h2lx6oQpLoxNGANriTt1KGwtohXY2QC+dnKL7S0u72VXPMRCuM8f2+3cfepDWqulkC2iYXhB3hO3zYFnSLOK5+obCehYkSgg0GQDuZ0/CJuAYCKCp08g3rxyinjZYswTeYeGA/r3WOg+0BEBc2gSOCVNHzUo5Y0kC6zqd1+XuWREU7ZJdFbtNDrEfN1VoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3tk5vQjpHJtE3+tAQoWaD610XPoSqAcQHvGBCbgp/w=;
 b=YlHb76vkC9wSv2ca79WLq9drsTOv4AO9sH7TIyIm8wGgs/w3zmTKN/pbCJ9/LATz1nhLHU3rQh6XKuvP0ldDmu6Dk4VQZQ0zpx+dr2RCkQBqauLlnuDnhl1pBB1PluFEzcY/m15AKFmRhuRRS/lE+yBlLPXatdCPjDJU8+6mRR1PUoqe9/iGXtRJi6HNa8W5jrp1YITDm2gPdK+sXSVy3A3vrbYbPaKfCTx7RfoHEx90I79u29/YZPAjs/e7p0H+A3Ft4WjmAEhpDM0RsPcPRPKkcKauFhLBOtBbmCcve3Ln9OXbiPBQPscRbthjgil+fiOMa/KeKHhzXD+m6VVWNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3tk5vQjpHJtE3+tAQoWaD610XPoSqAcQHvGBCbgp/w=;
 b=AkyOaoKRiECHETMOHPVeFbmLZs1UEqrb3SNQbVpycKCWdUzmAXQULYQimonzVum+Bbxbewid8WxBKcVRhHU/V+j6Hr3tJUn+Fo1A1xftXfqribPYaC/jxtZYe5hBBcs0reNSjbZd4CfWYIL/z2aOV7i9SEelcMwBvVbFA9bkiE4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4158.namprd10.prod.outlook.com (2603:10b6:208:198::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Mon, 26 Aug
 2024 16:34:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.012; Mon, 26 Aug 2024
 16:34:45 +0000
Date: Mon, 26 Aug 2024 12:34:42 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] nfsd: callback debugging improvements
Message-ID: <ZsyuoguedPdtOcam@tissot.1015granger.net>
References: <20240826-nfsd-cb-v1-0-82d3a4e5913b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-nfsd-cb-v1-0-82d3a4e5913b@kernel.org>
X-ClientProxiedBy: CH2PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:610:4e::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4158:EE_
X-MS-Office365-Filtering-Correlation-Id: 42729502-7810-4cad-7301-08dcc5ecfe97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lId9LLwf/0GG+uTjTLt4NLUEwKdH4S9W78UfmoN3EGh67l639467ZDRCY0qG?=
 =?us-ascii?Q?Y20da2hpk7G+7DWEyBMxuHdK6ILjbGMWgxmc81ajpV5vzp7Wc344y/ycAW1t?=
 =?us-ascii?Q?cbiMVStYhjk4Kz9/MpRwrVUoUUJexrJtC4x9b6fnLKeOXqdwp7mGv4joi153?=
 =?us-ascii?Q?Xw0ZOpAlKe5f+OKDdYQlnyDVBQxJ7tvj/W0QWXmoixNuHXg+x+OcCsxAsPCk?=
 =?us-ascii?Q?j2iEcbSB+F9ntflLfTUZQoHLvbuK4djEHDI+7/l7e+zeFaXpf1jXAMbbLpJS?=
 =?us-ascii?Q?f6VfX0MT6o5OOMYUls4xL/Qzt+bD8BjTKkks+tSvQ66oaqkYpYX41wjupZyl?=
 =?us-ascii?Q?epCjl+22TRernRAud/3prl8pS7MjkHvFD1nxcK3G1XSo0iTnKVj3UcEdQZqo?=
 =?us-ascii?Q?zN91Pm+kciuAuRO9Un/5e2y4l9KTkO8CqqoCfY9Sls6+4X6YFAufTx00szGc?=
 =?us-ascii?Q?GgwvITQbNPAOQNJsOfbhDZTgX+SQ+m1HYIkC5SDJuhgcUV37WT/6kTfNN/t6?=
 =?us-ascii?Q?EOa6XfvEN746zWmBMvKgiq+ZeKTR2t8XQ4Lgi4U0hT6bHHHQT2J2iURynwIc?=
 =?us-ascii?Q?yBzhW+eHg+oG4dpVUxTCliTJBv2A0Qy9WAekSqZ+c3jfJmgcbZX2a79iiC77?=
 =?us-ascii?Q?qJgvBMbNnhnRfMJT0ihOdaNSZ0Y0mnmvObjltZF+uD1t5cuFn1yf9NFh5J6z?=
 =?us-ascii?Q?3ndUmHFxnWeW9UM+vV9EAlRnsdKi/PLDYpgQN0uqClmtMASmK5ijZ2o5yzmn?=
 =?us-ascii?Q?BwhN8+pWFUxuxar8eisDbPuInAA58JSpFx9JUedWRJ7/UTkNIHst/3wbPd5M?=
 =?us-ascii?Q?hdHN3VOKBGXCmtf3quKP4COccyXM+uGfvFD+yOs6zUnR+zdhfBDkHiTdkVkv?=
 =?us-ascii?Q?Lap2Ar3WTY2a00efA5Dls/ZDM3QWRbJQFp0mwMHJn84CNc1LzxV8vWRLkgJg?=
 =?us-ascii?Q?obIdIHrY1npChWjWag6Q4iQHWERStPlq7PEwGQWkBUnA9h5SxKZ7gIsDHdlC?=
 =?us-ascii?Q?RVYsCNDHjmLT15G1Pw2Om/aL9DBPR60ZFiFSjr4cTCfX3IrAqifPQK+wQk0H?=
 =?us-ascii?Q?ca3dl0/XDB0eFWIckl5uINGV2C7JkfYBnkMgf2IOpiKXjPgZpruO92TMnJYH?=
 =?us-ascii?Q?5Jo/9mHwylgQ1i5PLEL5KRW1mc+FJBOHUW0DQ22E16czsTfcXPTdOMxK+K5A?=
 =?us-ascii?Q?RTKXnjUXVfm++M2aL/NcFt/UeSK78LOrM5bL9oacbj7fhr5vfziRBzXc5kc1?=
 =?us-ascii?Q?y1xuEPhE6yYns9RBjZ4ZR5SabqFuxiiwhrEy0VWseDu3m0lWFAddW/g5SD8F?=
 =?us-ascii?Q?tCceNrkTDydxoUhRZKqpxsKOzuY4u/XYEVfmtW4nET13JA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ucu6fk4iGzCvvihWBGTZm0EIP57bTRb5FRCMMvQ0UwYF3dY0koAf5ssF+UXi?=
 =?us-ascii?Q?BPkyqdVW11ROLgxizwfhAu1O8xmNXVhONKYymB3YcDg+2XKn8hSHO/9UwQGX?=
 =?us-ascii?Q?j5+9k5wU1PIOQhRTf6tUJV89mgqNG7LIkNjhlWJ8tJDGOW/tTu3d9YmOiwdk?=
 =?us-ascii?Q?odWJvDOwfjzJ2NnB1cHgJ2BIladlQTxMKr/ElzdmePS0oUk28LiUNNEqg+B8?=
 =?us-ascii?Q?014Y0Rt0COueKvDW1GjYhF5kR3RPDS8IZydRhTzYCrP+bBfU17/ybqIcFQB9?=
 =?us-ascii?Q?CNDdkls0NlgA6zLtg6dsbPpDo7GHsdZfTewGorTWwzBGLdftqQ4vXC1RLVqf?=
 =?us-ascii?Q?ltl0zprzuuq+kPsxWkV3kPy5qZL7zUHa+jFNifraS95zGp7Df/Hxg18E47w3?=
 =?us-ascii?Q?QCoDe4fKqrSOz/b/OSl7Z8zgQCZUMgMU8UH4yUeDMS8k4/sQ2hQMW4crpkKM?=
 =?us-ascii?Q?Ywli5l3XsY6kE0EM9ifi/C849FGALaay0OqG1cqjTwvrVu9tLUcs8e0kOAU3?=
 =?us-ascii?Q?rGYLe+1Dnv1kyOtW4CFzPQNd6Gpn3alFb8H2B2YdLaF+vEMJgnA8PiGqNC2o?=
 =?us-ascii?Q?1cn3mZRolcbRUt87KDVC7tIP2fDrgx1xXFv8ddvCeb9PaRFdX1a/0ky/R/k3?=
 =?us-ascii?Q?z1uWR46rvtQrpKSQCyGo2mfr5Drep435cI+q84wPk+X0OoC9O1MZOnyglLJZ?=
 =?us-ascii?Q?tX6S2vj4T2tLJk46AyuvVCVotu4DV/uZ2pIHnTV3DBiCOr/gRof+ykZpfyNH?=
 =?us-ascii?Q?Z7UncTvjj5BIUAKnQfFunP97ev1m0u72UM7z5EZI1WK4ecc7CbTCKbfi1R/T?=
 =?us-ascii?Q?2h1yq5Xgpx5xr8PE3RivnSOgDkW6miRpYHwCEylTU2uqQAMmGjii8/EpjBg1?=
 =?us-ascii?Q?1TBdWB5gopxkKqyy/fLQ4fj9nIeWB1bxSuns7G1aRwl4mkVFRfJonx3KjZ+b?=
 =?us-ascii?Q?7V8BFlp6vZM/JWHWaypN+YLzCn1bgfc+M0qWNYYCcmP5IF6u/5A7FRhqpJPX?=
 =?us-ascii?Q?Mv5y/yjYnS/nSnvuFlgBO00j7skdFEi8hn6qpMf7V6HpJ6m8SN2Ittyrc7tl?=
 =?us-ascii?Q?y5f8H6ttasywCppZWSqdzg7d1Fdc0Z6dsCB/oRcifqHaW2a8DYTxtJy1uRgy?=
 =?us-ascii?Q?7zwANoeNv1dGfLzNmrFsOYaBNYjph1410akixViHQRGqg/SXnekyjWl/hVb/?=
 =?us-ascii?Q?OkOgG+SnmNP2V1CByL8SsZ6h/S/epoB+WMPU3/dzQNP+tYX8AhsWfplCRZuk?=
 =?us-ascii?Q?pI2SOOiSrvmB33voi7d7SfqqmvDzSyREZnhEONewuU9VKzcysLoPyCzWn+Te?=
 =?us-ascii?Q?oVGSdg2kvbkYTipVJGif/T2N1wpMqqFBBVgVfe1NMeKYERV2POBpn3zq+C6W?=
 =?us-ascii?Q?O6Jz9DCcIXS33eiFzvtmSlMYv8pm4ZN/CHT6AL+Jo1c4hOdOLsO3+dB/LCmU?=
 =?us-ascii?Q?+G1GkyoorlWqq1C+2cHbsLeKJo9ZB8gEyddMdHr3hVK5kyBxGV1VnXCDCKuJ?=
 =?us-ascii?Q?iHUEkk+nY4S/lnPk5J4yGym6bvwGY9nbG+m4/ILWSDuE52j27XYrZ9bd8+Ws?=
 =?us-ascii?Q?sjmxV0XyPiFqHs0z1vX9MHUVzxbMSiBGzMUjmDtZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ozSjxiTeO7ro5oLrC5W6NmUHIeErXRbh07UYe1Y93j+1HqKJrcVZKlR1x52Y4/JiHAA2Lz3G9cooEem1jsR0yOPz1NvUOBlKf55CPdCP7lNYoTVPhU3MghI7FmJBX+1VX7ZNIJ/aqnTF/gIOFeGxq5VL6oF34lYUdXEQWikY6aYU5h2fqDhmB+kW3j4mygOOewguOfCKXUmAnwBLv110iJiIp0hClVvJl8Kb/j0/s2vLu003nw+7IUWIjXlggBGthAy7tZiuyGxums/jTcSuUa1NKEAR6spgQlcDPlyjJ951Y0WgDAf6S1sqiLMogp2Yrf0076e071MnjkTWiRBY4iwk4g9z0AqW8uriLiQGF10GYyr5RPy/e6bkrcoGlKXoMtAV5ALTdtH5uy1TgX/wMrWBTAIMojmP1HA3qZJnRZrXb8uP7QWtSfXI5jajOcnSNCK1+m5xxbE5ifW/a98SY1/5xI4TlsQkH8CKdrnLprWXEzCtVSZRGOpnEpFfl99uBz+DGGGBYq8y7HB3mXYo7U8ZXiwRSBScLiUCPp5RvmIzW4KasBWVH6fFlXBcoRGbPQGaCnft37pIu0ZsLNn0HkFRdRYq38C4DYqA3wNbN40=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42729502-7810-4cad-7301-08dcc5ecfe97
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 16:34:45.5691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9J97D/kA/nIFb1K29JU8YNW73Zmh2heAjPk9qfY6s5GCe4IN9DV0dRWCJ0mA9WWb0eIGy+Hzu7J5gRHcs7SBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_12,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=604 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408260126
X-Proofpoint-ORIG-GUID: m3GWXIdnaZcZrmDTsIkkJNsEAKxGXt3g
X-Proofpoint-GUID: m3GWXIdnaZcZrmDTsIkkJNsEAKxGXt3g

On Mon, 26 Aug 2024 08:50:10 -0400, Jeff Layton wrote:
> While working on the delstid patches, I had a couple of bugs that caused
> problems during the callback handling. They're now fixed, but these
> patches helped me sort out the problems.
> 
> 

Applied to nfsd-next for v6.12, thanks!

[1/3] nfsd: add more info to WARN_ON_ONCE on failed callbacks
      commit: 53d519333daf57adc2e682b8316a14afc4dfce6f
[2/3] nfsd: track the main opcode for callbacks
      commit: 17d2b21a691f364710f7ed4192dc3236e44decb0
[3/3] nfsd: add more nfsd_cb tracepoints
      commit: 548ddf619060262afc87db275d644b7f6ee6cbfb

-- 
Chuck Lever

