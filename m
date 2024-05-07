Return-Path: <linux-nfs+bounces-3189-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3088BD8A5
	for <lists+linux-nfs@lfdr.de>; Tue,  7 May 2024 02:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3318DB240A5
	for <lists+linux-nfs@lfdr.de>; Tue,  7 May 2024 00:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E725182;
	Tue,  7 May 2024 00:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nGLddCnh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iwhxv5fL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC44A622
	for <linux-nfs@vger.kernel.org>; Tue,  7 May 2024 00:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715041685; cv=fail; b=XgWLex1UWnVD2zNrs2HVTE/845fy2EyVlJAl+3CP1Yap75P+grJurqTJmenYzY36cYYcdX6omJ9SA2bpu0W8w5Lhm6X3G4qLMg4bRATnJm8mI6oIERVX9ThyHdxrCWpWMPjeTNyunwaw/riMISOgjRpJQqdGAE2tTGbiZ5hNDlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715041685; c=relaxed/simple;
	bh=u3G4yOLsjIUCS3bJAqgqAfUhTunpwNLPE2U++hfew1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uhRsW7I2OOTYQJFXne6Lu/vwU8vBC20GHXmtsNm7aFbzvp1m4UkKYHng/QRPdqXvmWSibQxUdTuCiPph39NlcczghTm9yNJDf7iZxgwiW4lXyaIMHESnvTtH+ONzBZij3JXuFoSLkHBbIUcwCO4tdKsrcUGJZtZ8t7crYV398LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nGLddCnh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iwhxv5fL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446MmpNa015629;
	Tue, 7 May 2024 00:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=DrDnAQicHlAB6Lea5l/6XKfjyUn5sIKeCaPsxF1qyBw=;
 b=nGLddCnhXo0lutTApEQQyMqOa5PDxaO4N5zT9Z6DnqKZ18DOx7BlXQaylR51HKuucQj3
 gqAkXGL4YsfDQH7igr6agbjvsQ3yQm9NgW8vRNVP4jK2irBZixjwDGfcgUaJ5seU6zrL
 xPj+PVUw/W3Q3eDWmWm+jfW5E2EO6Flc4ik+zhukQnXBeMu3hcijAr3VTBOaalMTTrZ8
 C6z72PvJaV3cwB4Br1+akve/L/lEoQ6rtJCBMxESjOGKO2F4PEqwDSRkBRHLiLEkgj5Y
 y3Q1gg0APC7Ar69121SpCnl2v4rKMkV04ryjj86uAsOjsyc1Sz9AYIOwC3UDDRThope6 DA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbt53u3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 00:27:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446MUFFb014042;
	Tue, 7 May 2024 00:27:58 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf6qcvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 00:27:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PR0hILN3GBnX4Mr5KDm4439QhKYnhAz5ifiQ72b5xWU2tqAb0jPRO3vh0yXMvm1HFXe9lE09lam5g5ks8t7yKN53T2fiiIbGF9p7sTzb1GDbWJ2PecDqjmAkwSiVhjIw4PA71OTjnaYMIAW8eNB9e70K6mLbWfqxXWvfEvqihlbxNvAIv7uPgtQFRqgLSHAMKtgdX2RCZyudxmpnprve5hrEd+GlJa01QKrT+QL8+Gv1kLJB7SWNpBuOVo3YWDydrhYxaaLIbUYuqPzWzORp1Jvmr6RilgYfXmbwRyMsAZsJa5bzWjZPTBqU4tN+7kwfnVojux4iyyTuvDb1aJViWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrDnAQicHlAB6Lea5l/6XKfjyUn5sIKeCaPsxF1qyBw=;
 b=QwM007RQiVLEs8or1PUCtva9cLtfMxF1RGUWKmUwvatCG0fCGFLnGFPw1JGq9rMo0dkUPfhyEgp3jfZMpkR24YI6N2jEiff9AWzRakAYKx5fCMxQN4Jk7UiK8BrqkSC1AVprVjJgMKendJZv7zLMpGNFEf2kH4AJdVcyg2p5D+9rFdTirp9pQq1Tm+IaNG+IeAmTx5qG7A9w73i5zJt4mKh4HDvidPfvmXg8aCUdzxYbs1zf9HmcYYsX5kr6IVA3MYhgRVhkzcZh+1jnA7a1U2F78bPDSJyvaKTLlQUJCwnZx/RlhomX8iZRptFg/FgQ+xYhQ7dgi0DFnZj1L699YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrDnAQicHlAB6Lea5l/6XKfjyUn5sIKeCaPsxF1qyBw=;
 b=iwhxv5fL3zktZ2OloTe7mY+dIk+gfBCff40kQO0PkGuMDWKkEjs6B8erouF+92TBeJauxq94LHLrNuZOoUtPO8wNex27nE+yenL1w9jMFEtNpISX30F5Z3WKpENJUXLbBtv2u0dOKaaaOHvJaLLlG52Q08vG8maJ8lrjaeHohQ0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6103.namprd10.prod.outlook.com (2603:10b6:8:c8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.41; Tue, 7 May 2024 00:27:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 00:27:55 +0000
Date: Mon, 6 May 2024 20:27:52 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH] NFSD: Force all NFSv4.2 COPY requests to be
 synchronous
