Return-Path: <linux-nfs+bounces-4441-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B0991D3C5
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 22:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8903B2815D0
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 20:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B932200C1;
	Sun, 30 Jun 2024 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ei9ixiI4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="njaQ2Tok"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD482110F
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719778577; cv=fail; b=AOrXeLOi8KlbOHr03E9gZbfKS4mgXrUPBSh59F9a+i8GeMJg5mjkjvcRPgfV/aV+PGPUT1pnaiGRCK/EM3Pn8yVVKT3zJgstlouNCrABs2pzWBznLzuo3SdP8mwSkeiGAO8pV6SZLyTruhBm7/qBVD1fGrnhtjlOrHVFx+Jew+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719778577; c=relaxed/simple;
	bh=Ct4tR8Xpu9WWVOrzHRu+62y8D5zCdIET4hqA9MRWILU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EOrzJMJw/MX0F5ndv7Pevs4su48wA7r1i8vrKhDrqNKDVIH7dTsTZdbmmJ8Znb7l9nfXBGTw5wdqH60IKttIdl9rAzLujZBtAYAfwR3VMteP47htHUQwnRaP+JQjA75BABOuQYAVPy7Onm/cMgUrTh/fw8opz+eUmVQdQEqDePY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ei9ixiI4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=njaQ2Tok; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UINw3c017337;
	Sun, 30 Jun 2024 20:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=mSQFGLj/OzVZjre
	LKijZXqtTBfZFe4xhV+nt2Y324LM=; b=Ei9ixiI4EL+SkMzxzvwOXrTjlh1mn/N
	fpSiNJhquX3CbXWTgnTR4JrP6Acs7gcBti7lPo4FvnCOVWV5S65fTW6nVcsr0sWo
	l870+lLdNOcYmHYoiTcyB/dnHE9wJmfZXo2ZKqQIGsoQsGlaUmxGZa+Wo9jAYLES
	VHTqsb4xi0aZnvUcFXoELdfiZ5OCMxyAXc7cKupHoBE8LDg93BCkRDfZOpLMcaxh
	ZrwxsKON2khK0pNHIF7boLmWqD8KJXeCYBDD+t0EHD1A91VisaHulUoqfs43hGZC
	TcybaCAn5nc5OTNOrIuH1EmL5tNZeZd13ALJ01V5MF7pBAxFXwDCPLQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028pchgwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 20:16:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45UF9nXp010014;
	Sun, 30 Jun 2024 20:16:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q5sctt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 20:16:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTgy2f/5vUpU/6KDPR03av87N6k0t7w7m1DvrSZ01Uy3FvUH3/PAVTl7kxT4pmvHFHAo7mRMk3Z3YPsa16eic/AI8pU72phxTcBseXtY+8qdbGsde+/CvkNKyknWoQ6wUN80/wsSYKmG+XZ5OQnwnzqBL0PBlIGY6OBHC7T/hhhvA+z6EPpqzI0AO7LOmHtazTNxtzLdsLF2m0h4PuyvuICHG/WQTc+fXf+RXv+34+odu3BhCenYo0rudR2qNolkx+LqkZlOJlKi2AkbNjCeAo6AqeZDH2XoLGvDSOJnKrzG6bSVSHUYU6LZVe/zNw1d92Mc//UHGpbhPyGjbqzE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSQFGLj/OzVZjreLKijZXqtTBfZFe4xhV+nt2Y324LM=;
 b=FZ92/wp+dM0qZSLHfeOxelUGmAtYDNZONdzu3SvFa2T+UT/5hCSZqSXxucx++PVmD1YkdoJkjI2Y9joUOFYzC+TN0bbSyYC/wIo4bNTBFzbjmu1JWXPaKwzzvAjf6Gt4S2aHlPePA0XEB1nUpOCDQhGRDHUqkHqkhZc2lvtNpbVdWyyA3KE4qMhz/UtuE6vR+wdc7dnLegd1JmgtUMIybRznT7Xfq86Znzjd/eP2kdD7Y8du2C3O8nv+E/d5xfO0Oj/Q5YNGhyChs0QEhCludfWzoevIFNq7kPpdWHpDD2N6hGcnYO6qG2yGTYouA+2/+mwAzZfiH1ffLRP+5iEBIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSQFGLj/OzVZjreLKijZXqtTBfZFe4xhV+nt2Y324LM=;
 b=njaQ2Tokf3KqXKF6FFX8ohrS1kf3+6vtnmdDCheLpx5B8uWn9C0cmN+04rsF2IvaO4oNZmnpEtUIidTxyzeO2d4SQzWQx8Uz03pL9FIUBwx2g7a7iVR/r9hzqZhTFIgu/CmqOM139mr5d6FoipvVACvkKFLJtGUwA/hx7Pn786o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4618.namprd10.prod.outlook.com (2603:10b6:806:11f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 20:16:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 20:16:02 +0000
Date: Sun, 30 Jun 2024 16:15:58 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        snitzer@hammerspace.com
Subject: Re: [PATCH v9 13/19] nfsd: add "localio" support
Message-ID: <ZoG8/pVzArlbowM+@tissot.1015granger.net>
References: <20240628211105.54736-1-snitzer@kernel.org>
 <20240628211105.54736-14-snitzer@kernel.org>
 <ZoCIQjxougYwplsp@tissot.1015granger.net>
 <ZoFwj0gkBf3Pr1RI@tissot.1015granger.net>
 <ZoG1pF_sgAUDoH-n@kernel.org>
 <359d5b252f6f5a7eb348c79beb00a9e6594b743c.camel@kernel.org>
 <ZoG4QOGLTy/0zsS0@tissot.1015granger.net>
 <de0cd43fe008c32bfe6e3c983256862fb5ffb9c6.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de0cd43fe008c32bfe6e3c983256862fb5ffb9c6.camel@kernel.org>
X-ClientProxiedBy: CH5PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4618:EE_
X-MS-Office365-Filtering-Correlation-Id: d58d26e6-199f-49e9-5cf3-08dc994176f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qa+n2OTS2uDFbhgySfPbTrIqX5iegY8Kzz4s25qJjKYH1ruIfzCtaYjohO5m?=
 =?us-ascii?Q?HJkd9qaQXw3xC/mX5wgyxh5gotoSzOAxDXNooY8f5p9hIC6CAnUzEoC69VB8?=
 =?us-ascii?Q?xSeYP+Y1d1QPFvzC0EQ1qGTbFekIZSsVLu7PDT2dj/vagrfxdB662VYVEDMn?=
 =?us-ascii?Q?rSGyUh64xBOhfXwAAPuZM3GHEZwSYyJV3VEab0ZY1PbPU72pWvk+20fTdi1e?=
 =?us-ascii?Q?5myHRwQYuwKV0oVau/aU2zeJ4gJHwfEfmcqBuHEvd5KGwDpkl0HG7AGtEAwQ?=
 =?us-ascii?Q?ZJYPvun4H2Z3boM+ulkhGmmv5oYn1JN91E5xWUEbstERGlgntAgGLYB4jf5O?=
 =?us-ascii?Q?to+pOc25gHa88qoUP0xbtEXVNY0+hzLGZ/NmAsAuD7wjMe5HaDkSLBjR8asR?=
 =?us-ascii?Q?4ym/P685xYi/7HDHkeZ2EkgakfQZlK+c4DQ/atKO/pDkfrjl5lKAx4iGn6qC?=
 =?us-ascii?Q?Z+ALuNneJ8jO3yLwqbbZBNo7Eok89DEriY3evRoPClaA/baxBHBNkDcNtAQa?=
 =?us-ascii?Q?xmbjAJOCJ5keYgtHoGgYyWd12y3JTnlCgR44VX+h9UNx5O/Ojj8HT+gVmueY?=
 =?us-ascii?Q?kT1QcvZzdqVKx5NsvSJcXzN/MtyrQR6e+RGNx4fXQ9HqlG4SaiBw06jVupRT?=
 =?us-ascii?Q?lffamJK6N/TCp+j98QbU9ijnPf/F485VpwiYMAjEDGZ8885k9JpkNN3CE7vA?=
 =?us-ascii?Q?KPMHU1iXq/2WvMoj4GKSajAXHOPGJipu9CnmjiHE0wr9WnElcYZknl9KffTQ?=
 =?us-ascii?Q?nluEZcoDrkdgmPHOBODb8WbFDGOQJ7Eycr1VrvwOwRg0z+08QgIurB3ZUt4G?=
 =?us-ascii?Q?qLaNHCKI/985GQZa3LyYSAvtQtkn+y+Q3nOrYmS+wNhYXOeR0uL6ML0iZzHZ?=
 =?us-ascii?Q?McLXWR1q7iHdEXoqdecImRzSsYnPB93YtxiVDT7dkeCrYVKYc3yhgUt6fxXo?=
 =?us-ascii?Q?NkmHy4QC6d15lBvl9whgvzrquyOBthhH6CRPNpuK+DWmd0OoAXe/piArERoR?=
 =?us-ascii?Q?CVPE8v6oPsv1MkD5ePUwD16VmffYCBfSJeU+UprbT5dvNzFxEHM7QrOnaf88?=
 =?us-ascii?Q?Dz/ghwvbiNd/p0bkd29DhhxdQPIDbHpXrEfKMxhsJS1Tk7NsyjcRI87Q6GaT?=
 =?us-ascii?Q?IBBpnq5R49vFcFy0Y6MMMKX2Dp834AzOwd50BjOLLfUDK5Sc3rPQxzuuah+f?=
 =?us-ascii?Q?jLipDPXu+Om/30Mc5AYd7wHLRR1oc04XQKFWGFFAgcNbBtQOahRno1KtMKcy?=
 =?us-ascii?Q?yeTpn/qRJXgXmN0cqgPtf9UCcnwpVhQYrR6OkEaq0IqfOkd6ksBt1l8Ow4N9?=
 =?us-ascii?Q?3ytqkbYAWvsJBKpMnvWYHwErsA3Ki1PkKRRwyYXUWYKXhg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RzjHDMQsdwd7DDnHtkUTXJ64Rq9hO+H9pMBZVT8wGMuuMwti5aExNEdseMWy?=
 =?us-ascii?Q?LCiBwspwDVy2VHyEItC85IKK3ZNfkJ0zMrknMXUfjvTWNLm5phO1SRLF+las?=
 =?us-ascii?Q?XCHicOE13zyCdlaTUBt5AIotjgfLrxPLaEJbXRtEMSzTuiVORgczoHzaGqDa?=
 =?us-ascii?Q?zA8zg2cANJgZU0sSg0w6rVioXka3XskporHQxMUzekF4dTQqyr81b5HY9ABx?=
 =?us-ascii?Q?SkoHJDi67ZWiLwBEmc0CvvPaJgnXmO/eQqART70xsQtveoZb4UWQWpV/8iS5?=
 =?us-ascii?Q?631fHpdOZWcgAfqbkJbfL33RicLweO3SgBFS5aOT9qHXTAozoqetFvlBJiTZ?=
 =?us-ascii?Q?9bA+M5xmcQPO0HFX7pPx35G3VRzl56p/iJGg3G+N5Q+CLhEyE5ozJ+uLaTpK?=
 =?us-ascii?Q?sC6A+nnq0uWRzU2o8Gx57gp6ChYnVboSqTA6wdTop902SERpCZBOgeAY6hlN?=
 =?us-ascii?Q?vaeV5oBbx0HPE02lm9NEX+1omMM8s3X+ey/iUbU7rUFJVR40n7pyGe73vyVB?=
 =?us-ascii?Q?bZbNtO8SczA5fpkXd8Q/Jrfmhq/FBvnSzcPdiBpurV2MXhx0uUuiu1S6ErnU?=
 =?us-ascii?Q?m7+FEaS/+xRluqVhQxqwomhKFchMxgPPzyUPbkCqcMta4+/etrmLyueJI7xR?=
 =?us-ascii?Q?UOGbzjTVI1trlDfcf45ooDx88fTCHkXsFXtelX2b2V/DrFD+IwaCWaT8f+/E?=
 =?us-ascii?Q?V44LdrBu+f5XA7lUxP+JVkIEqXbwzEyrlm/osCHk8O6IPSsf6Ff/QRzzye/F?=
 =?us-ascii?Q?RcK8gQof3sq2r6cMk3YdOI804DF486PVqVqzqLDzafSA4DrJgIFzK5KWywRk?=
 =?us-ascii?Q?brrMXgLmj9KyE0feewt0iGwUUJEYX0AtIfPGKzBUcBaoRZcsa7kjpFUFUaGS?=
 =?us-ascii?Q?DFRAmfCV4dcbrtPWiaXYqmGYC87xikIn7PPNSruiYEnFyytKftPVNEs0PM9p?=
 =?us-ascii?Q?yZaJFWsW6H1nwuyGR3ztHmjCGaz1XAUaJtY8lSrEhsgjRBpZwJNN0TMYwG3a?=
 =?us-ascii?Q?qK//f3SPpKCCFj4j6bxZEi13nZjaqiBmP3/DlGIjTGdSTtr7KDahm91qdams?=
 =?us-ascii?Q?6b/lAlxoIAX3+fwCDlU/zsUOFZF3h4kOcjP4gfac0+PTucFHJ9bjzF7Gn3iT?=
 =?us-ascii?Q?bPJghzKIAD7nx9ai/HutpRSXQWXG39OPwYDfPgofdvI+KZMqVO7npqsWUqWj?=
 =?us-ascii?Q?GLr+XZ1btIGRzURAAP7IhW7OquiAH1z8SgnBNQoG9fN0nK4FM7oQbTMyRFzb?=
 =?us-ascii?Q?F81wIxFOPNw/bhxYS8u3WN78ciltcddf/QWyPkH3SZ4vMFnVgbJss5E0sKz6?=
 =?us-ascii?Q?lukCyYNljRWGdRxjqQyOUROJLImfEmlH4h/clkhRCW2Ku1TL6RamgutAqUrt?=
 =?us-ascii?Q?HwDddqUiyyDYU46YFLp+e914h9mG2hn8ZVNTZurLvWQSGwJzRUPHCUhhjuDI?=
 =?us-ascii?Q?STIITMHHxB2DarCGkdyOD2UZ/nPPZWGjq2b2KWQNUTYolPZOZUQYamZ8lsVg?=
 =?us-ascii?Q?H83SS41uWp2B09XNKqUBwtcmFu53kCzS5oYoS8oNuBw5bUc+6rYxStia04uF?=
 =?us-ascii?Q?HcwtujvWTP2YK6i4AgNyw79YrN7JsK3pbLq4VBZH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/NWtZ9rJAnY0faZ6TBCUTopoAZULCt+Wf3l/hcNkT6yGYsvNvgaRFhPZ3gH0lqxCSJxIhyVxavkZSQps0joo4RhM/7vFYqp5CqzmRoM5EV544Zawmikm3NxWY2f1hyx+9YghYnh93U29r7oYUYOV8yuQzjzG36cgTL3wFglwDK4nS4NoqcGgzoYwaeiQ6qyQ6f0Rx/ip1BKRNLsCV207K6a2vyCpMqUvv2i5p3hsiB+bf8ZXjludrO+OINx6FK4z5T/gwSsQD5u2uG+Wnmhm3agyLz1EUG0u90D0oiusGzMmC6eies+zsglntWjeOeSlAZi/22v6I3bu4nisR/n+GMesxpbPVOd0TWhL+LPtSCTQEwoXnFpJbQOiDIDIFik7QMAVEu9p+qR0iBkcNxpWNljx4t4+15hWjSaSYADgCyMHhUr4I5b9JhipMQmm+qDA4V7KNIJfQ8sEu0QpTx/QhtOmDBVFoQoU855g9UDqTho/xrE9+1vx8ZzT47X/1hnhtS3PYcl2Iuq6HVGoahgl3xNUn231MTqf5eRKN3qpjwpauaUnPH60aQfpeyR6bksY9E6qYWPmpEtFtaJuLtjypDSodH94NByXSpoc2BEYBtY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58d26e6-199f-49e9-5cf3-08dc994176f0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 20:16:02.8621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hX92r8UPejDshmMczwErH7jHC6ESZKcpB5p4ORP/XHcOkO649bEytGoFTa+DXJsFaiTGNj2GalqvWxfS0s53Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_16,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406300161
X-Proofpoint-GUID: wvjKdKdQNp7eATGt2Du5gJT26ccCIB6U
X-Proofpoint-ORIG-GUID: wvjKdKdQNp7eATGt2Du5gJT26ccCIB6U

On Sun, Jun 30, 2024 at 03:59:58PM -0400, Jeff Layton wrote:
> On Sun, 2024-06-30 at 15:55 -0400, Chuck Lever wrote:
> > On Sun, Jun 30, 2024 at 03:52:51PM -0400, Jeff Layton wrote:
> > > On Sun, 2024-06-30 at 15:44 -0400, Mike Snitzer wrote:
> > > > On Sun, Jun 30, 2024 at 10:49:51AM -0400, Chuck Lever wrote:
> > > > > On Sat, Jun 29, 2024 at 06:18:42PM -0400, Chuck Lever wrote:
> > > > > > > +
> > > > > > > +	/* nfs_fh -> svc_fh */
> > > > > > > +	if (nfs_fh->size > NFS4_FHSIZE) {
> > > > > > > +		status = -EINVAL;
> > > > > > > +		goto out;
> > > > > > > +	}
> > > > > > > +	fh_init(&fh, NFS4_FHSIZE);
> > > > > > > +	fh.fh_handle.fh_size = nfs_fh->size;
> > > > > > > +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> > > > > > > +
> > > > > > > +	if (fmode & FMODE_READ)
> > > > > > > +		mayflags |= NFSD_MAY_READ;
> > > > > > > +	if (fmode & FMODE_WRITE)
> > > > > > > +		mayflags |= NFSD_MAY_WRITE;
> > > > > > > +
> > > > > > > +	beres = nfsd_file_acquire(rqstp, &fh, mayflags, &nf);
> > > > > > > +	if (beres) {
> > > > > > > +		status = nfs_stat_to_errno(be32_to_cpu(beres));
> > > > > > > +		goto out_fh_put;
> > > > > > > +	}
> > > > > > 
> > > > > > So I'm wondering whether just calling fh_verify() and then
> > > > > > nfsd_open_verified() would be simpler and/or good enough here. Is
> > > > > > there a strong reason to use the file cache for locally opened
> > > > > > files? Jeff, any thoughts?
> > > > > 
> > > > > > Will there be writeback ramifications for
> > > > > > doing this? Maybe we need a comment here explaining how these files
> > > > > > are garbage collected (just an fput by the local I/O client, I would
> > > > > > guess).
> > > > > 
> > > > > OK, going back to this: Since right here we immediately call 
> > > > > 
> > > > > 	nfsd_file_put(nf);
> > > > > 
> > > > > There are no writeback ramifications nor any need to comment about
> > > > > garbage collection. But this still seems like a lot of (possibly
> > > > > unnecessary) overhead for simply obtaining a struct file.
> > > > 
> > > > Easy enough change, probably best to avoid the filecache but would like
> > > > to verify with Jeff before switching:
> > > > 
> > > > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > > > index 1d6508aa931e..85ebf63789fb 100644
> > > > --- a/fs/nfsd/localio.c
> > > > +++ b/fs/nfsd/localio.c
> > > > @@ -197,7 +197,6 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_net,
> > > >         const struct cred *save_cred;
> > > >         struct svc_rqst *rqstp;
> > > >         struct svc_fh fh;
> > > > -       struct nfsd_file *nf;
> > > >         __be32 beres;
> > > > 
> > > >         if (nfs_fh->size > NFS4_FHSIZE)
> > > > @@ -235,13 +234,12 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_net,
> > > >         if (fmode & FMODE_WRITE)
> > > >                 mayflags |= NFSD_MAY_WRITE;
> > > > 
> > > > -       beres = nfsd_file_acquire(rqstp, &fh, mayflags, &nf);
> > > > +       beres = fh_verify(rqstp, &fh, S_IFREG, mayflags);
> > > >         if (beres) {
> > > >                 status = nfs_stat_to_errno(be32_to_cpu(beres));
> > > >                 goto out_fh_put;
> > > >         }
> > > > -       *pfilp = get_file(nf->nf_file);
> > > > -       nfsd_file_put(nf);
> > > > +       status = nfsd_open_verified(rqstp, &fh, mayflags, pfilp);
> > > >  out_fh_put:
> > > >         fh_put(&fh);
> > > >         nfsd_local_fakerqst_destroy(rqstp);
> > > > 
> > > 
> > > My suggestion would be to _not_ do this. I think you do want to use the
> > > filecache (mostly for performance reasons).
> > 
> > But look carefully:
> > 
> >  -- we're not calling nfsd_file_acquire_gc() here
> > 
> >  -- we're immediately calling nfsd_file_put() on the returned nf
> > 
> > There's nothing left in the file cache when nfsd_open_local_fh()
> > returns. Each call here will do a full file open and a full close.
> 
> Good point. This should be calling nfsd_file_acquire_gc(), IMO. 

So that goes to my point yesterday about writeback ramifications.

If these open files linger in the file cache, then when will they
get written back to storage and by whom? Is it going to be an nfsd
thread writing them back as part of garbage collection?

So, you're saying that the local I/O client will always behave like
NFSv3 in this regard, and open/read/close, open/write/close instead
of hanging on to the open file? That seems... suboptimal... and not
expected for a local file. That needs to be documented in the
LOCALIO design doc.

I'm also concerned about local applications closing a file but
having an open file handle linger in the file cache -- that can
prevent other accesses to the file until the GC ejects that open
file, as we've seen in the field.

IMHO nfsd_file_acquire_gc() is going to have some unwanted side
effects.

-- 
Chuck Lever

