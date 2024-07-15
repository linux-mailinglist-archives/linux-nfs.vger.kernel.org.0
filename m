Return-Path: <linux-nfs+bounces-4926-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFC89316E9
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 16:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0FB1C20F10
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 14:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CA618C199;
	Mon, 15 Jul 2024 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vm3sExLx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KyaQGeB/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D06433B3;
	Mon, 15 Jul 2024 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054237; cv=fail; b=XdxZX6AwpUzZhbWAZKBF7ydUKOVi87OjpLhmTfCuXmYWjsHLnHmAvzusrNEreUDoHujJDES6mKwtWwy+zsQ6MGxpCqs6VLintV37FAvxlDCBQnlz6iykf1LM6+ECkaaak9NPSWtEUzOBJ6IV2ouGDUI3NB5fb9Hll+MBibYaiXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054237; c=relaxed/simple;
	bh=0Xl1EbP0fYLL14UC/6qkrQe/lIkYJ/yotFx/IW6/KyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=U+eqT7MDHrnbhT+Hl1ezVnq15y+9ph/hvLe0/VNACojG9h1mOpbOe4S0QaZG58uamRq9IzcZTlntet9mulpeW4X6r9DeLD/4wGZmVn4RFxxqNymso7H1a2V0SKXKWHasxht/GxDadGwE6bV4Qvnj4cfTIXQguTxW3VVaIXjIsZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vm3sExLx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KyaQGeB/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FENseR015185;
	Mon, 15 Jul 2024 14:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:content-type:mime-version; s=
	corp-2023-11-20; bh=fC0d1kTZsMWmqaI3ARr6FOElmWVeQyXHtsqzyBy88Mw=; b=
	Vm3sExLx9S89nCWk9gpbnM/juhNJza6vxUUttI8jbJiMBwRQW7mWzh/mi6KL4O6K
	/TgtrKE4jDSuwX+7StaiZvNQCCxqyVDCtDUkAHQA9vR+S7Ep07LBg4sfh79IWQBx
	LVSey5l62O67lSsoIuo8fMUx6xej+DycqDL6Kgw5h/Z/KSHU3OuMtM/piELmc+gr
	/QVJ0RGSQl8WCJ5hrxH3oMhKA6rU8uWUHSeqFHFGlSOvM9UE5ZvDdclpRl5ZZcMk
	t9WcscrYQzIaiAznB0hDcx3GWDSPQN7yrBrE8QeXdSvhK50uwhdJHAFTrnwCeY5j
	20SL76+vMKU6nonAta4TKA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bg613h2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 14:37:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46FDNlLY038983;
	Mon, 15 Jul 2024 14:37:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40bg17nucw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 14:37:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uovwRCcwn8DrKaQ+qqpad/0zbPhJ9WlazaI7xdjfXwzVYH31yEwV+9daOFjSP/r6ZzenGKsGRvfmYNXlZgVyJZKxVbhgC8WMJhtT1eGJeVpdaTMAT7ppeKg7xiuWkVess6CTsw59uGuX+dOqQJvh4Tk6/y0uq7PQijK0yQaADcGtakHEjk1PU6V2tpnc3v5qeGeZv0JmK2yRuPK3OF6nbBSeKd6bwBN/zzMm/ydQeeVIoLRwxSVy5egLc4Auu2qxQDgqyy4rZYSjyX8uPRR5rav8vZDJ0jRzPEZvLzxxScVvliG11cRg8klgRhEkqtCDaxNLSETg0UhNK9o/39bj4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fC0d1kTZsMWmqaI3ARr6FOElmWVeQyXHtsqzyBy88Mw=;
 b=FlwT5BberJcnCnlPEwD2csUGis63tROc/AcB9VugnSgRslRPtnNRz3r99+/uxQBdk4tDMxkGHE7/iWEYH2EtR5n1Omi+s4vzqa8yA2JQJGrPQGVK6xTcSlTkrb+gHAf5O9ojy5fyABz315N7FZ2yPlP0VaBG9jJ2lPBXfdYw6bmTf0p6Da69irY7ghg4P/NZRn7rvrzz2Y/S/lzGcUN4qeEgLntJU576Pnw1w09snQ5MgPAx6OejnaTW46XxAy/T+zZdr7sgkxQjW2INs7fe5tZf99kEZa6+2IjbeU+RrRmm+Y9TxnBU2QpHoSHZq0s8tTgiK4Gt1hgHp352EMe5aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fC0d1kTZsMWmqaI3ARr6FOElmWVeQyXHtsqzyBy88Mw=;
 b=KyaQGeB/OxOPK1Y8xqjVBlltOgcy9lhNq8BiotN6STcPNX3b3KAnrBNL26kn906bzKHet9FYrpP9Mx6+X67D5iPHs2Ss98BRoQfx/0ygni1gUP0UVjTKyDSuGShpNAZ46Oy4E564Jx+BqnKdgcjfOKAsXyDwubmm2i4sUcnPS0A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB7443.namprd10.prod.outlook.com (2603:10b6:208:46f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 14:37:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 14:37:08 +0000
Date: Mon, 15 Jul 2024 10:37:05 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] NFSD changes for v6.11
Message-ID: <ZpU0EWtsVcy+J3DO@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH2PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:610:52::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN6PR10MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: e623b148-3bb7-4772-7310-08dca4db9afd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jIdJcHXlocsvdLu/FbyyVwY0dDMJmBfUnvGlN7mi49I900tj3fGXf39tCAeU?=
 =?us-ascii?Q?i0zdhQRVwwPHwS6l0u+3J3Qek0U3JHcZzAXOM1S6P4D5TpAz2vRQOZx7F0uJ?=
 =?us-ascii?Q?q14GX0Va3nUgYUHmSony1lo0yiwrCJk8nExQu7685GCwrwjTwurEvvId1TuK?=
 =?us-ascii?Q?1aAxs264iHaNW7H1mQNClvF1pFBF67WUkl1hK8nDdyjPrNH7q86SiO/zVNRb?=
 =?us-ascii?Q?Tr2Jc3nFY3KKTKeXILjVm3CG33Z+g9Guven6/YIas66HGY00/K52zVtF89D0?=
 =?us-ascii?Q?p+bOiLFbsUnYjPggBnzJmaq/f9psybZukBMlTRmkTEHCXMS1bz9QP1wFuVxO?=
 =?us-ascii?Q?6lRE+7ul0Fc5rG9tjIynlAmHEPDa1Q1l5uux5OjCPmLn/DNl+7/QrpGVFzSO?=
 =?us-ascii?Q?22FF9/Bdtk3rZoWYLfw1FMJ2ucrMFxhrsTgowrgK+CM6FwSYprGJmpl0rkti?=
 =?us-ascii?Q?CqKP6qy22Tfs/NQpjuER/+WJ1SOw09pnvXzQQrQHhVVPYYCzN2yJS+gsN7Td?=
 =?us-ascii?Q?RpQqrAxvG0bxyntaYRswCVIb91XFJghBe7Gbvlr5HlJmTJlcp4e4u2NAXFa7?=
 =?us-ascii?Q?GMK/FjN1OKqvo9l5tNUFZODkKRCTRziHVICj6FOY1/mXpHoV/4o/4iGrRPfc?=
 =?us-ascii?Q?bIp52mRQKSVUe2QAtFPUbPt1pRZILTV9z7/Jq7BntvWn3VgGsUi8iRQpRzE8?=
 =?us-ascii?Q?D/5lSsaT7aoUxqjpI1Q0OHDlJ1em81qE3IuhOlwSB+MY4y7KpGIsn8Bu51Pq?=
 =?us-ascii?Q?UZF6C+R4Yzc70k9Y6xyzeGWldCCV/vQhlfZvpjz7+OF7RAIozRk32fifdM88?=
 =?us-ascii?Q?djq/2vuwljMZoB05Zje9cSNcxZVuHxzYyXLL+37qeVAOcEmIm3ZlVB6QEUud?=
 =?us-ascii?Q?wbLwNpK5Dqjg6IlA9xvCuAUEfQ0hnqvld5HPDpPiFVRqxjENep/u/ZTAPZl7?=
 =?us-ascii?Q?wNMQiZ2VT8K718A45Rhp6DQ1g75BezEhA+jqS44cJrHZc8YWMdf5ZW8ybMn6?=
 =?us-ascii?Q?TBFPzossMAZyegO5BR6ncNdke0T3kHOG3ghdqarfBM26yLqcFMzuLtbgdF5p?=
 =?us-ascii?Q?osqDS7Q7X1r2VnkAMHm7T4LtbAEmUz1lKSSCnn+Ibz7ptoyYkHVfUBv9K+hQ?=
 =?us-ascii?Q?QbKlQh/T2aXACoHNBO61J03qadGlPfKXSOsaZCeKN18Ebo/LwVYr0xYH0n66?=
 =?us-ascii?Q?jDOmE76lym1tFcdfUgRjGDfdAvvKfRVwpWpc1Z1yMO9lzYvTsmRKCVeaqL+W?=
 =?us-ascii?Q?rFYKQY6f2yFPHGUkJjFMZ/8gJBa5sQ3pke1Qi7DfK0K5RqakdSmyWZJ05srH?=
 =?us-ascii?Q?O1s=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6GHGQgdR+Ig61LMohTSbFdI17WqsUVjngGc078y4Or2OfdyHGbnzP2g66JBH?=
 =?us-ascii?Q?0q9zuhXDGufYbyAfvfFcpYQCJJXq6cQvcjBSC+4BLsyPJ31PsTxx2FTfasjB?=
 =?us-ascii?Q?QzrTlv7pgLg/xowTGPHM6XojF4EKWn764Z+IijbiuDuL7hzoOKQ/Ab/24eBw?=
 =?us-ascii?Q?3X96cgKG0z4GlYjEqGGQ9P6oKCmi/+97MPJsUP13drg+PNpzt/DMqPJ2mBX/?=
 =?us-ascii?Q?NZMcqjdfkmuEgHRdieyETtrm1bwNf1IibeBlPQ3HEc6v+Sub0gpR5U1Iq5wD?=
 =?us-ascii?Q?K6//5J9hyBORrWgrlWHvGkGfIgfWX8+L0/fem1Sypqs21ucqF9MVL+piM5hH?=
 =?us-ascii?Q?tWRVwRYt2gGilFlRFHTUeYY/J0eJ3midkVeoojuOFiRtdyakmHG08rrEJWHj?=
 =?us-ascii?Q?i3ivcDCVtZgVONcjWn2mlOzcRzAvsB21CL4+bT+jJKFGMaSM3Cmzy1tt35AB?=
 =?us-ascii?Q?ixkxijntx+q3CVMgpg2XSYfumm8gx1f+iMT39jXXVyJd8gi745pSzHiIDzUv?=
 =?us-ascii?Q?arUOotFMqPn71Q+UXAb7CLTlvFXYdXa5apMeIL/9R2K25g7tKnQflRGMFDLE?=
 =?us-ascii?Q?HIoosk4vbLlg7efQS0G4GZjTVqowDxVt1srkdkXwW+t93XeRX6D/SzL+GMke?=
 =?us-ascii?Q?iFg8JXykvKwSsXSimrzaH+566BbNQZ/rtqHujYbVJm54wvTpLcdtrN3T+8YA?=
 =?us-ascii?Q?3hOWzYOK/0WV9YYHOMNSa2qYkJJ0gHCF/PmFUDn83HmVG6IlggeYLW5bdSlg?=
 =?us-ascii?Q?dTOkuPzDZ4XKRkriSVt3IAqZomt0I0NIvXDdgJuHH+PR8kFlMzvkD/t7zeLv?=
 =?us-ascii?Q?NFURXv8V1ggH5v6ZsJvWT/lX1BNVN5kvd+EmMr5uJcaOxt054ct7OOYpNAF4?=
 =?us-ascii?Q?yUD1hVqMql+Aj7/ufFtlf0oeSJdFWnivtat4BpHur+4NSO4FG9Rv855WsIz8?=
 =?us-ascii?Q?aohPoUCEvK/OopjVIsG0M/Jz3xZNygs/IJWbVqiRNFruou95+ixMnmT6xgVJ?=
 =?us-ascii?Q?6uMOPkob3S0oBaVN2hqJ6UEZTy5xkcSs4Fbq07yJjoKu6wq1I2XK2BJTRgco?=
 =?us-ascii?Q?AgVzy0fu2M3zLYr2iocGlyt6XHoDUz5tiwND1+jvle4kRSTfHQMZVmo4IwEl?=
 =?us-ascii?Q?VUgsn/fLgJMlxTeQUygZywJmZirMm9ZG/v2oWmfb/1NVqMAIvb+pLpSut1Xi?=
 =?us-ascii?Q?hJ5t8tyvxOYFha3Dw8YPv6npLOtFn9fqhqY22vchsDnqcQzwNqo/x0VL+yoq?=
 =?us-ascii?Q?jkU1mmWFiOvwrdXuC3M03Shr21iR0xZ1iBd4FUQKWZMwpKwfdaQJ9NMeJqf8?=
 =?us-ascii?Q?P5Gzhk7seIem1FWBFtkkSw0iF9AOcsTwJRXoNFkAUb4CzXnTa293VUZziuoD?=
 =?us-ascii?Q?1mlysXFqpUdEnmu0wlIVok4eNMRA5VKVDsZnEFdEKlC9WeFOsef3uHwc0gPT?=
 =?us-ascii?Q?gk8C7sn57+hpcR0QgIKvAItVIy9fKOG3IhIxwgUOF9Lr+Lhl99YqNKcmQlS9?=
 =?us-ascii?Q?Ph+L7I9FZTdVRz7facORogRSP/MMNiGA2OH7LaCmL/TQpY6NxcUObOOpCvtB?=
 =?us-ascii?Q?Cz0V11m+IkbxGlr94zAZV9vYAhfFlwPHJm2ixSu/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	V/whBs0DqDsWbwqf7lu4LH+Q8WoUmBO8mJfWaHu2hEq9ahPparaUDf6Uu19MWIpzIROD64JgG5sO7EmJXY+8b2TeZYlC/m6z9fM2kw5MPqDRZuX52B0kUZJ8ARJU00WK9x1hjIVwJc6WU6D1AvIwPOufJIxCychykc4vcd+Tf4HHi99ptXwYbNJNN452TdJ8CFjZPUFhXK/f3FmskHUgGUwH9RVFEit6iGyoYgexqq+ESBkoJ+E8WxbyQKOTe3yBW46BDtfIOSzlaxdJwULtIR49WwZLUlugFxKGCcpdzmq6d+G3f8q37g8+0YtDElxowMfRxS2kKfeMLCIdu9w30/kxkefrXWsE4/P8Y/VGr9gd07utTJM0byIN1InXHcZoJgpXOcn+u5V6hMVIXiLo30tpKTCXTicA0OvmZ1cbZLQa/53Qrkdb2XfXi9JftRabsfLTfFrnzAHTHXrWusX1UgGzQx1ShLvZQsgM1E4dtJ5XPuAD7+rg2Dtf89ikBnOLZZGI/9wPSdVhmoS+RPJSq/yt0I2NkQ1ycNxxV4dRoqEZvKAZqI0Q181+/jktgmMJLThf0oJGDbtOXIRwu+dGDMY2vdqUhBz7gni+ri3lAzU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e623b148-3bb7-4772-7310-08dca4db9afd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:37:08.5897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHWPvbcRftkaUvdckKWVNjaz95AyGITQ1Xu4wRDEsFaHaF4eN5xN0aZrPY840xVtRYXv2lvYmcxe3/2w+kCmHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7443
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407150115
X-Proofpoint-GUID: bczQTkYI3C1vd_2t9ZeehVhHGh9uPNnM
X-Proofpoint-ORIG-GUID: bczQTkYI3C1vd_2t9ZeehVhHGh9uPNnM

