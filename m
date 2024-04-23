Return-Path: <linux-nfs+bounces-2959-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFDF8AEAF8
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 17:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE761F2200E
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 15:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F95D13BADD;
	Tue, 23 Apr 2024 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fsu4YJZA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vSgxoh4j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F74D7F499
	for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885987; cv=fail; b=YEjm4baAY0yhY7VHhf4DfFShoD9VI6fT3rPvk7DSjwQc6wE/tBHqL2FwJ2kAiDyxEuYSLkzqwQLSpaQtvTfhPbjKl1kD6n089ai9HgTf0wp5kikws3N3/LxOblpoYM600uRsL645c51xIQ+lnEc6w0lCpGTgmMK6Yqw6ItW7BBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885987; c=relaxed/simple;
	bh=R6EcIcMsHFekdi0qTjbMUDtzOTna75Psxk03OkuRtlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EMX/IqwucFsxySG9BrX1mD42Lfcd2f5Lh0SHctNawic2dsl1jb4aqYl05BliWV9g6lyL6cVLLOn4Z3ZVIHXGzu3hoHX6fffQ/2hlYYyDGyPVFMRofNcUpVC2Gwsuojp6ZfOZ+0JKGz2sDi7GQGIEnMv7CfUJ9hN+I5VBW9OYQME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fsu4YJZA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vSgxoh4j; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NFDDSL020242;
	Tue, 23 Apr 2024 15:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=ZejGwMFcnqhohS0dcAmVqwvVDrHimRkEhYhL1Wh9EhE=;
 b=Fsu4YJZAH4NS3lAdBC2tTWsVbCqBoHbMHXYe/xmS8AQKtCu0ftZz1Ly4GSw9Zh0ijfXw
 bIzAr62Fx18GrTnCAYz5EAsnGsCxs6qY964jkP/1YYuusXPUFLZiQtElCfqm9TtCM6S2
 YxkPDMg2OzcZM1SMNfE4HzH1WdYjI/Gt0/pb6YI6oaFLJ8TayN21YzOdwyj//UFok/6Y
 1+1EXKpLPc5F8tH3dZElNZoy2A2wpZ743Pe/AG7Uk/nQV0Z54pXQYS1c62IGinzesm8E
 mWEnvOJ6sYp/VZPq3TDQ8bO5NbfFeBBrdZUFSfoRS/niu0WanWh8yMmapHEJQcgwK46d AQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5aunks6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 15:26:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NEohVc001710;
	Tue, 23 Apr 2024 15:26:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm457w32v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 15:26:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Op/WolsFG8+t9slhvhYGdVuSdgePgDwKVlsmC2YL5nWMbd9I8NlR1mz4Y0l9fZxtskYgFoXK0pe0F0bDpjeGYAToL/bsmOVLTfcbT3RKmPFtyV8Ga0slY9HVGR0PjgywOHaXs5IbJO/TJfcf5Ta7JQFplwrczyzIkjtqMAtrhNG6c7quYfKD9YbQDY8bytoYHLkDxnrhRqeKjsaI64DhA3LHa8oV4l6oQgW7+NZ3PF7pjYS23DWuTg/WpAOKZ09mzdvsr0oGkF5QFMH91pDYSSlJLl5Lynq4DhFSwUwHt14fS70tZtA6HTpqdbhd6q1Mi6iCwXzGrmznNQ+2Zwrkzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZejGwMFcnqhohS0dcAmVqwvVDrHimRkEhYhL1Wh9EhE=;
 b=fx4VEjOSCz4DWDzhSWY6Y4Nivb8ChNnc4mEJBCMv24SF0hZ9TBcJDWtLcdIRn5Ew+TL7kEP7pPMamVlx/V1o4a7IbgGnHRNwqt1FnBzUwc7Bf8Efbzr5kaVudCFfpHEKwHEHDEOFFTfKvyDr81aszjwo3ZC0UVOsmshBUJAAuTxY0HPO1M47/G6ePKsgTsOs93UjkgUcsKl43noHUYm+hcTzwBMxSWQ42Vp9ABqEQAwUnvBVpmGidSy7gf0qJtC50OrfAM6cJ3dqq7siaFQfJhwm3gBUnG9R12CZ/QzFEfMNB1UdMPN6DzFJo1b5cw7eN/SRxXlGlZOIbogQT/XM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZejGwMFcnqhohS0dcAmVqwvVDrHimRkEhYhL1Wh9EhE=;
 b=vSgxoh4jdw5AcQjOCtz+edsdCLf+PV6G/fCuo1WD5x0dNWLQtHQFPnGskCiGlV9hgbGTwKWT+Uk8hQWba59E5tkwSNBiGUUBrCQkiDe3Ruu1MWopOKiBj4yPUqj6PouTUikbkn9awzjg5ei+Zn0MNZlsAh/wI97TBVRnCu42MAg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4714.namprd10.prod.outlook.com (2603:10b6:806:111::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 15:26:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 15:26:08 +0000
Date: Tue, 23 Apr 2024 11:26:05 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: don't fail OP_SETCLIENTID when there are lots of
 clients.
Message-ID: <ZifTDWb7MDAJy6hC@tissot.1015granger.net>
References: <171375175915.7600.6526208866216039031@noble.neil.brown.name>
 <ZiZnbV+htcvGuGQl@tissot.1015granger.net>
 <20240423151256.GA203608@pevik>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423151256.GA203608@pevik>
X-ClientProxiedBy: CH2PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:610:4c::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4714:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d71dc8-86d7-4ce5-2a43-08dc63a9b2f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Kh1Yx3+icQau2MqZdyFv49zYeSki79IZCGnj51Qt5U9MhIx+ezXipHyzDS0o?=
 =?us-ascii?Q?tQ8ZKU6Mu0vuci/mku9GlExOhd7IwzRFt6uBJgqc3kVuIPzAEIbMdX/D9YPI?=
 =?us-ascii?Q?Ws8xe2NUl2tv54SpPAAHKTaiTPvjH9wFbe868Da0KU3h4kIrfp3B9y97MeSf?=
 =?us-ascii?Q?2b3zYFT87uoFUUVwQxK6AdQIC8mPbj0ZjCTfqu0LHjN9oUGQ9u0bPKDKQ489?=
 =?us-ascii?Q?2r9LhEOsOMIYMCYsvH0tTZbQsclCCJLnBAE7cJ2WiIcErEMyqMeIk4ptvkkG?=
 =?us-ascii?Q?CyjQar26eGgGZJ1Xv1KbYYm7umVpvAVxNXFCvynm/Yiiw90doIxb1MDDlmvI?=
 =?us-ascii?Q?/OyBVbI5RwXzdFzomaDFpywe5g/ArUiEX7Ot/NFodehlCT0UYxFVQKdUzG5N?=
 =?us-ascii?Q?YWrgLSkNG39Lr9Bg3ZI56yxYwQKqvCwfclrO7TZM5LMEVyiRHM7o+mslfog2?=
 =?us-ascii?Q?DEaDCD0AfYpYzZorAX/y4aZck/CE+QoDRDZdcdCcoIdjJn95WThK4bunwAWT?=
 =?us-ascii?Q?thTmgmMDDA+mbK4hckcYVVF9AXgXi1GXQHCrORFQ65ojpXyJnEEhQ4fTjVvt?=
 =?us-ascii?Q?clUVWLgF5M1N0olidxDHpCFUNY3hdtF1svtT705hzN+KT0zU01/tPKa2aAgC?=
 =?us-ascii?Q?m6btya/suF4UBp3dILZXqT3L7ZQwNDcDuLKGIcEKKGt0DUSVb2EIPwN/Esmk?=
 =?us-ascii?Q?mKDKkCztgkkFhnZxFATpxVZjGUUwV3Hct1a4eKTNxHYorOVXSQlK7ydLcR9G?=
 =?us-ascii?Q?Sfgw643vwL5C2dKAnVsJPxAsKMyhvYrJ4ULa1ig6VrCeB3RWFy1m9hJO9CRH?=
 =?us-ascii?Q?kHfqaB5I5JdJelagzI5+WoYF5jkcv0Y06pwUWyUONvyPdHXkkSdakgdGZ7fP?=
 =?us-ascii?Q?ifepGvPsbtfUNzyIonGGPq3JAt9pfwolXWUjrISmz7jcyUjvlrD/bQLL9iBn?=
 =?us-ascii?Q?0ykgxN/bTZaPuFz/iVlJvxV4/jl5xZ1IFxM4bELcaoyce+YHdSkFEYqR97rh?=
 =?us-ascii?Q?EWMjBeuGdh5QF+6gd1OhryVr2MWTnTeIHt7IBRclFNTHcu4cUQqz9QE/D/pZ?=
 =?us-ascii?Q?2cPZr7qes62LpofHfyyeX0FcCJuHLjUqDj9N34wqtJB1GZ46j10lFuaJDkYK?=
 =?us-ascii?Q?RGckPM9iWQAjdvGoG8BDwk93zoWgj49f9uVAHIk/i3yYWkLRI8oVbHeawY2A?=
 =?us-ascii?Q?Vm+yMOjz+blVb1l7Omae44LG6fSOhD2NY6Q8K15kh2695YlwyIP9LotcuNoQ?=
 =?us-ascii?Q?SCrpmOGFmQKWMODrVt5Jgi2wL8jbUHZN+lPr5ydqgA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iMeHFYo9G9Y+QKw+G4PwKXVJM11aW9mk0s9wzLDLiHu84yy7RqCIpS0eVo7K?=
 =?us-ascii?Q?Zf10Jb/M0tgirm7prGb789KzPDTk+TAdqGmmqvFOoQ1I+xD9bQRRxCJk64vh?=
 =?us-ascii?Q?b6ai4t2xbABgFzPT5Bz2wO739uwYEUEJADusFnRUrm4RnFmcSSg6G2H434k3?=
 =?us-ascii?Q?rlTz6xefg/kJ1kGL2nc8ciJ8ktXWr4hBW4GG/Iiflr6lClNhX7ympD/y32OH?=
 =?us-ascii?Q?06E73YjEFW+rJEc1WfL8pAtdzm+F1TBR0GO67Q/iCYbWOGMDCNablmovs8JZ?=
 =?us-ascii?Q?imbDqmqH7MdRJ974SlnQk/GCN1qiCWSuDLY5B92qG/wrti1C3y8rw88zRenc?=
 =?us-ascii?Q?oadmKcTUh64dp+W8DZQIvx7btMVJjrj7aCMQbzbaeO4k+5jyH2FMo+ohZKEu?=
 =?us-ascii?Q?j0ser3f5drmYhVbC5GRWGucdAjLxtk+7DEWEy5R9GtM4Glvl7pi0NJk0mnZt?=
 =?us-ascii?Q?pY+lEPokcxHb2vxvwWzkRokFYuxcv4k8ICGAuYGozQK4lkznkakB7qpQKuco?=
 =?us-ascii?Q?EgXlLA28mgsw6wnEySdGUoIWtkQ1jef3+vjOEGJ7ywP6u9erD9HGwDonldAs?=
 =?us-ascii?Q?7VKbpbKWWe/qvfjGV027ehDjujsLGg7yiZE/6kfIiyuTN4DZJ18N7pj689cO?=
 =?us-ascii?Q?4QyAnzw9/LzMqKQaEMs9UE3DEJrZH1Rng8d7WtveCOC0FRX/g+VmISwYxHxW?=
 =?us-ascii?Q?yfjyeq7Z8q/E47GCIkV75nkaypxWtecGimkbAV3ZDRAlrQevODAnYOMCqtQL?=
 =?us-ascii?Q?+78pAta281cm/+nSECjbRoF/xuShpgSXHs0hG85tMLtdoyPWIIdlimn/IJU1?=
 =?us-ascii?Q?nlXyfmI3twj+lC4R+prRDHrDk5/Bid4JUpmudV+5tRTa/EGFqfLsQj0zntlk?=
 =?us-ascii?Q?7YHzhvz8XH6isQqr5vB9cLgEngoC0HIRkPiTYM9cbSD5wqACajykB+59xzHP?=
 =?us-ascii?Q?YsKmfCT20Qg+21sYnoQYAuSset/72I6mwS5j3MbkyO663QYzgu+fMnjdg9RL?=
 =?us-ascii?Q?231noYLzHb/Y00LIBf+x68RDl+3szGZIJEKjwSZz1u3wJulQouwV0pPgzXC+?=
 =?us-ascii?Q?BA7HsM+T/nTip4rM79ewFMtE5/8FnNcZuCVsdGSDP1xYpKKt6ifB8C7rwoF6?=
 =?us-ascii?Q?4XB6IT79aXl5vveEVTmwAzOlnBN4jgpJqHQ+uQuOMHxJDZa6/w36ZOaQnMLt?=
 =?us-ascii?Q?XbywRg0oLqhsyujhfJydcYKktXYkMAkCb/sHl7Zv0aoqKSkk6qRlTw06ffFP?=
 =?us-ascii?Q?iO+Xq4FVXCiEpzwILLUw27NOusa5mDUMezxpKesDTgctb3pCBvr1os9jE2Xw?=
 =?us-ascii?Q?gKBU8X9D/BvKmNSldXRHY7q7IbWFdMy0YB0IOZuQ437ltSTNUe6v2xnq1LrQ?=
 =?us-ascii?Q?FYJZQhenwmvPsbh0JxHOJ67py603Tvsar81plqIRzJvZmrTUVAZcqMWQa4DZ?=
 =?us-ascii?Q?HyQP8L0+EwStcfOz1OsG57vxoMzSfuPzdHHUOd2m7EgOu0+2tLGZ1u/A/EcH?=
 =?us-ascii?Q?YPTtxcWNUJc5UjvBlENnmhZNn0GlhD9z+6+jlA1+zqYT17jqhr7CvGiSJtye?=
 =?us-ascii?Q?vGQ4g1jeNGzLDum8XmGSfkLP6JCguHH0v1X6s+lvPkDrjtGMWUlHFYcB5ZLB?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	K7FISfW4oTHXnoQo28oBfZ2eY9oWfgqtCwggg0rjzQOezjI6ngjEePiexBYv66pdw2fhAqIArL3q01UBnlbr0ODivSpMv7/wkOMscytIEQWlKHVsZuSVmIkNcLltkbgxoMMZs5v5Ubu+u5ssfgRXZee55d/J7s8Hx6VQlPwvEMUbeSMMitqTrXnF+Ek4OE/hZ2o0sT7wI1ecOHFUxJpwWyeP7alGOUj/a24pwELBuMaNS7/BT/Qb4pdTtuhDQEpQF4cSBE3Yzv2tTedvOe2nL3yie6Mq+N0E3tSmUrVRFr8TTFI6y1yznCbrtL3x+o+SlS1s1LRPl/pM0t0Mnk/qfYpkjKUXXklPvyPcKoGgUXMwiTNjezJR2ju+QCMuoPxUlvaPg9l+UF+Z1nxOxpzOE8g+cu6+82cNjul2D+G80efgUY5a62pco5DQcI/AXmVxUxmLReBvfimOvCwnGevbBLfypInjjNytebFiqMcBjdBcpgqaDrFjr6wPR8XPNC3c/1qmdYLqT1ejwgdmYWlbymQNcicr80owJsS3SobwLreQlGWw20K8yB6yF/CEQRGBsetxluwa7/yIp0gp18KunQs6W3c2g7AtU2mG5gOHk/Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d71dc8-86d7-4ce5-2a43-08dc63a9b2f1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 15:26:08.3847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijA+gdLLkb59FrmVEfFkrBNqKNfK5ILwkLPfAjc+zDCriGDF20XtshowD+6qH175n+BsE3//ODSNQrbwaQpNFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=910 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404230036
X-Proofpoint-ORIG-GUID: NQmizDrHxGVNMGEtCHrJrG9QpnTC5TTN
X-Proofpoint-GUID: NQmizDrHxGVNMGEtCHrJrG9QpnTC5TTN

On Tue, Apr 23, 2024 at 05:12:56PM +0200, Petr Vorel wrote:
> > On Mon, Apr 22, 2024 at 12:09:19PM +1000, NeilBrown wrote:
> > > The calculation of how many clients the nfs server can manage is only an
> > > heuristic.  Triggering the laundromat to clean up old clients when we
> > > have more than the heuristic limit is valid, but refusing to create new
> > > clients is not.  Client creation should only fail if there really isn't
> > > enough memory available.
> 
> > > This is not known to have caused a problem is production use, but
> > > testing of lots of clients reports an error and it is not clear that
> > > this error is justified.
> 
> > It is justified, see 4271c2c08875 ("NFSD: limit the number of v4
> > clients to 1024 per 1GB of system memory"). In cases like these,
> > the recourse is to add more memory to the test system.
> 
> FYI the system is using 1468 MB + 2048 MB swap
> 
> $ free -m
>                total        used        free      shared  buff/cache   available
> Mem:            1468         347         589           4         686        1121
> Swap:           2048           0        2048
> 
> Indeed increasing the memory to 3430 MB makes test happy. It's of course up to
> you to see whether this is just unrealistic / artificial problem which does not
> influence users and thus is v2 Neil sent is not worth of merging.

IMO, if you want to handle a large client cohort, NFSD will need to
have adequate memory available. In production scenarios, I think it
is not realistic to expect a 1.5GB server to handle more than a few
dozen NFSv4 clients, given the amount of lease, session, and
open/lock state that can be in flight.

However, in testing scenarios, it's reasonable and even necessary to
experiment with low-memory servers.

I don't disagree that failing the mount attempt outright is a good
thing to do. But to make that fly, we need to figure out how to make
NFSv4.1+ behave that way too.

-- 
Chuck Lever