Message-ID: <Zjl1iNUJVBNMqlOd@tissot.1015granger.net>
References: <20240506210408.4760-1-cel@kernel.org>
 <35d2a207-7671-4f8a-be2b-3da03fedee50@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35d2a207-7671-4f8a-be2b-3da03fedee50@oracle.com>
X-ClientProxiedBy: CH5PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4c7e15-23cb-4bf1-72f2-08dc6e2c89c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BzAn0ZQrSGSf3t2bkffAuMhkTlY7jGXE+HZ+/w1tRgYr1+gWjsp9yeQSJK7O?=
 =?us-ascii?Q?22zavoN0e56AI0hXsDbWBcIaI9iNWkmEbcaYJf07aJZOOHfPXY9Fs5uxuHIA?=
 =?us-ascii?Q?Nkw5t5BguMBzeLMwgmy95QZS/OPdyT+MFM4jYq/7vTEAi5+Xdp7vKM9Rckx4?=
 =?us-ascii?Q?5sTJma3h7vSo8RXBeOfSp5MVmtp7KwlZdx+wQFXINhU8MLe19bvti3/CybOc?=
 =?us-ascii?Q?7//Lzqau1Xp0TUkeyJYX5l1rLFNodbz8VlTPyogiXUqs/zvlso98N8+JplG3?=
 =?us-ascii?Q?x0Dog8TbVjQi9K3yO4JDQj9/eROX+GSjSRfyjeFnJgeUF2Wy/EJj+s1T+FqB?=
 =?us-ascii?Q?Q1qqDKM4016EyekIet3maAzNeUr6WzZB7HHSjd7XKwvPR/l/ygBqbk/ozdMm?=
 =?us-ascii?Q?sM6y4pXEjD51b0Y+qhs3ViSKYngKodEtoCg0568/krBzkFXfLpaYHdmLHv6O?=
 =?us-ascii?Q?198jNyUR7JKWZgjg/suFYAKORphE9Ex7R9TmchoDMOHR6QWlaAbZk2LstfzS?=
 =?us-ascii?Q?ICb7+V5bZ5F4GCIiw51Qz8yB6AOVti3JRYq0dAGXPvEMFUVlUI70jZxScuEY?=
 =?us-ascii?Q?xhTuY8ut8AjElTJARqr+auYD9zaeR7TXX+BwK6wAoCpohlrRwDWphVJsLNOC?=
 =?us-ascii?Q?F3zyrZxKPpJpZnSKM4QL44gIe32wnVK+Jq+spXu+fJdXwhl8BVXXli0qqBm7?=
 =?us-ascii?Q?fi34dJZyMC6iignnV7/vyFNN4rcmerH9C7qVTsJmaqKYmZeGijoDLa4jUa1d?=
 =?us-ascii?Q?jyt90CKsu6UtQUQ0eM5gdLy2AUq++ekr9T5oJFtjBHzkGkLYJm+u/2je4c6C?=
 =?us-ascii?Q?WShfdELGzrWIL7+GMz+Msq85afKHlHl2cHi5S5SHeI6XI3MqZEkpaIdorzu0?=
 =?us-ascii?Q?tdswb/pLhPe9QwG0BpHKBGpeqwAh3DL6oMylsPEf89GywHUs5RtiAsLDOpoT?=
 =?us-ascii?Q?yi/PQBUrcnBFbaaCedDxQanvG7p4lMVtH+C4aSAAFAAAgICZOfxXQW4FIqOO?=
 =?us-ascii?Q?BFYX24PxOEOCZVD0k0Koygy9Xdje91FoNxjWV0dBmWGejTZjr87digONSZ2o?=
 =?us-ascii?Q?iVNArsQlcYvvk9gdXZuS9dTots4Td+PCxFbzCA7B57H/WHbrkxAa51PGmaRE?=
 =?us-ascii?Q?przokygzr6SCzuWnITJ9bJxZcS1+6+fcwNVREk4ZzlMRovtMqWRtnOxtVSJe?=
 =?us-ascii?Q?PvTse0jSapVoIoZpHESqpRmuOfU6z6dzh2bfJgLxDWy29GjERfuYqkF7AeXW?=
 =?us-ascii?Q?0yBSpZj3ZPjWjJUFbEarTS7uIxLi81PZtSDHAZTotg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZBNoefatQU2NP87bWYI/l8LsOSzgXy2IeBpkI4MS5Xs6GxKE2ymnhBiH3G4c?=
 =?us-ascii?Q?v1DKsulXrlQcvivfuAKtSDVRYEy7eBg3L0Eyl4sbI5VbNTiMIc0JDkoa/Gfl?=
 =?us-ascii?Q?80MLJhkMXWfhOfxkSxFGxN/Utzr/+QVDvJbeDvQ0owfu21OfRDn+fRwGrTL7?=
 =?us-ascii?Q?LEdsIMVZmVxSnIx41Q++uYqgTZcjXihIXFVHEeoEiR1+sYsd6c2FwDL7iLjk?=
 =?us-ascii?Q?pFs8811mgnSvCzRcnijHZWaMEB+qGVFSZkop1282GDpO68BnSeI9Sj7KNtak?=
 =?us-ascii?Q?k5bpiR5An+qWDmnVpuG8N6kJGB6TXx32MFLJ/A6av30Rby297dpjn6raneji?=
 =?us-ascii?Q?2Qb1wEbOLGQWdfTyWNK/jLXAjJgTuS/Zh8Orec5/W9ks8B+3VgDXtwVFA5If?=
 =?us-ascii?Q?aTpiqSfpBjX2tcFnBHLUgAGNsG1hnxcW3TI5Oc9RcJJj2HlTUKeDt0ll99YF?=
 =?us-ascii?Q?bPSMtAxBsqpOKQJ4/gk7oplD4+wsu4CjpaMoPPPs+AVx6Id7bJI7EMzpWXKc?=
 =?us-ascii?Q?THMhwLgJYDWgyy3DpMnR07Bz75IyV/9JbUStOTY6B/cy2NevVNeNzzF8Kxv7?=
 =?us-ascii?Q?urMOMJrQL8XOepyeEtoZ7FyAtYGIvp4Dj5teQv3Mh/ClNZeiWUuGfV/qeT/c?=
 =?us-ascii?Q?//ngh5gyXIouInD1N0Q5cPeK3HBn9ZeG/QAYdn5A1qHavqoKiDciDxpPuJp8?=
 =?us-ascii?Q?u/V/VIL9Ss2ftAEb35IIRHB/qFf5GpYVSeug8H/dZ7JUdMy6sc/Cc4fTcVu4?=
 =?us-ascii?Q?H7Kh9ivtjb/qo3zT/0A6B0Jm+LKMa3+T/F1iokIFt3FAjtOW9OkEmrMR27SR?=
 =?us-ascii?Q?ZFiA4/l0FWf5h7/H5Raf7lKVD/tBGjC7t1OGCvUBtwRhM8HkFkfY/K7bl2Fu?=
 =?us-ascii?Q?pOiZoKh7PKITHsaW1I/NekOejPzdu6D4ImORjXd4KRiiB3UcaxNYZB7prfhU?=
 =?us-ascii?Q?ba9dAEhEYzSWBqhG+lRAVuYjwHA4XfqnvTYJYJJpVDgneEM4thGU5I2Rmvcy?=
 =?us-ascii?Q?QrhIVgjtAZM090bKoqoHA37K4HIJPHugOpMn1tqUgGK6jxrm1RBDM975Xq9f?=
 =?us-ascii?Q?MUe+OGH1DxLlOGA0fvQsmgvwS8OOxy/sJJxY/WI3Vr2zjftP3kZz1rOXAEkn?=
 =?us-ascii?Q?HaTfuUPShMBICI9N0Ozcse8ZIq5sV/LQH1H0vKAycXCl5JJFSkYFeI9Ho+9f?=
 =?us-ascii?Q?UGLLJAJoyfvdM2HDDXBmKJspbuKmgq4qpXcrQBFA6XFef+WvBAaMXuDK1OW5?=
 =?us-ascii?Q?tRiprbGACFgfkaV6Qy9c8FOyzNbTOoFl1sYeyzu2BIdZfhuZNc23ZuvOEbG5?=
 =?us-ascii?Q?wVdY8EQfCZoaMQo5dweE9XI80wK1Zh4dK0iBofaOqR4a0zAuzVEbp7koFEmd?=
 =?us-ascii?Q?Lfg8clSSjjnl76fRcElUhX2sYHrvCBLbW6W6ooC4zjvYt1aFEBx2va4zDOTV?=
 =?us-ascii?Q?HmpWCOgfyhEt8Bu7j+Vf+i2cBybgza0tapl+9k/ZIlfQ2leH8n90sBFDLJOl?=
 =?us-ascii?Q?gu2ajWrtP5gwfSknIC9Cqn86onRIUdjjOOZmhfc3ngP17gWPawrt82e2P6t+?=
 =?us-ascii?Q?IBHP4jl2HqKfDJfb6u2wYVBNhBLbLYdYy8914crMWHrOM4rj9vL7OhYSQE/x?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	11oRtOAyUlORqbxuP9oU1lMRtrv3q6XCA4XtrYTOp8r2imxV/tQt+V7OwpmCvofJamKFgs6jaflD9Dm5jlSGTIDuQ+rr1ZYY3O2aNwtKN/Rq1/cr5Bh2wlit+lr/enQCBTC9J5VwzIRg4REZp+RLqqtUYVub5znuWI6AiK4cQ91Fn5Kt+isZo3gp2JVg0qQq7NTQBJWEKSL2eE6/bsiqFfDL+ErDd0r0bF1NuaQ/0YC/Crrm161c1BEnP2FDgGkvA4swQ9gj2pXyolnPwSHkpOATfUchc/3Ygr/ntiJpsV1d7eEWCrbtZDHAe/7FyRZSSThmnS1bSV51YR5HwZZhGa2TrUn6Wd2ZBYbIaC9AXg2Qh/b4/qnaP2SFXoGJEP51ywvfe3GKIEMWLxdf8sTnmnxiIUPYO8c5r37V7KF493HR7bSSbPt/V+c3a4SzCXm+yUb4KDsepRie5LvX/2A6pOOdYsq+3YyHscdsEkORS7NFV/q4kI++Y6Ktf8Wxw88ZNx2NbqAm+D9KGvb103sPB4pmSFAqiyz3CIRDVYMDBrSKhLZySsQgHANE3z1MFgRPh23qcvUro+1F+pRfio3J8UGHAov8RrEtzmqXVxRNUyA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4c7e15-23cb-4bf1-72f2-08dc6e2c89c6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 00:27:54.9497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtgT3TiFXjh+FEOK4Wy4yFFg5Ndaebj7kVV4xaUvwY/uBjPK7aYCQZw61F+FNnFxUqgZOWPyu8ulLMYMpj2bEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6103
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_17,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070001
X-Proofpoint-GUID: 63CgsoFNI7pN6RNxjSHLoORArSjHMZ1Q
X-Proofpoint-ORIG-GUID: 63CgsoFNI7pN6RNxjSHLoORArSjHMZ1Q

