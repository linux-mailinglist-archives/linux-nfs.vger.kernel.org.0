Return-Path: <linux-nfs+bounces-3444-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0A68D1E88
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2024 16:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9FC1C22546
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2024 14:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F2D16F82C;
	Tue, 28 May 2024 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k4NBgBE+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CFcREBYP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0A91DFDE
	for <linux-nfs@vger.kernel.org>; Tue, 28 May 2024 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906252; cv=fail; b=AFDUEnczbHFTM64rot8sigjx0y68sFRTSl4WUNZqgQbRiGGFcW4MX5ZHPXK8LXMhY0Qof0zZE0Xz+Rht7SIzmQH7H7wVQcadnvV2N+7rplQVLWvxU3cHigG26HJ2Vv7mIzmEX3U1B9Bs87IJkX8DLAxK4Zhc6zl5og1YifqY7Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906252; c=relaxed/simple;
	bh=Vv5gEKMdg/LzZ1kBuJDkk3pFHLS3gzxhWnrLHzvR6M8=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=ZeiMbFNMxuGlYxsM/kICBYVSVJeYOBcNt78sfKvaD8Uwcurkw58CzzpF2cQE4PB9E4WhMvUmclKLlhPY3SP3mLF/+FLTCvmA/wdi1BJF8IU7AmPHwxXESEc8pU/C35eGo2NRXXl69D6nJz76lVO75MhSjAczcJXFrfXw54k7yFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k4NBgBE+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CFcREBYP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44SBp7TQ029275
	for <linux-nfs@vger.kernel.org>; Tue, 28 May 2024 14:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type:date:from:message-id:mime-version:subject:to;
 s=corp-2023-11-20; bh=36J3BLnyX6OQC5znyWYB89fcauJ/UBWpCkT8uMBQNe4=;
 b=k4NBgBE+qlZ+Z+8oRaCRygCyuWag0Bjx8FvOeTP3OeMZFN58uD+346EpQQkCvRuVnoMr
 7TEjtE64H5V0B4zorKGFABZB7XhffcqFtQUamX0wEyD/jyJMwilCC+AaztGRvoGU9HbR
 /7El7DAmczVA3QEy43MZkqULjd1HluSNqqiJZEZ8IBi/WTl/zOD0dP2hS4RYR1aGO9rB
 ik72ix0GrNM1tjwVIiswes2LMpW3yhOEVSaVeAVhJpD+8Hr7O6BhOuXinGBRn5LWhE+J
 mCjPleXVAPbNYd3Xz+mVW82lMU2Pu6CUaIhvbCjv6s+KTMYZvzeYXFfFo8xL3+G7gIaV yQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hg4gu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Tue, 28 May 2024 14:24:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44SDqHn8009333
	for <linux-nfs@vger.kernel.org>; Tue, 28 May 2024 14:24:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc52b738b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Tue, 28 May 2024 14:24:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zamzv5sD5/KLDOEK/l9oKBCqer8tWwDX6aaQTjR9VfchEObFZF/tLZkoKq8B+8VheedrXW1opMe36UrDlFN9mnxHp18MEYIjSInzaP4oHeYgluZy40t6WQLEmhNPGvHDSco5W8al0iJfHJmPfJa283Rw/7HcKpszDlFdQVriJtXupNK3RcitLrer4zlpRX9KX44dn6E0Xe7xrVQiz272dF779wTD9qzVQppSGEcxpDBFFl99p9MjjUSGhEY8moebgKlLav+ZTerIQUyUMZxKkSSpus/8djoxv/BgjF6E9Pzk7Ozc/sIXAz8arNd4X72Bh7HhuwuAk/jWi8ksDqBrTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36J3BLnyX6OQC5znyWYB89fcauJ/UBWpCkT8uMBQNe4=;
 b=iR2R6p/HS4q+ho0NtB88MUcdt6Z2NZ0kVUu2SkigOkeT6UjozdHTHNAkaXkcSHXfyiFF/MFLanxQx28DwyqesMfxhedXp+15gs+1AsD75s0TdtL9hrnRs8A6w9/X24S2k8gh8dUog2fwn62Re1ZtdMIs+x4XFLBDSf3D8qa2vp+zMy5L1djvgg9T0kgUNeXzJ4abhlRfrBK2GyfLeS2wAKExESvNTyWrUmqBymj2XwHu0I2WODAgTxVmntBYoE6ORHXuu0BQJr91k7XPH/G+rQUfsKmw0fbw+FHcq8uXKktNhAaP8GeEKGOsfpsYmkY1q//4EBARU/1B6OfCA6agzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36J3BLnyX6OQC5znyWYB89fcauJ/UBWpCkT8uMBQNe4=;
 b=CFcREBYPGMQBzE9DUw04bC/dph7ne50H1zzZoEPW2qiPMx4Hev0VtBNOG1EoH/uxPOxygzafEsXMl3GPdQg6WeQMVXON6auZhMc5RD84KOMvYnyaOlxCaqlgkJtj3+71dG16i2THxq9PPH8fyQJYJ1Wj8CT2W1JjZ1PREWQmg0U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4633.namprd10.prod.outlook.com (2603:10b6:806:11a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 14:24:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 14:24:06 +0000
Date: Tue, 28 May 2024 10:24:03 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: long-term stable backports of NFSD patches
Message-ID: <ZlXpA/xEN7iRT927@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH2PR14CA0045.namprd14.prod.outlook.com
 (2603:10b6:610:56::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: 1defadd1-4e52-42e2-f533-08dc7f21d4e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?REy0dBrNms1v3xCCvmr1kT+UAuF22AVQb5yPcz9W0piHU90zqlLYJSLKhsw8?=
 =?us-ascii?Q?sWeItYLywg5N1eIP4WUGhk+2D6eMDw2VTWWPumhsds9FO6/+qycaP6braG9a?=
 =?us-ascii?Q?Hc7rNYYbI56k0nO6ifoQJpcUVrC25wTSfcJhJw6dVsmSJJTWFmk/XghTdARd?=
 =?us-ascii?Q?N5dOAFDvy5mWqWOgygHXuUcjYbpRMLo6kj3WZqgBMSB94yDXSpKtG8oB7HsU?=
 =?us-ascii?Q?82onjaX/xrZXhwJUB7nBxq3TcWo2sMlwLyh24zJetOSeroqDKfePKq/5Cn60?=
 =?us-ascii?Q?PBBwN0k8IxBQkaNsivPVQo/YhUxpGcxUDUOhJIY5HIRelTmFXqUHGoNZR/Ig?=
 =?us-ascii?Q?URawrPjNA4Tmvy976RCl/0Y0JdP/kSBomptrH/DDWqjF7LEGxLQEPlnLg9cB?=
 =?us-ascii?Q?JkW2R0kwgreNFxvN6iZweals0ob6LN9F+tdpGD3a0TfJQ7ScA6Qp47grKeTk?=
 =?us-ascii?Q?veHHgwtqhVNBhvqE57mITaig0hmVZFO40w6CbBcmZ5xiDdtDOpOwR0wAS4y7?=
 =?us-ascii?Q?46bnuG3vSDdgE/FOQx0WN2YRNhGeujxjbwBgxNqT7rGOZc+MFuiYdK/czTrP?=
 =?us-ascii?Q?MJzpCgLD7iSJ3wLmgVSkOIFG9QhmTOUhM2LvTMolYyk1GwZmapduxSbQnNUu?=
 =?us-ascii?Q?IOfSEWMK8YV+vyOVUYjfrHfPLvyvgBpNXkimIZH984awH+sXQYCS8kfHPGvw?=
 =?us-ascii?Q?AQ1rAgZlZqry26F8Gcft/PjNdNy7H+fsurGlCPFL/eYxhusCgL8NUk9NUPDg?=
 =?us-ascii?Q?BQ67dZjb8O1j65sYp8a03ILa5IpgE5kYTJnWGA9l2np+xGPTrLbcWyYldLfP?=
 =?us-ascii?Q?WW+5hbUkuUgLPTuBZZyN72u/x/yP6JvYv8bxog4A/4RuU1KNi3g850p3ll/D?=
 =?us-ascii?Q?SJ7Jz6HS812HlJuZf8zknpIGCmrW+t0I5bdjqqjgsfEJQLV/n5saPZRteSBv?=
 =?us-ascii?Q?MJ9bR/3UMmOrcIU4j1wPnu/Nczxa+6TZ2ugwcx3hMI0QS8ZBGvhfKtXq1Td2?=
 =?us-ascii?Q?VP1VQSP6e/1if2Z/XMKoPAARzzBMKQP3e7wntVVagD0wv10BwhQvgrHeP2dI?=
 =?us-ascii?Q?S0vMGQsjBGW/oS4PUQQVuwSkgtyNNwsHmQbvYnJ5bVTUKUkvm5LbeNoMS9a/?=
 =?us-ascii?Q?OS3uZdmQ0k4gjG/oH1qaVAMkvzIFx4bFTllY6TLyTObazhRHm7OCIKthkK6k?=
 =?us-ascii?Q?K+UPj4C43Xd7PE2DZ7RTJ9GPvqJbvRXWeJ1RXo1fp8JWnqcVj+zu47YSsXs?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?spYZ2JYuVWZk5YemhOpWVamhuNXbJoK3wE6caS3rkqHe3MJaGa3n1jgpz4GG?=
 =?us-ascii?Q?T1Ox5kUDbKlBQakz+JgmWwtBq8ZR6Jx9jywXX9HF06HQrooErd68gF10BFoE?=
 =?us-ascii?Q?AtjU99d0g5H3MRBMVWIwC8KjLw54vik+j7nwCzmsHuxetOMU5KV3kK1k2XNC?=
 =?us-ascii?Q?1BDfn+qn338GXzwSNpMaMJAbGI4yKBbE6Sg64//7FgIQUrBONWAFNFi1KuH3?=
 =?us-ascii?Q?Jk+qOe9hJ/1P6D5cGbugEAWjgFXf357aUqrcO6Tp7yJYYeu5zaaQoGTfAgqh?=
 =?us-ascii?Q?lhVVuZ1zjqP5bCAQHjv3uurEMAAq2iMZLIwcMrcpmnuGy7ewkR5LQYlyi4hM?=
 =?us-ascii?Q?7FlW5y9ZOrZ9XctFj1DmCoImn+xIjg/QdpynkaCTjVF1yAClppWhlXMlmLFN?=
 =?us-ascii?Q?z96Lmq191IgyJYZxLqbW13bTqhJ5CElPuScCpwXYuWosg2VouOExc9urPEzy?=
 =?us-ascii?Q?qoIMBull3WlPFqGx0YXIJKdlivctX/Si6KzPR5bPGSoGsZD7FbUnZ0P+aZ2g?=
 =?us-ascii?Q?Tu2YDbV9F/iYrHbQ0RdshF9hgvHN4V293+NWwAbWURx6cgNtEeHdhexRhT1f?=
 =?us-ascii?Q?RG4pHnadCrjRC/R9DuudUJvOCIMkO4T0kCdsov8L4qhQtD8AgSKzSFOrzxtT?=
 =?us-ascii?Q?q/CZlTXTcMnO86iQ783VpW8NBXvaqy2J5AfMOQTjJXL25mFDd5mA/e1BjAis?=
 =?us-ascii?Q?oFdHcqmCviWucJsO1niBsMrJ2nnf/6w0foLsb5Rwl0PknXf2Z0mleXAoNmGF?=
 =?us-ascii?Q?cRHTc7p6Vq2qVIn5idti/QlNZ4prOkCAawOl6xRHe0AeMrgcI9dC2Ut/BlfT?=
 =?us-ascii?Q?gdynufvHC+0mO5S62drCPO8qDAZCySetG18gvBsowukkYq78X5hQnHlEJ8q2?=
 =?us-ascii?Q?0aaamBa1YuJbaTyC2ja4vK6EbbPe5WwdyUx2ED0MR6/KluGY55AbLmaQlIXO?=
 =?us-ascii?Q?UUqNp3ZxabIc09//O+pUrpJHaOj2H5C/m4rt/MPu1vLaSVhNir6q3wx9rUdS?=
 =?us-ascii?Q?RiYHWyhNppz4v8pdwRK5h+wciHtUkBLgDRf4pzyUnrdD8EcqGXM76TOKtCGT?=
 =?us-ascii?Q?Bos+sBhXgcjN4P18jf3qChygWA6Hnag2kJjkviYF91sfoG7dvAp057A1gkW5?=
 =?us-ascii?Q?LHBQ5rS/eEY0UuAwsAkPFptennyRws0VZoaPCUPMdDqPoLM42W+C5SLu7PDs?=
 =?us-ascii?Q?qUS4z1+VCTRY+dG0VablhR+Y/o4ABcJ9LDkfwtP/3xhI9Gl4A/Ec4lQiLxhc?=
 =?us-ascii?Q?Md+1j87ujONkXQKOdLxQ2gjuoMNJC0wKiKv4HQf94vctKSCUS64ASwnCzq+x?=
 =?us-ascii?Q?heDi+cjh4glO409s3ejx2M3E1Ls+W3GmOEB9DWSJx4NLFi+BBwy9I6rOxI5u?=
 =?us-ascii?Q?HxCycRi9jtBmECQDLBgbj0KW0SZ/MqnfJRgySkqwGLZayuoAkvHb0ddgZE8+?=
 =?us-ascii?Q?14RR1EkG+9FuW5/y3eovvOefRWtE40PtS6pP1unUQZiXhuVVhmQZ9AIAVPlZ?=
 =?us-ascii?Q?07XHuM6IwlwYdF/KCoLnZCV2f0o5x69L/p4nSrHoy8UebSzvaPdNgPuOMrn+?=
 =?us-ascii?Q?X1907y4q5wYnjWVskyBwxJ8497XTNjA3cvV85bLn6VE2ExfHdATVsclKYziu?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LGKKlEZnxxvoNcNISYu8Q2BCR71dev8vGeQImVhKDqnNgHe6czzi/WBW9NkjIHIDQDl7LO3obJK2SkoA1h9NE2iPvr1ba4faZMkeIYOCM09faivZri1ssTrdP8il2Q+LzrzQzcSQWC/joQ4PKhIkp2Z7KAOhdaJe+do7iLYlNRGOv8xEKM5i9fKP2NJC3lRVbz8+stnLo71h6eHeKuMJohhqQdyC+YW01s3J9UvOYnM9CdBH2J+IdBHM/p1HOPSYkK8O1DXgXeDpxgzAGVQNxzEs6ENYpgydpJMRUk1GV7p042KyVHznBwWYxpn4auGYpx9THd4Qbu47SShJvtAj6NTnMA3VMtoqReiLyt1HnTlcHB0q+cAyBH/X6EcdpXQWLMpY0Kav0pSR0UgTJHqVus6vMUPeNg48mQeFyCV9INWb6QUWanVECOngu+WbHqlCMTzeFbLMI44DuDNOMeElVC/JmPQqkoaO4S5RlGw65lo/D1hmyQj3Ei7mwa8v2LusPorDaxO5Ffzf2gQfQAosnpSV+D33ExerFJFfIzVtke1LrsQWgTvHC9G+jV4Hgxl74s6g+Y4EN3zze6sFS37cgOToPxmb8AFlUQuRhR7oMdk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1defadd1-4e52-42e2-f533-08dc7f21d4e0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:24:06.2831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBLIHaZ+lskNn/Vo57QDdyp8EkcMz9SKSfPMmYXdAaIb4KFq/PDnnXLhV+uUS+/MlDVAlHtsMFX2ITPNPBWQSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4633
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_10,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=838 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280108
X-Proofpoint-GUID: uuUIOWHCD20CpFXvCdrQQsC2SHEaWED6
X-Proofpoint-ORIG-GUID: uuUIOWHCD20CpFXvCdrQQsC2SHEaWED6

It's apparent that a number of distributions and their customers
remain on long-term stable kernels. We are aware of the scalability
problems and other bugs in NFSD in kernels between v5.4 and v6.1.

To address the filecache and other scalability problems in those
kernels, I'm preparing backported patches of NFSD fixes for several
popular LTS kernels. These backports are destined for the official
LTS kernel branches so that distributions can easily integrate them
into their products.

Once this effort is complete, Greg and Sasha will continue to be
responsible for backporting NFSD-related fixes from upstream into
the LTS kernels.

---

I've pushed the NFSD backports to branches in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

If you are able, I encourage you to pull these, review them or try
them out, and report any issues or successes. I'm currently using
the NFS workflows in kdevops as the testing platform, but am
planning to include other tests.


LTS v5.10.y

I've found no new issues in nfsd-5.10.y, and have continued to build
out automated NFSD testing for this kernel and origin/linux-5.10.y.
I plan to send this patch series to Greg and Sasha soon.

You can find this series in the "nfsd-5.10.y" branch in the above
repo.


-- 
Chuck Lever