The following changes since commit 256abd8e550ce977b728be79a74e1729438b4948:

  Linux 6.10-rc7 (2024-07-07 14:23:46 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.11

for you to fetch changes up to 769d20028f45a4f442cfe558a32faba357a7f5e2:

  nfsd: nfsd_file_lease_notifier_call gets a file_lease as an argument (2024-07-12 12:58:48 -0400)

----------------------------------------------------------------
NFSD 6.11 Release Notes

This is a light release containing optimizations, code clean-ups,
and minor bug fixes. This development cycle focused on work outside
of upstream kernel development:

1. Continuing to build upstream CI for NFSD based on kdevops
2. Continuing to focus on the quality of NFSD in LTS kernels
3. Participation in IETF nfsv4 WG discussions about NFSv4 ACLs,
   directory delegation, and NFSv4.2 COPY offload

Notable features in v6.11 that were not pulled through the NFSD tree
include NFS server-side support for the new pNFS NVMe layout type
[RFC9561]. Functional testing for pNFS block layouts like this one
has been introduced to our kdevops CI harness. Work on improving
the resolution of file attribute time stamps in local filesystems
is also ongoing tree-wide.

As always I am grateful to NFSD contributors, reviewers, testers,
and bug reporters who participated during this cycle.

----------------------------------------------------------------
Andy Shevchenko (1):
      lockd: Use *-y instead of *-objs in Makefile

Chuck Lever (6):
      svcrdma: Refactor the creation of listener CMA ID
      svcrdma: Handle ADDR_CHANGE CM event properly
      NFSD: Fix nfsdcld warning
      NFSD: Support write delegations in LAYOUTGET
      SUNRPC: Add a trace point in svc_xprt_deferred_close
      MAINTAINERS: Add a bugzilla link for NFSD

Dan Carpenter (1):
      NFSD: harden svcxdr_dupstr() and svcxdr_tmpalloc() against integer overflows

Dr. David Alan Gilbert (1):
      NFSD: remove unused structs 'nfsd3_voidargs'

Gaosheng Cui (1):
      gss_krb5: Fix the error handling path for crypto_sync_skcipher_setkey

Jeff Layton (6):
      sunrpc: fix up the special handling of sv_nrpools == 1
      nfsd: make nfsd_svc take an array of thread counts
      nfsd: allow passing in array of thread counts via netlink
      sunrpc: refactor pool_mode setting code
      nfsd: new netlink ops to get/set server pool_mode
      nfsd: nfsd_file_lease_notifier_call gets a file_lease as an argument

 Documentation/netlink/specs/nfsd.yaml    |  27 +++++++++++++++++++++++++++
 MAINTAINERS                              |   2 +-
 fs/lockd/Makefile                        |   9 ++++-----
 fs/nfsd/Kconfig                          |   2 +-
 fs/nfsd/filecache.c                      |   2 +-
 fs/nfsd/netlink.c                        |  17 +++++++++++++++++
 fs/nfsd/netlink.h                        |   2 ++
 fs/nfsd/nfs2acl.c                        |   2 --
 fs/nfsd/nfs3acl.c                        |   2 --
 fs/nfsd/nfs4proc.c                       |   5 +++--
 fs/nfsd/nfs4recover.c                    |   4 ++--
 fs/nfsd/nfs4xdr.c                        |  12 ++++++------
 fs/nfsd/nfsctl.c                         |  99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 fs/nfsd/nfsd.h                           |   3 ++-
 fs/nfsd/nfssvc.c                         |  66 ++++++++++++++++++++++++++++++++++++++++++++----------------------
 include/linux/sunrpc/svc.h               |   3 +++
 include/uapi/linux/nfsd_netlink.h        |  10 ++++++++++
 net/sunrpc/auth_gss/gss_krb5_keys.c      |   2 +-
 net/sunrpc/svc.c                         | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------
 net/sunrpc/svc_xprt.c                    |   1 +
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------
 21 files changed, 337 insertions(+), 127 deletions(-)

-- 
Chuck Lever

