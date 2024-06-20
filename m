Return-Path: <linux-nfs+bounces-4145-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88577910734
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 16:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D98CDB26206
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 14:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F84130358;
	Thu, 20 Jun 2024 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J5ubpi8K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EkG5YFXB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E271AD491
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891939; cv=fail; b=fpKmBZkGH7R6KyWNd0XPt4WcQ5oJv0f6vFGk4Qxb9lzoajmauMdi9dP7bQBmgM8f0UGuN2gUEhs3fZh+rfR4vO6U3n7MqUsAZ0iSeaQjDE1pyJvSu+qIPnsaqn5IfSsfhO1WO33RWbdY1b8Lwo6jz7nKdpmgkte0IaRzqBD8xFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891939; c=relaxed/simple;
	bh=UgHrOk2rLO0Wo/i67e4e9+s1L6q+aOyoE0Yj4lLtKgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zc5J59xgJfhZv7RIhi835pgmb6JSxyepQHI9wzHA/f0DnshLb+laSqiE0vlVgvc/Q9cB1uNRiZPZQ1wQuPZJTAhyeu5Ro4IhoHQjY+kEAFKJVIsNsiDhLmgv2CTmKgTIdnQPVTGZPsxqjdbhfFBY7TJWEKGO89LEs4bShtqn2VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J5ubpi8K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EkG5YFXB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K5FJQp002237;
	Thu, 20 Jun 2024 13:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=KySwMKq2MnMGwHY
	lZ4w5vRVs3n5Ne9hZiv/RF+LF4ck=; b=J5ubpi8KXiVYn7PNwkVaHQfvO10UtCW
	OdG0ZBiAgLykZVWwh4vMd2h3SXWo23zHdQqaDv/DKlUKOHHGwVWaPfucH34MP5Xu
	Sfo9shOQw2HFVqN5qNlmEWss58mTYPxrqm5BzUwwEhfsJ90KhXC9m0zYgCQSqMCy
	uEX6dafNm7d+bJefF0YU/PGi8NGqtPQ7MypBWt8lg7c3TQnAoAUwlLrV13Q0IJjv
	fZixJtq83UTvml0dBREDqbb2UCy9Ovy2EccM9sEchWPo5R6rnwS5Ha+a3T/EMrX9
	YRGkiqpNzrpJAY8w7G91ml2F4C9SajXwVRWec01mTZ3a+iTyAX/vtCA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuja0k9n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 13:58:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KD5FeE034800;
	Thu, 20 Jun 2024 13:58:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1darr57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 13:58:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpPGdp721E1+yuHzBaCFQO99LWnQlhO6oR4rMRoob/ztjtFPNCLgFaNmeph7RS/5UwsGEehaG/MG36v474V8RB9BNI/TGlZ3mz3pbXBxaWXR6RNfWV13dXeBsYotcZAPr7MSV90h91lmgL0dKvILtWPg7oSVBiGjsf5rNhCgbcpGV5GTwvE/h3MCOtzsiUGC2cpJsK+K6shKhkELDI5ARDXEfe3sc+Y4Q6u8tcsiBO9REzX0+k0Yz+K23/OvZTAYC2DLboD2hJxa92L9ud/yv/phj9wFcF9/XHnkSX2Ma0vNeKKn6sBEzos/Z7lnMeJFJz3bCui5Mk3bgufXi2GEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KySwMKq2MnMGwHYlZ4w5vRVs3n5Ne9hZiv/RF+LF4ck=;
 b=hBEE+oPu7gx2QdujvsJFZTTsF3m6j2spYrXIEhoIg/lgOiLSIkc53vyatIhLt9RBl+gtR1ReQcAhKrNYDpR330tYo5E3RfTM76R/ewFVGW5gyr7i+zrr7MKSrOCHGbX0AB2h9p01GFY4/vukG2J/IybyPY32cLUOAaqddYq00y0lhcl4UbrzOAECqpAqkzLJUQbgKLqF7bZL4GWJrzIfFhewczJFaykQhvq9Q7yAHooFhvFJdYgJmw4RxnT3QV4ho2XjKVcF47DQGNcAcgjOpkvIsMEXkm+1KIyyA0kTTGi9M/0NYWt4VW8U8M+3D4xsqWgL8sofZ7JKuTshYBivxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KySwMKq2MnMGwHYlZ4w5vRVs3n5Ne9hZiv/RF+LF4ck=;
 b=EkG5YFXBVUgtVFTCc81kr9wpB4GD4XUM1nIJf3L8+Duc6k65ugU4tGY7T5ny0Rs2stIe6cy6QVCo1R9G+mIW3DI8tkpUuCpjsoeFH/dfdwzZqdWZKwKotS0lDuNFgtHy6ZwLvAMSSlu69jUcdiw9WF40yySjClwuC7D9YGFpzDE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6482.namprd10.prod.outlook.com (2603:10b6:510:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 13:58:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 13:58:46 +0000
Date: Thu, 20 Jun 2024 09:58:42 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, cel@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] nfs/blocklayout: Fix premature PR key
 unregistration
