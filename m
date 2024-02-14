Return-Path: <linux-nfs+bounces-1923-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA448551CD
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Feb 2024 19:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125211F28530
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Feb 2024 18:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1755912C545;
	Wed, 14 Feb 2024 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gQYeG2qy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VXsoe7hJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD6612C533
	for <linux-nfs@vger.kernel.org>; Wed, 14 Feb 2024 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934261; cv=fail; b=L8i+ktgco4FHG8iQBrYUQeDjXOl3HN/ZZCKrNTM5edKiZMpS3mVCeMbR9R+XpQvO9vKY+KKI7flFyK6Qn1xlMWoA5W4LrOzldkAxfgxWadD6XvhgzDqAD/5Y6BrdDkmk/KU3Z+YOnSTBRoPsKQxZn/18/pcwMmNhYpdTkIGR/mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934261; c=relaxed/simple;
	bh=X1s3Bxe0SL+WjswCNy652xASyRC5k+UyVKcu6hkKlFo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rtJt4J8iIdfJVB15Fv557EmizjHk/6TIkC+i8y3n4dWb9Q5Vwkssrh1DftZh+vLdHiU+kkMR4/b69LXuBUf/g6Hu6KGSkxW5S3S1ds+lfoA4Q9Rp+KUXGfWyEPBqM6zrffvBFmcdiexINcvSdBWYjvFU4jg0HePhUo4dYbWlxPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gQYeG2qy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VXsoe7hJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EHnvRs027248;
	Wed, 14 Feb 2024 18:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=5I4O4Ab99HCvxX4dii3hncS/G539ivvANzVsO8PPoAA=;
 b=gQYeG2qycjCAfIQNuaA71DyCIADGswpDUxOPk1mH3sQzVIuD7l24AUvyOs/WylbZhRXZ
 kxmKxBfd7wr650rBuTUU2L1EAXCXuZHnwBC0bJcBZq23ioDrbjTTbTr4kWE6mSpDG0pw
 SYk4czj0fnL88CO4RHYfoLZD/EwR8k8ioKVQHWozT111qsF0L6fFY40mbA0nuhNGayVZ
 q7dd+XUMdbq+QgK/bBavQQ0UsBddpJtLLyxL5Sj1caCKpoN0xaWasj/1SubBYTLD08oI
 31VMplqC4A90LX8qnGqSRdXCswHtjjbjjl8e036X8KsVwoYib/88WUPcrvN4pMbTeThf Xw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w928s0232-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 18:10:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EGskTF015085;
	Wed, 14 Feb 2024 18:10:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9218b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 18:10:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5OXigJTYe1hb04XwPF95z8ALsqy+V4NRde17uf///LQFLzrz2LB8rAS7ptmkTaxsryi1MoqxjyWlK5Lf3RzIop0i6ItnUHhhyBYxaSTkpRv7to4H2YG6WHV/E/WxUiMnlcPTIPc1EozFxc4pLIZkZfvMLpPS+ikbySsjp+AlpkbhI9rhZN7SE79nuqRIffwElX6Q4mcTK6e7NjWyyWuQvYlnseiHx8aTrlGooPlSvTGYghWstORzI3aEOMQrn7gMqjl9Uf7WGGJUJaDJhDpfozoqFlF2NqecFi/SLka+5KM9pfaN9Kdf1Dxg3hxFD/fS1IppYF3NqQf3d53ZmU87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5I4O4Ab99HCvxX4dii3hncS/G539ivvANzVsO8PPoAA=;
 b=dpc8UNmPvjh+yMuRtLeezYSu7DwyjA6W80ZNET0Lt1Ead8hs5kb8VaMsLn92EdFpXVXe84QQTUDAW0TE2wRqLAk8xrAr05z9xQlSM5HFBnU+dOWCspenfa1ZdAe1mlX2EBSotMwGQuUt+aMSRUTXmkdQJMGOSPY2NyTVnRrvaws5HXKHBfgwnjFMVsLRD1mzkUDR0Tp1arxI4nHFedG34yp+6hOIt8v9xvm/kwAtpP7uKW9kxqs8sVgL7ZO1Cqc0HflycvV6jbXFNRreH917MXV3CsXO9GctMXXeLTV+gHTbUoZaIVwtX7MeoHbggGDj4aMGpMqsE1bLpfWpjF9RPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5I4O4Ab99HCvxX4dii3hncS/G539ivvANzVsO8PPoAA=;
 b=VXsoe7hJHnWw9F6LI3MkvdD3XAjlT83T2W5ahfXlgUpw/YZMxR8mO4fA6iBZrJn65NTpOjKhQ5GLSB2wKPTfMEY1WA2aBKvwIAqBEFzSgDuAsul9JgIUewQJPkbN2csGXZiug/uw/ymFapjQrcqrkvBUE0PcXOaogreNVk1EiJA=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH7PR10MB6403.namprd10.prod.outlook.com (2603:10b6:510:1ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 18:10:52 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d3e2:9997:f223:71fd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d3e2:9997:f223:71fd%4]) with mapi id 15.20.7292.027; Wed, 14 Feb 2024
 18:10:52 +0000
