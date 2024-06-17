Return-Path: <linux-nfs+bounces-3932-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB7090B7CB
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 19:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0C61F23F08
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 17:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD3916CD28;
	Mon, 17 Jun 2024 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CJGf10cE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nbM9PVKC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3E5157A41;
	Mon, 17 Jun 2024 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718644936; cv=fail; b=YGVjEWnm/OmfzrFe200K5I+qxwiIIjWFd/1NpK+529zecPjaop8WoxFYiGc+3kIU00Ss3bPiREtw+1cEf88cDsMtRXIZu63gC3Qg+iqtpkQE+WWtihbSSXvCxyOlpIxoATvxY8g7PfbX3yWDfjqBbKpQAFd2mgXm0vBgnp3cPE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718644936; c=relaxed/simple;
	bh=cVjpbWbU3prCq+zTsFtgTDabvkzUaMtzSHo8cAX5oH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QKKwlP89XwWdgliXurDadCRG7kGrH937fFku51HUdIC1/7O8CaQ2W6F2e39MXWujYuT64l1PHZc6bTmVwUoKiQF5jWi/g3lnXUQPiyBOAuC2vrlp0Mfjlf/oESE+ED5H/Y2Vrim6KCj9Df43EYTLQyG+OBpUZcZAVTjTT1OD2tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CJGf10cE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nbM9PVKC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HEBRms005029;
	Mon, 17 Jun 2024 17:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=FT4Dp5Eutk1gjRw
	QRGHpDvuuS6NrARluSA3eKjpJUF0=; b=CJGf10cEjlucmDuu2TPXiXdhgGjvhQk
	R//fuui3j8ztXSP5CBCgmVonGNOWl780CZP/zBPu2mcR4a/0elNaNRpw3pW6PRsI
	MEu8ruba+4S8WlQ7QnJoJmmJ2NjM8GsWq4d6qieG2XLwC/VTYpE1GvbNGncKO5PJ
	n6IPIMKiBtt37QvVmHXcI1TkmOgFUXHpEuwoRw7+GU0ilqCzMmN3hV0BW1ohJ4Lr
	i5lLuntvKM1SnF3KlVNizjV3YQ7hByjGs51k1jJ8y29jtLnNttd0Pt2R1i0KVCsR
	wU+w+Kozk3YH98VTvB1vk8mRaUE/vLupPAol+uzLmYrbcWGBBtzQDyA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys2u8k5fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 17:21:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45HHBkss034741;
	Mon, 17 Jun 2024 17:21:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d70hxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 17:21:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/DFKb7IGP8bc9S0GY5yPVbRod+DKUC5kLZij2eyWBhHS97QsCalpLgJs/V6iT0FR34E8qIIZ1gH8gVtX/4oJfjlwb2L83aLyW8RPsZc3YT/0sk9m9yRdsHZb+oovRphsjL4CUP9cprtfX8N2J2GBT8lUT9AAh64KoJCwex+DlJ32STmwTMAbiyKwjVkJbFyhn8zBZOvXrC4NxrKtmD1ZFqRe1dFInoDXzoqaA555bqhiEjOnZ5/k8y14M4idS6HOBlcK/A9cGPL+HW1F9p9kmHrZ9nX27xhWW0T8g+Hu5+sJVQxRxnrO10K1KAm70TAfpssBhxnsFxOiT5nNKdDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FT4Dp5Eutk1gjRwQRGHpDvuuS6NrARluSA3eKjpJUF0=;
 b=RY7dLC77hFF//UZQm9Nn8ZfW4I6mTUFGS0zp1W4JmqB5wXuDcYtuQV8Ap10+mg2jrplAHTEVihZG6xUtPKG8ytBSGajnWNVPU0IIhtcVsOz+VS2ZCoMESS65e0MiHYEnr+GeMEX/BkYqB4aYur+kgju6paoOHNP4tT3nwKPpFi25uWa5y72BlyQvpBSgoNOXP1ErIhiHni53vIm4TPjtoBxSy9EHT+U7ZqmLKj9E21hKvTy9e5dMA58LmrawuEd1ti61c4LSJveVx8hixJhDajFEk9qb5r4IdGv+/Z/56RvCmUn9pOzDqAxsaMOX8rc6CpS7lz6vf6ldO5nFoGFFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FT4Dp5Eutk1gjRwQRGHpDvuuS6NrARluSA3eKjpJUF0=;
 b=nbM9PVKCts6PFr6y4Exvjs/DeAKTG8Mm2fhXk9CzBDDQyGo4ThBRgDXgwvQhmDof5IIpx3sHyu9AoMQFeDSAiQaw9ngHbHbHPX/86gschtdnSDvSM0Sq8XkkogQV9rtqvwSA/K6ltmc/hQdF2XBkPgXi7d46G138soxH09wCEsQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4315.namprd10.prod.outlook.com (2603:10b6:5:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 17:21:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 17:21:55 +0000
Date: Mon, 17 Jun 2024 13:21:52 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: syzbot <syzbot+4207adf14e7c0981d28d@syzkaller.appspotmail.com>,
        Dai.Ngo@oracle.com, jlayton@kernel.org, kolga@netapp.com,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, neilb@suse.de,
        syzkaller-bugs@googlegroups.com, tom@talpey.com
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_get_doit
Message-ID: <ZnBwsFsj4Lv4isXH@tissot.1015granger.net>
References: <000000000000322bec061aeb58a3@google.com>
 <ZnBjsQazkJK0MyNk@lore-desk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnBjsQazkJK0MyNk@lore-desk>
X-ClientProxiedBy: CH0PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:610:b2::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: 2519e766-99a3-4968-a313-08dc8ef1fc2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qhLgFtGPlB2tN8wbK/JcdHlzJ5RI9iNaf/FEkU9k6J8yGb0xjCe9pPzCi3IC?=
 =?us-ascii?Q?yPM1s/MVj7QEdyzAtgd8jRunduNFwdHw4YL9qBecsFOdNMH03L6YnV/1Ndlw?=
 =?us-ascii?Q?sWU2+IsbH+nj1+RJAFbZlUf1U/dY/VED2hl0lxFHJME/jiChpZL9Z3j4dOru?=
 =?us-ascii?Q?Dz4QQ/XNkh3Fqg5wrNtNrujf/pdbW6z5ukx4qol6O+U7H0uwdWuWvbWRVLAK?=
 =?us-ascii?Q?UafGg8GWmSBKXhOlAMA7V/wQG3iKbN0AnXYWOMLgPIIijFQMiZWYuyfvYxo4?=
 =?us-ascii?Q?e3mCHC7NsPkYmxYWRa5hgrzAFkT4kFKPkuv8r3JaH8T92JPaoWdqjD1PyYI2?=
 =?us-ascii?Q?+S0XmPGBje0awQQmQK+bL33c5GUoe4NCQPwh9nZlYga6qXMx492Dy4Xe+B34?=
 =?us-ascii?Q?YhiAaSGg77RT2Am0VzOUHWcZX2uEABvhldWVOVDy6QTzVN/A7TaRmAl0m/8e?=
 =?us-ascii?Q?HWKoc6q+Hxw8b4rCc8Csnf3ErTU8QmlCn2EDufSDaQAm/rr3KXi7gt9jkXSd?=
 =?us-ascii?Q?5BTFFhWM+OaMeg6ZOxtLwh4clbiHIsMByqkHP5cZEq9gh+kj6zKpzTlEkJuV?=
 =?us-ascii?Q?bQqFS7+FY9SazsWC0SONGRTYTJfdVuCHMb2MyI5ekH/8nqx5A7uGEjjkxgfG?=
 =?us-ascii?Q?7uubNwyvqeFE27b5SUusic+Hg+QGy0RNjo320QcXaveMtwOGObUv7MaUjTqJ?=
 =?us-ascii?Q?qbE+LOgl5aAJUeJ/WGaQvqf/+3d5rBmbgPxpKyjwNhJbQQbyn6Ej1T/zT8PM?=
 =?us-ascii?Q?7N10sFZVE8TV469tFzpMhocmpvw6JlRT9eVMZIUW+x8t5UO+OuYRV6n/uQOy?=
 =?us-ascii?Q?1ZBHgGYJA8cJMcwWMZTzarPavcMgvyNw8XBuvYMBObw6c0XtsZTC/l5TCGVN?=
 =?us-ascii?Q?xIKtCUiF/r4yyeTeKjJN4mBoO/hcXW4gQb4vlUcXtMNB7QDR2YtgO7xdu1NP?=
 =?us-ascii?Q?e6DndrEZnsSkSq5gXhejxG5FvIbLZQq0UacKvMUVd2ko1FlDG6iuPiTMUWlx?=
 =?us-ascii?Q?pcmtU5iyVZLIeZHCrom/iwfLEt6ay3yinV9EDWOyMarGlMyg0kaXxRpIXLsN?=
 =?us-ascii?Q?ZJpVFUetzD1aMTpAbd5ausfyr4uiUwy0aRF8J/3Z5PW7987VvSoXWNeE3yRy?=
 =?us-ascii?Q?OYuOPLbAf1aSgHndibD7CpdeicnKYOQ8jYw5/X+22Q7YwyIju5dcwQe0JSUL?=
 =?us-ascii?Q?dGjIKkvwT2/+MtAMAKjEuRvfl+ABVKHPkWw9Q8Yd+xLrM4MsUkiUFtBenUMJ?=
 =?us-ascii?Q?QDOm0TPnKkxugwEiTeXL?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3U8tSFcRUPCCbUCRUcT6yRlrfS6YcrwJKziW2gp23Cu7W+DRe4T/+Yt0dyAN?=
 =?us-ascii?Q?SwSSjPQI6ov9lpLefGFjEeGbER383YUtW9fs2N7O9dLeOnFfaY5tbBcESgmt?=
 =?us-ascii?Q?2Esw7bvA23iyu3kZhuz1YVg+hV3M66r4uPNLPZglS4FTKTf1tO12c1VJpCvA?=
 =?us-ascii?Q?YGWyT8C+NIUL75lKGo5XtN+dgSUB0Gr7rkLMPAB3jqyTx3SO9yok7cuMPCBN?=
 =?us-ascii?Q?/+Yp1cPDmG3sQgWjuhwTcmktLyCJmzRCpUFrVFPrTUOpPhcDStPHRUX/s9TA?=
 =?us-ascii?Q?JgfHgwGUHllx5BwOH0iBZWQdE+FJ8a1YH9MsFTuRpgwL/k41ywGBYq3sCYfz?=
 =?us-ascii?Q?8wRohNDLQwezoDaQol6FuBKfrElxZSqochx91pCaDkSf4hZEGAez+4UkcyEo?=
 =?us-ascii?Q?trywB3BXiNb9SKofHq6o43tHAEln+feiK9nA4WJykqL+FeRcoZ7IXQNxKd2y?=
 =?us-ascii?Q?jm1KDdynp0Kp4xEWhZmzX0XzeOWIkWzas7RttMVgcZYfBT8FW2mOk1vTS2s8?=
 =?us-ascii?Q?933lYRl6fplzu0z4olmeXEWMJycPVGhhU2Jy0CTGxl0J3HqcHXJArhXBhOiN?=
 =?us-ascii?Q?llX4D9++yyR6Y3XeCpi1yvTsM7cw/EJ7d5dGigUsHJvrPhCtprOpuU3JCmp0?=
 =?us-ascii?Q?J4GohAU9pIf6mfoy7CryJTFGba+gDA7fC4/elQVYik1Y2k+U+9G63WJ+nBBK?=
 =?us-ascii?Q?QPqdZhQIZobQDfPF1KuOdpBHv6TLDx+565m9yNzWt/HpWe/PI+bGnH2rewTs?=
 =?us-ascii?Q?sDDVacEWZOc2DRIGh5S+JfoBwfLh0fU2F4QlPCP/1SW+6rjICnoK816oZAeF?=
 =?us-ascii?Q?yEStOycz081XLAunG3EmSXuGrDU8npsgJsrOJFwB8EiN0M5ITA+k7Xomi8i2?=
 =?us-ascii?Q?XpM8F5qzS45JCU8syPFLdk+MsWokUXyW8ksHmFUVpY7w2O3d1ICWQ/0kUpLd?=
 =?us-ascii?Q?gXWLhnSeNr2J8pR2bvH+XpCInVRIgcyy5aQ1FbkX1aAtsT0S+ERQc7/3KwSd?=
 =?us-ascii?Q?A50WCrzVkPF26X1xfXQIJdqapJowhFMfIx4ijkC9KgLuEfPlK/DTKRs1NtxO?=
 =?us-ascii?Q?vpT+Y/bY1i9RP/3aclSu6p2nArn0fOrfdgX3Lg6JFyO8rAaWhitTIDeVHLCh?=
 =?us-ascii?Q?8voY3snj4UiTFY3i5xcsf6olYUjyQK7hsPEoOadAWRZS40ZmzRH/UlrKYEzo?=
 =?us-ascii?Q?X8mi9KykW6kti2VozSiH6ErB+UbHMAuH0NFijLfWR2+ChhTHK69T6Ci3vLtU?=
 =?us-ascii?Q?rtU4YKG+skDMU1fLkWekFSWr/utHIlEmxJd07i59Xv/Wx6X+ImScvl9sIBSf?=
 =?us-ascii?Q?uR2JmhtTw+OoyW8X0drBrJ1H8Z0m4fmOsszoYnrIUuA6XWM47oREY7nun2ZR?=
 =?us-ascii?Q?8coBBZnl7EY31K6e0q2VPFq/ShucBJ/sAIYQHnpXOGucrtwdGJGHvHM4X2Q/?=
 =?us-ascii?Q?Lefnz3HVILLQqv4jQsJEUHASP9blWlQH4t5Dqq0Nd4cctS15Tw3VZ2ZEVH7m?=
 =?us-ascii?Q?36CRKFzut8YeJpzmEU4p6iBFZOBogaJ4UKqSiewXE/HFxbLJ/eoST9Xwzycv?=
 =?us-ascii?Q?HmAggNL3QS0XkpbBIHPUiztgXd34FZ72cA300PYk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TeuArr6pPLhSfmLsQ2k0HHbpkWTpoOAr2urZGv6o4sL+ePXG3gWCnJ9qqSHXLJJmYZTW6FzGWfohhHppb2M0f2EI0yjgM93ecb5j3h0KSlEHPE/E35NysZaMpCkIuaMHE/YErOymKQP1Ae6wA/wExtCxsJgkgdKU6rtRr6D6koWX+Y9Kr/namgPBu84+pF/je5NHfeFLcQfI7Lw/hICz0wYh9tIqM1pVyug6bFY6RMu/KfuqHyIK0aCNJ+d1JBrxkxdBeZ/WjF8q/+h2sA4axelv2m9jgbbj4D/r6NbygQ+KhO+L+li3N+hYw6hscHtmrMCidG8IrLE0Y4jaEOTAC6savB5/FOtISoO6ooQml29lE/Y8wHqAAnAjjfG734doOXX+X7my3EFXCCGRG/Tps2pMnD21pZ4VqrIu1QXsuOS9sYaszJm43jfAi2BGld31LIfnUr/F06e3wWYmvQIv0QIoMuDg+JyU3hCVfxkV7WJR+qXiZrO0P3ZoN5zdtGmQ99W3jB3lYZrlbMtKDluoPy3hJ6Hmx68tRM5nfkIfoORcRhzkx9voqgj+/bgoxBMZij9I4XdeKug5DWJh57EsJC7/troljs8YhWEaIx3TMx8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2519e766-99a3-4968-a313-08dc8ef1fc2e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 17:21:55.0248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bElIeYuBz5naBcIDWrnAV9TbvOfAncU6iyHwbkP/OMk1Qemxrxru7g5ldlGvSve6wEgHafyCPBiois8wWA4/2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4315
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406170134
X-Proofpoint-GUID: PnXNrkJE0S7zcwhRnM5yuRpQoPqk7W5i
X-Proofpoint-ORIG-GUID: PnXNrkJE0S7zcwhRnM5yuRpQoPqk7W5i

On Mon, Jun 17, 2024 at 06:26:25PM +0200, Lorenzo Bianconi wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    cea2a26553ac mailmap: Add my outdated addresses to the map..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=169fd8ee980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0ce06dcc735711
> > dashboard link: https://syzkaller.appspot.com/bug?extid=4207adf14e7c0981d28d
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/1f7ce933512f/disk-cea2a265.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/0ce3b9940616/vmlinux-cea2a265.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/19e24094ea37/bzImage-cea2a265.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+4207adf14e7c0981d28d@syzkaller.appspotmail.com
> > 
> > INFO: task syz-executor.1:17770 blocked for more than 143 seconds.
> >       Not tainted 6.10.0-rc3-syzkaller-00022-gcea2a26553ac #0
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > task:syz-executor.1  state:D stack:23800 pid:17770 tgid:17767 ppid:11381  flags:0x00000006
> > Call Trace:
> >  <TASK>
> >  context_switch kernel/sched/core.c:5408 [inline]
> >  __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
> >  __schedule_loop kernel/sched/core.c:6822 [inline]
> >  schedule+0x14b/0x320 kernel/sched/core.c:6837
> >  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
> >  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
> >  __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
> >  nfsd_nl_listener_get_doit+0x115/0x5d0 fs/nfsd/nfsctl.c:2124
> >  genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
> >  genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
> >  genl_rcv_msg+0xb16/0xec0 net/netlink/genetlink.c:1210
> >  netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2564
> >  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
> >  netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
> >  netlink_unicast+0x7ec/0x980 net/netlink/af_netlink.c:1361
> >  netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
> >  sock_sendmsg_nosec net/socket.c:730 [inline]
> >  __sock_sendmsg+0x223/0x270 net/socket.c:745
> >  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
> >  ___sys_sendmsg net/socket.c:2639 [inline]
> >  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f24ed27cea9
> > RSP: 002b:00007f24ee0080c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> > RAX: ffffffffffffffda RBX: 00007f24ed3b3f80 RCX: 00007f24ed27cea9
> > RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000005
> > RBP: 00007f24ed2ebff4 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > 
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> > 
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> > 
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> > 
> > If you want to undo deduplication, reply with:
> > #syz undup
> > 
> 
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git 4ddfda417a50
> 
> From be9676fba16c0b8769c3b6094f35da39b1ba3953 Mon Sep 17 00:00:00 2001
> Message-ID: <be9676fba16c0b8769c3b6094f35da39b1ba3953.1718640518.git.lorenzo@kernel.org>
> From: Lorenzo Bianconi <lorenzo@kernel.org>
> Date: Mon, 17 Jun 2024 16:26:26 +0200
> Subject: [PATCH] NFSD: grab nfsd_mutex in nfsd_nl_rpc_status_get_dumpit()
> 
> Grab nfsd_mutex lock in nfsd_nl_rpc_status_get_dumpit routine and remove
> nfsd_nl_rpc_status_get_start() and nfsd_nl_rpc_status_get_done(). This
> patch fix the syzbot log reported below:
> 
> INFO: task syz-executor.1:17770 blocked for more than 143 seconds.
>       Not tainted 6.10.0-rc3-syzkaller-00022-gcea2a26553ac #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.1  state:D stack:23800 pid:17770 tgid:17767 ppid:11381  flags:0x00000006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5408 [inline]
>  __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
>  __schedule_loop kernel/sched/core.c:6822 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6837
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
>  nfsd_nl_listener_get_doit+0x115/0x5d0 fs/nfsd/nfsctl.c:2124
>  genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
>  genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>  genl_rcv_msg+0xb16/0xec0 net/netlink/genetlink.c:1210
>  netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2564
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>  netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>  netlink_unicast+0x7ec/0x980 net/netlink/af_netlink.c:1361
>  netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x223/0x270 net/socket.c:745
>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
>  ___sys_sendmsg net/socket.c:2639 [inline]
>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f24ed27cea9
> RSP: 002b:00007f24ee0080c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f24ed3b3f80 RCX: 00007f24ed27cea9
> RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000005
> RBP: 00007f24ed2ebff4 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> 
> Fixes: 1bd773b4f0c9 ("nfsd: hold nfsd_mutex across entire netlink operation")
> Fixes: bd9d6a3efa97 ("NFSD: add rpc_status netlink support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/netlink/specs/nfsd.yaml |  2 --
>  fs/nfsd/netlink.c                     |  2 --
>  fs/nfsd/netlink.h                     |  3 --
>  fs/nfsd/nfsctl.c                      | 48 ++++++---------------------
>  4 files changed, 11 insertions(+), 44 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
> index 5a98e5a06c68..c87658114852 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -132,8 +132,6 @@ operations:
>        doc: dump pending nfsd rpc
>        attribute-set: rpc-status
>        dump:
> -        pre: nfsd-nl-rpc-status-get-start
> -        post: nfsd-nl-rpc-status-get-done
>          reply:
>            attributes:
>              - xid
> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 137701153c9e..ca54aa583530 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -49,9 +49,7 @@ static const struct nla_policy nfsd_pool_mode_set_nl_policy[NFSD_A_POOL_MODE_MOD
>  static const struct genl_split_ops nfsd_nl_ops[] = {
>  	{
>  		.cmd	= NFSD_CMD_RPC_STATUS_GET,
> -		.start	= nfsd_nl_rpc_status_get_start,
>  		.dumpit	= nfsd_nl_rpc_status_get_dumpit,
> -		.done	= nfsd_nl_rpc_status_get_done,
>  		.flags	= GENL_CMD_CAP_DUMP,
>  	},
>  	{
> diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> index 9459547de04e..8eb903f24c41 100644
> --- a/fs/nfsd/netlink.h
> +++ b/fs/nfsd/netlink.h
> @@ -15,9 +15,6 @@
>  extern const struct nla_policy nfsd_sock_nl_policy[NFSD_A_SOCK_TRANSPORT_NAME + 1];
>  extern const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1];
>  
> -int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb);
> -int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
> -
>  int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>  				  struct netlink_callback *cb);
>  int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info);
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index e5d2cc74ef77..78091a73b33b 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1468,28 +1468,6 @@ static int create_proc_exports_entry(void)
>  
>  unsigned int nfsd_net_id;
>  
> -/**
> - * nfsd_nl_rpc_status_get_start - Prepare rpc_status_get dumpit
> - * @cb: netlink metadata and command arguments
> - *
> - * Return values:
> - *   %0: The rpc_status_get command may proceed
> - *   %-ENODEV: There is no NFSD running in this namespace
> - */
> -int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb)
> -{
> -	struct nfsd_net *nn = net_generic(sock_net(cb->skb->sk), nfsd_net_id);
> -	int ret = -ENODEV;
> -
> -	mutex_lock(&nfsd_mutex);
> -	if (nn->nfsd_serv)
> -		ret = 0;
> -	else
> -		mutex_unlock(&nfsd_mutex);
> -
> -	return ret;
> -}
> -
>  static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
>  					    struct netlink_callback *cb,
>  					    struct nfsd_genl_rqstp *rqstp)
> @@ -1566,8 +1544,16 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
>  int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>  				  struct netlink_callback *cb)
>  {
> -	struct nfsd_net *nn = net_generic(sock_net(skb->sk), nfsd_net_id);
>  	int i, ret, rqstp_index = 0;
> +	struct nfsd_net *nn;
> +
> +	mutex_lock(&nfsd_mutex);
> +
> +	nn = net_generic(sock_net(skb->sk), nfsd_net_id);
> +	if (!nn->nfsd_serv) {
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
>  
>  	rcu_read_lock();
>  
> @@ -1644,22 +1630,10 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>  	ret = skb->len;
>  out:
>  	rcu_read_unlock();
> -
> -	return ret;
> -}
> -
> -/**
> - * nfsd_nl_rpc_status_get_done - rpc_status_get dumpit post-processing
> - * @cb: netlink metadata and command arguments
> - *
> - * Return values:
> - *   %0: Success
> - */
> -int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
> -{
> +out_unlock:
>  	mutex_unlock(&nfsd_mutex);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  /**
> -- 
> 2.45.1
> 
> 

Applied to nfsd-fixes (for v6.10-rc). Thanks!



-- 
Chuck Lever