Message-ID: <ZnQ1khOCStHMqS2U@tissot.1015granger.net>
References: <20240619173929.177818-6-cel@kernel.org>
 <20240619173929.177818-9-cel@kernel.org>
 <20240620050614.GE19613@lst.de>
 <3859730C-40EC-4818-9058-D74E4153623B@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3859730C-40EC-4818-9058-D74E4153623B@redhat.com>
X-ClientProxiedBy: CH0PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:610:33::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: f25644b4-2cb3-41f2-018f-08dc91311a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?FMKT5q9BzmxnJeMXCeXMbsTw6BYLzPWhWncY4VJTComynCkjeZLZyKL1VEAx?=
 =?us-ascii?Q?/ko9k/WJPBxk9vqbl7rFGN5XphuWLUQlqinmESSPSXiR7XxFxbQrCn1nKDnT?=
 =?us-ascii?Q?EOb9B7qlPq3nT4K3a32lZFgKm83tEtZ3QLVz6yNbeQ1MPO1YqYDgHkbf87cf?=
 =?us-ascii?Q?F+QsNy74H19+oJDMDVDJ2gOFvN4NwRi+ZgYXQdOxVwKw2Xac9NlCzzKLgwEO?=
 =?us-ascii?Q?kg4dma68HqD6yscTyEm/nlr6Wui+SLzVQyknw4eo+K4tJUYSqUGC/aHNtfnJ?=
 =?us-ascii?Q?qsbIBs1IR3EcEpTJrxuSwyT4kuaeXS8Nm1SHo//dpN/cCm0FWUl3/Hiup0vk?=
 =?us-ascii?Q?h3jS390ngsWb/ss9+pzNGXRDlX/iKMBUkv0w3Pl3NP+YJcY049n6HTEOR+wv?=
 =?us-ascii?Q?h6mSHOinBInBJh4GnARplfyZqN/pDRfg5mHD/T80tMqpVW7apMeSh4kAXdOQ?=
 =?us-ascii?Q?7UlTLYqb1iov4gQps5Vz/NobaaV0/qS62NfncSiu2rkiDwtNaU6v3+D/lhOS?=
 =?us-ascii?Q?7dW58gFGzqoB17FAbFoCRubE0wM9Zfp/9GsDmz9bOdmgEQBaE0qRNJF6kvFg?=
 =?us-ascii?Q?+BY60ZBULVeHLtV9n1NrYq4YhjlvCnHmsFnI4v4AtAWKR8Uq/eHZwOPDsp1p?=
 =?us-ascii?Q?aDV3HzAGlSmXo+MBO8okDFq2bOthFaDxh0B9viWoTbYRbM3hwbaEXihI8Nul?=
 =?us-ascii?Q?D/bwGKZRAw/wbVVVAAaXAm4Kd3OSEoRxGirQifL0I6iMDXFM1zCTnyMLgl8X?=
 =?us-ascii?Q?XL2bVIoqMI4HXPE3qsEfRp4uo0r7YbN9LGKsiHj3YU3hQijihqOY7EbedpZV?=
 =?us-ascii?Q?Pm8BD6P+Ucjd5lPNLw8WeB/Dn1mcCSOnG9+UjXOtVga9E2BQnexORrad8fXB?=
 =?us-ascii?Q?OolXMQ/LTuMWMSyYxqTQOPBIEfgdXgw3M6demlNWq2y9QKBLIXlXirCLwqrp?=
 =?us-ascii?Q?KLo3v1AuVdocsV3NSSPHhlYpgQYFHEr8O3QTB9vAQynD1ATEjkLDLZk0mdKA?=
 =?us-ascii?Q?fRewcL9VP6P/GZ1PzzzwLwfLEW/K9oxNuWNX5ZodqLs1Qoz2CF4nBlhNE7eH?=
 =?us-ascii?Q?a5U6Un1H8hMBLn6E4ifWFr3a+UISQpsldHsIaMBsAIB2sQ6v3aCQUP3OTSTm?=
 =?us-ascii?Q?8ysUvyJau8NMyHW1ESo+8Mi1m3omtpHRY0ZAXnRblVRpF6jPrghfiRUSgtOR?=
 =?us-ascii?Q?n5u4bwMarUG1S/3HrNWRa2uTW2aL75PfbvbinYWJzCN1+hMAqwgTeymkthuJ?=
 =?us-ascii?Q?QIzeEBG77PiEvKks6+t+Su8JqdWaLMkWD+WKr8e448yVmrQCL2GwYBSqIqxq?=
 =?us-ascii?Q?om0udAfF3HYrpDHlvXW1z5DC?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?I8i0GTvcRSvcrQqhujdzmSxZa1Q8RLrDxb5RajM6Xe5lcFWu4d1HvlU/knBw?=
 =?us-ascii?Q?Er8PTqmabUGSNFsZU8Qf1QLMe8x8yLvnWcfPVjHiwxwDv2uE8riRMnHH1239?=
 =?us-ascii?Q?OjD+CSPEToHk4z7hcg0AUvWmsaFXzgxl3Vn9q8Uq0h3kIWTqMYnpj6wak3yh?=
 =?us-ascii?Q?yTpDHGOWrkQyA5u1CK5Hl3f813QbPkDuB0v6HcC2drhBSkaavaNZ1SNwd5ML?=
 =?us-ascii?Q?vGUqzPyVymCn03szf+CDASkA172cCyI+pXiludS30aMstqaWFy6jUI1889R1?=
 =?us-ascii?Q?SvvAQg/ujHPjteVu9Sd1XxxaDlbKYvv9vxd08NwudBBj8VVpNt8pN9XokTG2?=
 =?us-ascii?Q?qtlKfp0oh/BuM3e0aZGeU+LWqmZU7L/csEt3s7TNYmiS9L5PTi75/LHDZ6Ya?=
 =?us-ascii?Q?VeVd34CZadwDSbfPTZp2JXCoYo//dddibfGakxni9BslVPymMNVjlAQc9YLe?=
 =?us-ascii?Q?WpC7REwhMgR2NHdVsyCFE4O5MQwXfOZggQX5BMZsDLspG0lz8OnU4Tfj5Y/+?=
 =?us-ascii?Q?FEjwhM0naXFMjjJaQmsabIK9mHXYa6P7qwqhfvwTP5wlqbK4gjv0dcsuZDEp?=
 =?us-ascii?Q?7HzAMCMbjpVd8I0lHJD1XXAuKX/w79luigOG8+n9CDaq8J5XG3MJARjLXwQT?=
 =?us-ascii?Q?EX0p1kPkyq7lsDqnEblWpY5B83v2COP5fLQJgIvMYqTh02VN3jNvLdVa5+mY?=
 =?us-ascii?Q?HThKiyQNd0gAsKFnMAw2p5mnVQcxlkr+vx8Qf4ZeXTE/yppap4Bf8F2RSzaG?=
 =?us-ascii?Q?s9Bk0AtyJ7iRS2Tx2nyhFnGD3drh2tS6mbL58xR44SI67sTaBJErSX0X5Xje?=
 =?us-ascii?Q?vcpB3lD0XizJWUeBmj59GUN9JBmtAbIvHJIaKIpMr2UvZ8ERHu454Hw4Wz0S?=
 =?us-ascii?Q?k2thhEQfQUs+U2y4lmnYjxea0WfgreDEJtJ3d31+bcoBH+I9LUkDddcLFmyV?=
 =?us-ascii?Q?hcqS8y0Izhwk4eQbJybQVQbO68HC2Do75nr1ToY53ypWSBZSgcNIiIX41c77?=
 =?us-ascii?Q?zu/TPh8sSwfmLW1UDApXKjIsFlcOlnEsAofAzZ1wbD/3RU5M2XFonWxij3AR?=
 =?us-ascii?Q?P3tw57NHX03OdI9Y4bAvtqcV6o6TGYeRlFYQdxF4rgGP8vPQ2jqQ8XvElgsw?=
 =?us-ascii?Q?CnufNW/Oozj8nauuPkurUwVG7GZy89wjebOR4BtlR3vqj+tyKSFF7CMnZjvn?=
 =?us-ascii?Q?KWvMgoJGV9unBE4fpFewWnCCycdWDJcFVVc9WKTwTgRxeROPP02wQVbeTaEM?=
 =?us-ascii?Q?mMl5XGZlKLtR9DXuI4/6KEce5EK03V4pDfF0zefo8z/mVanyS82WGexkRvm2?=
 =?us-ascii?Q?568WKBspy2/5wXhjA88ULk11Mff2uVzHZ7A5sE3suAAhuvjLV+cEcPZnR4AG?=
 =?us-ascii?Q?aShU6H1Fu53hWL7AI7LmVMqmbOXHzq8LwDglXMrA049AllFehfzx/6DtxaSO?=
 =?us-ascii?Q?BInotD8R+3C2AEZMsFylj0KPCkg1EzIpq4z9EvFJrcvPCL42vQoSH2x1WUm9?=
 =?us-ascii?Q?BlJC5KKF8S0xkmFWCwgRujxxOzI5E9huAPkFVM2qCYtxAIeDPmtwe/ZkBNxr?=
 =?us-ascii?Q?v6A4yhy2nzYGRe62hO1Nl+fOud7v7VKk6QkB4D2+B2UfLsIJAV4Mz72+JPPW?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pP66VOgCa9c0eVGZNRM8mNu10x/Cqopbc4MfLTqtzgWX1ye4kvEABtnR5mGuAMdO3j3pEieb5626Q9ae6FIpxS7/JtXQ+B7bC4MWr27ziT0t5kqMzN5v7cJG8QyDjg0fWn+Je1TSBss95f7BHihEtKq4fl7WIuJgp3+bzOUwvQvw3wnm2dNhAT7feAXBZjke+8/5SRs2BXRw54/TrcyzyHSaf0t7RmFjCt8qY13B63L1mxg4yO7Zqg2FFEp2R0DpImZ/IMSm+dtnp1Q6yiIZE+tVo485TV96Jn4zeNDF0rsgHluO09DWv2GuY2t/5VTdgDpeNlbyRnvkiFHaZuH+roOeT/v55va1vkTiluFVpS3Jud7ok6bqY/ZeluHW8x9AeAVelXFCdzMZIfPQIrhLkXuLajF9k4twSbUmL4CUfgGx4qQJThjZEEKD68btHgRz6iQ14dp1ON/NAJZphL6SX8Jdyx4uKBsYTTueoS2mJU9Ec6rfYvvXAArqBn5KRxjzLllVc4oN+HQENnL+c1nm2tTxJ1JtTuIhMbqwlwO1Hd5FPSacz/CTQKgyQHHKViisQzwOj8GhEG3ni4YvZnY86yzlLOSdWmA6s7lgCyEE0ps=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25644b4-2cb3-41f2-018f-08dc91311a46
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 13:58:46.1067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1z6Nqq/kGVgluG+dAm+MtfxVic6sa1TrPcAGuAqRIVrVC+O8w7ZIZLkEpRRdzdVQ5AOffueigyz8qfcBkG+hnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6482
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=901 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406200100
X-Proofpoint-ORIG-GUID: WK4WXxY8edxcf26Ftb3Oaw1kWUP_CPbu
X-Proofpoint-GUID: WK4WXxY8edxcf26Ftb3Oaw1kWUP_CPbu