Message-ID: <7994e006-b2e7-4c9b-9644-52225e1d9594@oracle.com>
Date: Wed, 14 Feb 2024 10:10:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] NFSD: handle GETATTR conflict with write delegation
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
References: <1707846447-21042-1-git-send-email-dai.ngo@oracle.com>
 <1707846447-21042-3-git-send-email-dai.ngo@oracle.com>
 <ZczTPSSCmKSmdSnB@tissot.1015granger.net>
From: dai.ngo@oracle.com
In-Reply-To: <ZczTPSSCmKSmdSnB@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:510:5::6) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH7PR10MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ed970b-71ce-496e-592d-08dc2d8847b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oY0d5FNEV6VI1J0/0beMA7lsRtUqBSYDLnbS8F3UVtBpq1tsE6XxOZD9potrlwlrT5cjbEOKGTD1AVFV9MqlLqUMmTxswEgmqbfxWjWFWhnCVZEQFC0bUb1j67LzEqn0JG5vPkThMZbxHiNBopaF6d0TPPZqIqoOXYbJcAMz29ZiAj8DL4qPXg02bAd0FUOexVgpGF/eeEK3WpCvgUruOdRcWTrWBnJeHBUR6X7SlbjdHKEjBAzLc3OsEGKsfLvX1unA1t/zeUgDfruUA1jkb55M4GPutp4ZkFyE53ZcLbBzHWW+uu2+gI07qnqaknWvnptqYMfEThhw+ZbQHG1qEJlmsiyJ1/J+vMwrsfptKm6TPpfoEX7D4BH52jatxZF5g8STrOTm8ijujqeUxdg1PZwY8tJ9rdzV8G/CCOfLZj1XzKHhmHx+i9HA5PDHkxe+s0yXfDE5WWteRs8jVmrdv7grCE663AoA7dLFHrju8dJjBV27j4Lbui7eQke0VQtvvccKIFBjKP7G14LGqEhSdwOrwEivQmptuqqQlumjBulse/t+i/5o7amlqEW8WIGi
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66899024)(30864003)(4326008)(8936002)(31686004)(5660300002)(2906002)(66556008)(6862004)(8676002)(41300700001)(31696002)(86362001)(83380400001)(36756003)(38100700002)(478600001)(66946007)(2616005)(37006003)(9686003)(316002)(6486002)(26005)(53546011)(6512007)(6506007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QWFSWUhFNGFFL0ZOeFp0cTJhRlphN0FsY1d2N0ljRE1mZ29PZ2VhSkZEUndk?=
 =?utf-8?B?TTRsRjU5N052bXd4K1E4bFBRdHVtT3VSRndtYmt2c2Y4emx6NTJJU3pycUNE?=
 =?utf-8?B?NHk1WlAwdzltMU41OTgrK0VsaWZybmpXQjJxWTBDYWtVTXk5clhvNzRyWkZE?=
 =?utf-8?B?SVhSbS9TZ3lVOUhaTGZMTG5ibGlJMU5LbHRDOFF1cllmejNyMy9UcWJ4OXVt?=
 =?utf-8?B?VnovRGlTc3dadUhaZVlTeEpwVVZrZmRXY3I1bHBJNW9wbURpeVhEZy9tSnQy?=
 =?utf-8?B?eVZOTWliTjRYRXlRUFZvV0VWbmZXeENPeFIxL3hYdENhOHJoa2xlaXhDY3NX?=
 =?utf-8?B?VkkzL0tkNW1pQUdRQUtrT05YT3NqVXE4eC9lR2VPSXA0U0M0Z2xTOGhhS1pB?=
 =?utf-8?B?YlRhbzRKTkxIdjdkdDc4eXJrelBxdjlNV2dWMFVHanVUNlRnYzlRbEdTb3Ir?=
 =?utf-8?B?MlZaSUZXRk5tT2pzUjV1WmlpWitOdXM1cTk0dGpWUndiSDUrQ08xSnlSZTJI?=
 =?utf-8?B?S01JQVl3dms4WSs3T2JFa0Zveis5M3Q5U3BMRWQvSU9IWmVJaWs5SFZMSXhL?=
 =?utf-8?B?UGpMVlgrczlSRlZQblQ5dHgvZ3VYbDR3R2djRW14b0RyMzNDVGlwT2gvZElU?=
 =?utf-8?B?OFlTY3pVUVQzSmFSMTQyRmpnL0xtdzU5Q3QyNThwQzFPWEdjNDJ4R0FrRTJi?=
 =?utf-8?B?WXZiOGV2ZUViZU0wZGg5VzJwWFNObFJIRDlJRlIzK1psdHRKSVFKS2t2UkxU?=
 =?utf-8?B?ajZFOFRldWFyVldWZjZCVTNLNEtKMy9GTmdKaWg4YXpVRFVxTjUrcTlzL0F1?=
 =?utf-8?B?NDVOYnZ4ZGQvK3pVeG5hUTdKZGlVeERZSXdFTkVEclZMWU5hblh1dlFyOGNw?=
 =?utf-8?B?RWZ4ZUZOVkJWandIdGhOMjl3Tko1NHMyM0F4VDNlZElwTWFXR3BxOTRWYzU2?=
 =?utf-8?B?TmMrNzBUWnpEN2NxZXl5VXNaTjEwWVFRTW9oa2R6M1hQampHWmtVL21sSHQ1?=
 =?utf-8?B?ZkJjWUlEaUl0TVhpQzBxblJhTG93Q1VrM0xNbGxkYkNzVVZZUm9lQlhUYjdC?=
 =?utf-8?B?c2cyN3FQNVJZTElXNWpzYytaQUZ4dXdBWXlOZkVyczNPMzZzaWU1cUw3UXhU?=
 =?utf-8?B?c3VPT252djhiWDBVM1ViRGtVN1BlSldFdXpBUkFQbS9XUzRhOHcvY1JYQ1pq?=
 =?utf-8?B?SXl3dTFjWkd5L29RT3NqOVFXNFJ5QngyVFZra3R4T0M2TWxIMklrQVZuc0t5?=
 =?utf-8?B?c1FXVmVIdjJpZEk2eWwxRkJJbGVPRGk4SGtMbksyQWRyK1R1QXVIWmY3eFU2?=
 =?utf-8?B?aDRkRFZnTEdZUGdVTXo3SlVES1Y0eS9udTNPUEtMd3FPSkNZZGJiYUxMUkNG?=
 =?utf-8?B?UkdlKzZjQWVUZjFxb2o4b1Y1eXdaVlNmNjR0WHdBbDMzOUFtNjcrLzl3OEds?=
 =?utf-8?B?UytvYzZZSWZMQkt1dzZnWXo2VEk2bFp4VVBqeVZGR2V0b2oxTDJxWW5lSE1k?=
 =?utf-8?B?MGN1SC9UU0ZGb2hHbWNRZFRqd2p0OWtjVGpkbS9reTdvU3FNK1MyekRnUThm?=
 =?utf-8?B?OVY0UFduMFpkTXRsWG1NS1ZGRE9CcGRNVldYQ1I3MlFDbEFmSmlRQ253Vzg0?=
 =?utf-8?B?bExjSjBwcVFGS0Fic2FaNzFQMFJzRVlGdFdNdGhsbTQybkNDVXhhaFZndE4y?=
 =?utf-8?B?WTFyMWVKWk5RZmNwY28xWXlOS3l0R1dqVUtnY2h2RFBhZllJTGgwZUN2eHNN?=
 =?utf-8?B?T0hvMXlhME5yaWpMYVUrYWpLR3d1L0YxNVVEZ3h2a0draGdqc3Bxemx4dTVS?=
 =?utf-8?B?NFBNblpURSsvQUFlME44THhweVhlc2haUWRITERDMHd6bGt1cWx6ZTdhVGhj?=
 =?utf-8?B?dWZ3L2dzdXB5UGFzRDY4WFNKUVRUK3V3MWJ3UFJXRHNDMmgyQ3dJZ2tSVkU4?=
 =?utf-8?B?ZDhDaDBzNStWZ01EQVFEaFlEMTkwNzc5YklQVWlLWFBzZzEydkpiNXJTL0lx?=
 =?utf-8?B?U2pkWTQ2SjJXTko1MnM1cms5UnJmRHFuV2RhVkE3N0lsczdBWXFEaTY1MTJl?=
 =?utf-8?B?enNVc1ZGOHp6ODR0Q3YveGFWek5QdWYzZUZEWjFQZ2pGYklZU2pGMzg0VzMz?=
 =?utf-8?Q?7zBOPKjOMzoD9Rq8IobX+T6qv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AkHu/DSOkAfSKT+RRZ7Jjnamp6CbM0B6BXuvH43I3m7bFLsn/+oCOP4Uyh5fD8MMzsT1C0s6U3HJ1jU9NkKGGJfnGdnI56p1OsfaJlQaNGGg7mLpZFaw+to8ML4DeX1wL8gDW0KiLgzfUI/512GnK0LX56+8P6QVj/SpLGLt12nWhhlgwRQthmg8vpO+s40LOkIFn7TVYbnX7ng0Al0bfwdCNPij/aM/988kAjOd1OD7IAjqclYRbstAFDVOzfYt1AKgiK+HQLQxBfh/fGzF5r4tPx6KB/MeDgGPJEbOU5wBdfa9wfMx16BysgNhl3ts57CjTVx+8cRbsklpj6tlpnBi/NM8ww43CeuKi1tZwmBeerY0hg3wpfW4s+7WrMIIgUG2SqnFUQN6vcFSwD9p7XdZRsPXth1/5KxxLIzrDdvFSxysChNtBzmwxZ952JChMiuaRMInBKr0YMMcBvui5QCB5wODB2KDIZYLJyViSKwmI3YvG8c61aGLo6u8jXEIhSmFihPYdl8+rfC8lzs5mDZnG4QU649M0Xb+hLL4TFwAM4PNYLQ43DAkUMU/+tCg8n5fuxYBfSJv7LcGS6gvl+g/c/WahP8MXAuA4egsDXc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ed970b-71ce-496e-592d-08dc2d8847b7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:10:52.3165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zr0ogoN0XHa6J8WyTnSC1m3rINjhWrsWcH7lIniuReZB/zjHmcCS8Fl27hpylC7IXgZRE4WXVyG38iGrIIYv9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6403
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_10,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140142
X-Proofpoint-ORIG-GUID: hiHH9b-ApQpPpEX8n1Bg02ywzYahuMtr
X-Proofpoint-GUID: hiHH9b-ApQpPpEX8n1Bg02ywzYahuMtr


On 2/14/24 6:50 AM, Chuck Lever wrote:
> On Tue, Feb 13, 2024 at 09:47:27AM -0800, Dai Ngo wrote:
>> If the GETATTR request on a file that has write delegation in effect
>> and the request attributes include the change info and size attribute
>> then the request is handled as below:
>>
>> Server sends CB_GETATTR to client to get the latest change info and file
>> size. If these values are the same as the server's cached values then
>> the GETATTR proceeds as normal.
>>
>> If either the change info or file size is different from the server's
>> cached values, or the file was already marked as modified, then:
>>
>>      . update time_modify and time_metadata into file's metadata
>>        with current time
>>
>>      . encode GETATTR as normal except the file size is encoded with
>>        the value returned from CB_GETATTR
>>
>>      . mark the file as modified
>>
>> The CB_GETATTR is given 30ms to complte. If the CB_GETATTR fails for
>> any reasons, the delegation is recalled and NFS4ERR_DELAY is returned
>> for the GETATTR from the second client.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 119 ++++++++++++++++++++++++++++++++++++++++----
>>   fs/nfsd/nfs4xdr.c   |  10 +++-
>>   fs/nfsd/nfsd.h      |   1 +
>>   fs/nfsd/state.h     |  10 +++-
>>   4 files changed, 127 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index d9260e77ef2d..87987515e03d 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -127,6 +127,7 @@ static void free_session(struct nfsd4_session *);
>>   
>>   static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
>>   static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>> +static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
>>   
>>   static struct workqueue_struct *laundry_wq;
>>   
>> @@ -1189,6 +1190,10 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
>>   	dp->dl_recalled = false;
>>   	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
>>   		      &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL);
>> +	nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
>> +			&nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
>> +	dp->dl_cb_fattr.ncf_file_modified = false;
>> +	dp->dl_cb_fattr.ncf_cb_bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
>>   	get_nfs4_file(fp);
>>   	dp->dl_stid.sc_file = fp;
>>   	return dp;
>> @@ -3044,11 +3049,59 @@ nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
>>   	spin_unlock(&nn->client_lock);
>>   }
>>   
>> +static int
>> +nfsd4_cb_getattr_done(struct nfsd4_callback *cb, struct rpc_task *task)
>> +{
>> +	struct nfs4_cb_fattr *ncf =
>> +			container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
>> +
>> +	ncf->ncf_cb_status = task->tk_status;
>> +	switch (task->tk_status) {
>> +	case -NFS4ERR_DELAY:
>> +		rpc_delay(task, 2 * HZ);
>> +		return 0;
>> +	default:
>> +		return 1;
>> +	}
>> +}
>> +
>> +static void
>> +nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
>> +{
>> +	struct nfs4_cb_fattr *ncf =
>> +			container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
>> +	struct nfs4_delegation *dp =
>> +			container_of(ncf, struct nfs4_delegation, dl_cb_fattr);
>> +
>> +	nfs4_put_stid(&dp->dl_stid);
>> +	clear_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags);
>> +	wake_up_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY);
>> +}
>> +
> What happens if the client responds after the GETATTR timer elapses?
> Can nfsd4_cb_getattr_release over-write memory that is now being
> used for something else?