On Mon, May 06, 2024 at 04:37:15PM -0700, Dai Ngo wrote:
> 
> On 5/6/24 2:04 PM, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > We've discovered that delivering a CB_OFFLOAD operation can be
> > unreliable in some pretty unremarkable situations,
> 
> Since the fore and back channel use the same connection so I assume
> this is not a connection related problem.

This is totally a connection-related problem. The underlying issue
is that NFSD does not retransmit backchannel requests when the
connection is lost, and the Linux NFS client does not implement
OFFLOAD_STATUS. Neither side right now recovers from connection
loss while a COPY operation is pending.


> Sounds like this is a bug that we should find and fix if possible
> instead of work around it.

I've been looking for a fix for the past several months. The last
fix I put in, you asked me to revert. So, I would prefer to fix
the root cause of this issue, but right now the best we can do is
create a surgical patch that can be backported to LTS kernels, and
keep working on a longer term fix.

It's either temporarily force all COPY operations to become
synchronous, or temporarily drop support for COPY in NFSD. Actually
the latter sounds safer.


> Do you know any scenarios where the CB_OFFLOAD operation is
> unreliable?

Any scenario where the connection is dropped (say, because the
server wants the client to retransmit forechannel requests, or
because of a GSS sequence number window under-run, or because of a
network partition, etc) can potentially result in the loss of a
backchannel operation.