On Thu, Jun 20, 2024 at 09:52:59AM -0400, Benjamin Coddington wrote:
> On 20 Jun 2024, at 1:06, Christoph Hellwig wrote:
> 
> > On Wed, Jun 19, 2024 at 01:39:33PM -0400, cel@kernel.org wrote:
> >> -	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0)
> >> +	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0) {
> >
> > It might be worth to invert this and keep the unavailable handling in
> > the branch as that's the exceptional case.   That code is also woefully
> > under-documented and could have really used a comment.
> 
> The transient device handling in general, or just this bit of it?

I read Christoph's comment as referring specifically to the logic
in bl_find_get_deviceid(). 


> >> +		struct pnfs_block_dev *d =
> >> +			container_of(node, struct pnfs_block_dev, node);
> >> +		if (d->pr_reg)
> >> +			if (d->pr_reg(d) < 0)
> >> +				goto out_put;
> >
> > Empty line after variable declarations.  Also is there anything that
> > synchronizes the lookups here so that we don't do multiple registrations
> > in parallel?
> 
> I don't think there is.  Do we get an error if we register twice?

pr_register() does not throw an error in that case, so I didn't
protect against it. However, I could add atomic bit flags to
pnfs_block_dev to ensure registration is done only once, if we
believe that is necessary.


> Ben
> 
> >> +
> >> +	if (d->pr_registered)
> >> +		return 0;
> >> +
> >> +	error = ops->pr_register(bdev, 0, d->pr_key, true);
> >> +	if (error) {
> >> +		trace_bl_pr_key_reg_err(bdev->bd_disk->disk_name, d->pr_key, error);
> >> +		return -error;
> >
> > ->pr_register returns either negative errnos or positive PR_STS_* values,
> > simply inverting the error here isn't doing the right thing.
> 

-- 
Chuck Lever