The refcount added in nfs4_cb_getattr keeps the delegation state valid
until it's released here by nfs4_put_stid.

>
>
>>   static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
>>   	.done		= nfsd4_cb_recall_any_done,
>>   	.release	= nfsd4_cb_recall_any_release,
>>   };
>>   
>> +static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops = {
>> +	.done		= nfsd4_cb_getattr_done,
>> +	.release	= nfsd4_cb_getattr_release,
>> +};
>> +
>> +static void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
>> +{
>> +	struct nfs4_delegation *dp =
>> +			container_of(ncf, struct nfs4_delegation, dl_cb_fattr);
>> +
>> +	if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
>> +		return;
>> +	/* set to proper status when nfsd4_cb_getattr_done runs */
>> +	ncf->ncf_cb_status = NFS4ERR_IO;
>> +
>> +	refcount_inc(&dp->dl_stid.sc_count);
>> +	nfsd4_run_cb(&ncf->ncf_getattr);
>> +}
>> +
>>   static struct nfs4_client *create_client(struct xdr_netobj name,
>>   		struct svc_rqst *rqstp, nfs4_verifier *verf)
>>   {
>> @@ -5854,6 +5907,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   	struct svc_fh *parent = NULL;
>>   	int cb_up;
>>   	int status = 0;
>> +	struct kstat stat;
>> +	struct path path;
>>   
>>   	cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
>>   	open->op_recall = false;
>> @@ -5891,6 +5946,18 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>   		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
>>   		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
>> +		path.mnt = currentfh->fh_export->ex_path.mnt;
>> +		path.dentry = currentfh->fh_dentry;
>> +		if (vfs_getattr(&path, &stat,
>> +				(STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
>> +				AT_STATX_SYNC_AS_STAT)) {
>> +			nfs4_put_stid(&dp->dl_stid);
>> +			destroy_delegation(dp);
>> +			goto out_no_deleg;
>> +		}
>> +		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
>> +		dp->dl_cb_fattr.ncf_initial_cinfo =
>> +			nfsd4_change_attribute(&stat, d_inode(currentfh->fh_dentry));
>>   	} else {
>>   		open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
>>   		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
>> @@ -8720,6 +8787,8 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>>    * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
>>    * @rqstp: RPC transaction context
>>    * @inode: file to be checked for a conflict
>> + * @modified: return true if file was modified
>> + * @size: new size of file if modified is true
>>    *
>>    * This function is called when there is a conflict between a write
>>    * delegation and a change/size GETATTR from another client. The server
>> @@ -8728,22 +8797,22 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>>    * delegation before replying to the GETATTR. See RFC 8881 section
>>    * 18.7.4.
>>    *
>> - * The current implementation does not support CB_GETATTR yet. However
>> - * this can avoid recalling the delegation could be added in follow up
>> - * work.
>> - *
>>    * Returns 0 if there is no conflict; otherwise an nfs_stat
>>    * code is returned.
>>    */
>>   __be32
>> -nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
>> +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
>> +				bool *modified, u64 *size)
>>   {
>>   	__be32 status;
>>   	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>>   	struct file_lock_context *ctx;
>>   	struct file_lock *fl;
>>   	struct nfs4_delegation *dp;
>> +	struct iattr attrs;
>> +	struct nfs4_cb_fattr *ncf;
>>   
>> +	*modified = false;
>>   	ctx = locks_inode_context(inode);
>>   	if (!ctx)
>>   		return 0;
>> @@ -8768,12 +8837,42 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
>>   				return 0;
>>   			}
>>   break_lease:
>> -			spin_unlock(&ctx->flc_lock);
>>   			nfsd_stats_wdeleg_getattr_inc(nn);
>> -			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>> -			if (status != nfserr_jukebox ||
>> -					!nfsd_wait_for_delegreturn(rqstp, inode))
>> -				return status;
>> +			dp = fl->fl_owner;
>> +			ncf = &dp->dl_cb_fattr;
>> +			nfs4_cb_getattr(&dp->dl_cb_fattr);
>> +			spin_unlock(&ctx->flc_lock);
>> +			/*
>> +			 * allow 30 ms for the callback to complete which should
>> +			 * take care most cases when everything works normally.
>> +			 * Otherwise just fall back to the normal mechanisnm to
>> +			 * recall the delegation.
>> +			 */
> The code already says what the comment says, and if
> NFSD_CB_GETATTR_TIMEOUT is ever changed, the comment will become
> stale. I suggest removing this comment and adding just a one-liner
> something like below:

ok.

>
>
>> +			wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
>> +					TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
>> +			if (ncf->ncf_cb_status) {
> 				/* Recall delegation only if client didn't respond */
>
>> +				status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>> +				if (status != nfserr_jukebox ||
>> +						!nfsd_wait_for_delegreturn(rqstp, inode))
>> +					return status;
>> +			}
>> +			if (!ncf->ncf_file_modified &&
>> +					(ncf->ncf_initial_cinfo != ncf->ncf_cb_change ||
>> +					ncf->ncf_cur_fsize != ncf->ncf_cb_fsize))
>> +				ncf->ncf_file_modified = true;
>> +			if (ncf->ncf_file_modified) {
>> +				/*
>> +				 * The server would not update the file's metadata
>> +				 * with the client's modified size.
>> +				 */
> I don't understand "The server would not update...". Does that mean
> the server is not supposed to update, or something failed? Can this
> comment be clarified?

This is the recommendation from section 10.4.3 Handling of CB_GETATTR
in RFC 8881. I'll add this info to the comment in v2.

>
>
>> +				attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
>> +				attrs.ia_valid = ATTR_MTIME | ATTR_CTIME;
>> +				setattr_copy(&nop_mnt_idmap, inode, &attrs);
>> +				mark_inode_dirty(inode);
>> +				ncf->ncf_cur_fsize = ncf->ncf_cb_fsize;
>> +				*size = ncf->ncf_cur_fsize;
>> +				*modified = true;
>> +			}
> One of the lesser-known guidelines of coding style is that if the
> indent level grows too deep, that's a sign that you should move
> this code into another function. Up to you, but IMO that might be
> easier to read.

Thanks, I'll keep this in mind for next time.

-Dai

>
>
>>   			return 0;
>>   		}
>>   		break;
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index e3f761cd5ee7..9e8f230fc96e 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -3507,6 +3507,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>>   		unsigned long	mask[2];
>>   	} u;
>>   	unsigned long bit;
>> +	bool file_modified = false;
>> +	u64 size = 0;
>>   
>>   	WARN_ON_ONCE(bmval[1] & NFSD_WRITEONLY_ATTRS_WORD1);
>>   	WARN_ON_ONCE(!nfsd_attrs_supported(minorversion, bmval));
>> @@ -3533,7 +3535,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>>   	}
>>   	args.size = 0;
>>   	if (u.attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
>> -		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry));
>> +		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry),
>> +					&file_modified, &size);
>>   		if (status)
>>   			goto out;
>>   	}
>> @@ -3543,7 +3546,10 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>>   			  AT_STATX_SYNC_AS_STAT);
>>   	if (err)
>>   		goto out_nfserr;
>> -	args.size = args.stat.size;
>> +	if (file_modified)
>> +		args.size = size;
>> +	else
>> +		args.size = args.stat.size;
>>   
>>   	if (!(args.stat.result_mask & STATX_BTIME))
>>   		/* underlying FS does not offer btime so we can't share it */
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 8daf22d766c6..16c5a05f340e 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -367,6 +367,7 @@ void		nfsd_lockd_shutdown(void);
>>   #define	NFSD_CLIENT_MAX_TRIM_PER_RUN	128
>>   #define	NFS4_CLIENTS_PER_GB		1024
>>   #define NFSD_DELEGRETURN_TIMEOUT	(HZ / 34)	/* 30ms */
>> +#define	NFSD_CB_GETATTR_TIMEOUT		NFSD_DELEGRETURN_TIMEOUT
>>   
>>   /*
>>    * The following attributes are currently not supported by the NFSv4 server:
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 3bf418ee6c97..01c6f3445646 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -142,8 +142,16 @@ struct nfs4_cb_fattr {
>>   	/* from CB_GETATTR reply */
>>   	u64 ncf_cb_change;
>>   	u64 ncf_cb_fsize;
>> +
>> +	unsigned long ncf_cb_flags;
>> +	bool ncf_file_modified;
>> +	u64 ncf_initial_cinfo;
>> +	u64 ncf_cur_fsize;
>>   };
>>   
>> +/* bits for ncf_cb_flags */
>> +#define	CB_GETATTR_BUSY		0
>> +
>>   /*
>>    * Represents a delegation stateid. The nfs4_client holds references to these
>>    * and they are put when it is being destroyed or when the delegation is
>> @@ -773,5 +781,5 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
>>   }
>>   
>>   extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
>> -				struct inode *inode);
>> +		struct inode *inode, bool *file_modified, u64 *size);
>>   #endif   /* NFSD4_STATE_H */
>> -- 
>> 2.39.3
>>