I can reproduce this issue 100% of the time with an NFSv4.2 mount
from a 6.8.7-200.fc39.x86_64 NFS client, using the git regression
suite.


> > and the Linux
> > NFS client does not yet support sending an OFFLOAD_STATUS
> > operation to probe whether an asynchronous COPY operation has
> > finished. On Linux NFS clients, COPY can hang until manually
> > interrupted.
> > 
> > I've tried a couple of remedies, but so far the side-effects are
> > worse than the disease. For now, force COPY operations to be
> > synchronous so that the use of CB_OFFLOAD is avoided entirely.
> > 
> > I have some patches that add an OFFLOAD_STATUS implementation to the
> > Linux NFS client, but that is not likely to fix older clients.
> > 
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >   fs/nfsd/nfs4proc.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> > 
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index ea3cc3e870a7..12722c709cc6 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1807,6 +1807,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >   	__be32 status;
> >   	struct nfsd4_copy *async_copy = NULL;
> > +	/*
> > +	 * Currently, async COPY is not reliable. Force all COPY
> > +	 * requests to be synchronous to avoid client application
> > +	 * hangs waiting for completion.
> > +	 */
> > +	nfsd4_copy_set_sync(copy, true);
> > +
> >   	copy->cp_clp = cstate->clp;
> >   	if (nfsd4_ssc_is_inter(copy)) {
> >   		trace_nfsd_copy_inter(copy);
> > 
> > base-commit: 939cb14d51a150e3c12ef7a8ce0ba04ce6131bd2

-- 
Chuck Lever

