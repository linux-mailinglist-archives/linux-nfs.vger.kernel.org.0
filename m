Return-Path: <linux-nfs+bounces-6186-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AA596C054
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2024 16:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C08A28EE0A
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2024 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3036E1DFE15;
	Wed,  4 Sep 2024 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fi+5RyCk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zhEStZ9K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2051DC062;
	Wed,  4 Sep 2024 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459837; cv=fail; b=e9N9+tK6G/a/QFmBrAvXrR2XOw+E1gDAZT3hBnjOhuJYnlkQW7IQRzQpdYHf4ONu0sWWWx20Kl8SxW26oHW2okCFNLzPlEMohglTFH3ZURkzAtDvpQRSLSL2kv7T2GSEJzkkm2VrGSVGm4qd7sEn0lrp3iTicXtdURn39sGlpGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459837; c=relaxed/simple;
	bh=/cWLsz+0wtVTg0g+ozCH1IRiYx535eu3pMqgVDdiKn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tK6+hOGdot83M5HDQjHSTTHcKvHVQ0xDh2fCoQYwsj6TBHe05yCdOQO+tOlu7LiPJtOLh2yrrGSy7SthrbheG5RezZmyBHSumUp2wypEq0jsw80AvDVDOKmZy8919KtCSqiZYV/Fs0U9sIo8M1PzDxFik+/DVn8T6OParF99xcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fi+5RyCk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zhEStZ9K; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484DXVpA019468;
	Wed, 4 Sep 2024 14:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=d0MbaGNS1X/EoN8
	pALmS3rTacY0PzU0/FsUnjgOejww=; b=Fi+5RyCkmUR7vKu2T281WAq72VjjGj/
	dKzUJxscsNMqShF0SheZfBphmyjMFciP/L0okmGAjp42slvKiegUaWXX09mJHOzi
	nn3Wte7pMKyN5Eyn6aLpxCjVALvv3pXNTX1mL8p2JKtGgnOB8rzXN2FNECSVAyNX
	NI09yI0qZp4r/eVZroxsjXNMUqxJXgasRAd412hf1c4NribhTI1QqzakE01Sj+WL
	LByJHMQy9TxyEUESfNjsn0wQnAffRml76Br7DFzx6lN9ny4NYwy8x4wjHYu3aS+F
	nvH3K49HTEOycN4xyalcgBpcyGxyaySckBbXCM7CjutoJ7WuAy5CHFw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dvu7bjhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 14:23:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 484DTv47032666;
	Wed, 4 Sep 2024 14:23:41 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmae5wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 14:23:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZP7a1LV6rZkh9bJqlojogYZAC/LopvFJ2TCfSlA2CcXgO6IOlBdkuDwWpSuKWvWks6czJBPXYZIh3vBoQMuNFPVWcP8aIjEfXVLUgSUoCEE9SQAWuCXsH9GvJfFOUhTonyxRj5+9JwacMDyPvkqaffg3/uTIo6fOMz0eQTrpHWHafugbjTu4ywpEZUFEPnx72kI2tGkWbDuw201FioCTB767G6B8LN91I/tMTr7+Rzcw55dRbcTY0kn2mrMyWFqn9K655aedClxZ+WQteDHOamsqXme23BgJQQ+zxhZssiW+8qy3HFTpU2V4dixAAHKp/NYhHXydpFfjdy4rZWmZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0MbaGNS1X/EoN8pALmS3rTacY0PzU0/FsUnjgOejww=;
 b=fgaW5B1vS8ogBnKGXqJEHCO+/BCzoZNJA7lIHRTJPxGzEJ8wUAgpmvsjbExzacRapaafKWSNdTnS9SSp9hvUMbCqyVXXKDH5XxDoYI8XPhTMvp0tlJzKrjvdHbFzetdQ4RPa46FO2evK4fET2+lob5Ny0BO34Y31UwOqoDDwB3n7PWWVDQp+wHq732igq89IWI57FUylOdsnZeeQOYKsZa+KX57MCuIR/z/jTNWI9tbM/Y6BoJr32fUwHOa8BUYR5oVHfxcAeKuHxThmCt5HUdMRV8EbfHaT5La/4IHlotQWv92lFvqhO59Gwv1jkCNJ42SoXCM6iN/SRytjHdk6fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0MbaGNS1X/EoN8pALmS3rTacY0PzU0/FsUnjgOejww=;
 b=zhEStZ9KTRL60XAEVk3IqRk1eYCNlbsdoFN9oT1zjnt7Lps0yZSQvY1jZkHLqbqxoMdX7cFfETRB1LsgRe6aAT97+zHjN8UqL/0gp9Lwdm0yyJVD+ctFAuojgHK+HSLnwXnSifDMKA7DzVRd8jP+FPhX7FFeBlS7sN30wFe4rG8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4979.namprd10.prod.outlook.com (2603:10b6:208:30d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.10; Wed, 4 Sep
 2024 14:23:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.010; Wed, 4 Sep 2024
 14:23:39 +0000
Date: Wed, 4 Sep 2024 10:23:35 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: syzbot <syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com>,
        Dai.Ngo@oracle.com, jlayton@kernel.org, kolga@netapp.com,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        lorenzo@kernel.org, netdev@vger.kernel.org, okorniev@redhat.com,
        syzkaller-bugs@googlegroups.com, tom@talpey.com
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_set_doit
Message-ID: <ZthtZ4omOnFnhXXr@tissot.1015granger.net>
References: <0000000000004385ec06198753f8@google.com>
 <000000000000b5ba900620fec99b@google.com>
 <172524227511.4433.7227683124049217481@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172524227511.4433.7227683124049217481@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR08CA0005.namprd08.prod.outlook.com
 (2603:10b6:610:5a::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB4979:EE_
X-MS-Office365-Filtering-Correlation-Id: aedc3448-cbc1-49de-a1d8-08dccced2bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PXTGcqRWk1FDEK2A6oxwi3iLHh61xJhIQ89DQYIX2fzRbnMvcSkCRJ1vX1IV?=
 =?us-ascii?Q?J9TFew6G9yGtjEUruggcid+tSipR4ehWhV76vjU+z8S3KdPSXOwZ5jozO9Gj?=
 =?us-ascii?Q?ubwgqtyTYfLCfY2Fj5qi7c8XH55DcOycYqnWBwRSS7FvMm59rUMXMBrgrA18?=
 =?us-ascii?Q?ML57eMdjskgbVAjod956K8JjgvL4FLzixuIVLk4dIJ92Z8XAI9Aev4/qi1Ty?=
 =?us-ascii?Q?FYHJoJMcdSZiwrJ0HvPEsChcRX7ltybQPx5M8Yc9ezJfnUai2aPyZqUhCoKs?=
 =?us-ascii?Q?2VaSZYFvIMEMUrQwtAq7SXl3eTiI/wbSEgTCRNxGI5lapuMk3kVFTkrOSKfl?=
 =?us-ascii?Q?13HvEVqVC8wz0letegY1V/wNRP9It9FDrXh8Ug49tsC8KFSyyvmtF3CjneDu?=
 =?us-ascii?Q?9V9DXI58G7/qS9XTL4n2Lwt+CSGTi9fvoK8jKDGkUTEUf0zhe1i1KAIaukS3?=
 =?us-ascii?Q?rB932Xm4T5cmhiBGQnHUaiyS79lPV88U9zSBLfIN7fJTYENtwdNCTZyaK4FG?=
 =?us-ascii?Q?vSMhTMwObLI8SerSpgUUdd3AKxktnMQSn2u6YrcRQ7biiVScBc5Xjv/1OiAb?=
 =?us-ascii?Q?8z53+uiCt9EwdmpwS/+iiyHLbhXT8b94KO8rZ5IAS4Euaiq9vN0NXe5LbD1x?=
 =?us-ascii?Q?omWVtbLj8txemxDM5himUuEuOaG+VUCF5ynzpT1dbLEajQttHV0gjkZu7D7t?=
 =?us-ascii?Q?//Re0Ka7Fky0kg9w9QMNGeu6tthujk662m7aIlFwvU4PUuV90BDMFWADKeo3?=
 =?us-ascii?Q?UorpNC5Qi84UNUxSMgkz03pFl/6CMZESbyO+nSiT4q5Lcrbg3jvmCET9OS71?=
 =?us-ascii?Q?K5JQM3pj8e0jg0wb1UnezjGBXVa2ENzBhpQ5StPDWKkasny9RZm5+xYBTAfh?=
 =?us-ascii?Q?QDl6wChqL3J4LbhhT8NIcj9Ulc22aIXUl1/+nhMhcPtLGcBdm9HWy+4m7033?=
 =?us-ascii?Q?TOHAqQRQQptRrcrsL15mv77G2OvKwXaFOK8N0UWLQT9+v+pqvvsJmq1NqIRJ?=
 =?us-ascii?Q?tr8IS9yuJn8rmhsOtBxgDfbHhwbfy843X/neAstDAvJc6+yUCDX5FLvFG7k5?=
 =?us-ascii?Q?L4I0oIBq29MRLKS4C6fXuv1r10Krebium/A/savDP60E5q2/klmbic59blH4?=
 =?us-ascii?Q?Ej+0760WINEBVp4cNm4gEXipUJklpem+3slfChvn7zKoleMxxyOrag2QwZME?=
 =?us-ascii?Q?0Sc5ux3TQIYbtdLEnzl/NGJm6qQ0UPKaX4iFacByHpE2e8iNMkyPiE156vD1?=
 =?us-ascii?Q?/QSqN3PJhdnm59W4S5NGzACKNvifD5UP5Lhl7QQDfAKJDBQSNvfzbBNLfA2P?=
 =?us-ascii?Q?6q52vDT9isafATniEuuvVryBFbyLQvuptmuuKy7L0b+OIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VkT4IVCeYzTO0bFpQ3JrPkKchVk7npwV6wOCQgjBHtWh0cJ8LfjIB3P2OIp8?=
 =?us-ascii?Q?0BhHTQ/P/+GTFgpCD7Jn8t0rvR7qof5N2K6yFJ8/TMzuw5rADcFyC8TXtCYX?=
 =?us-ascii?Q?Wk51RrTnh4Sx2UwZTbzQyp/CvgmNVcRd+si0XXTzk46avZOCsCEPJyHBWXRX?=
 =?us-ascii?Q?/SgDHLb8dw1qvMyKZI5Hla84fUcxzhMD+4rFEb+AcHZQBKoOe3D2zv+rFMZT?=
 =?us-ascii?Q?te1rpr8bqA7HBmdighCiW1lfwcJDM4tTmx+ldCzDdeYafu6zlEVBf4z+MCce?=
 =?us-ascii?Q?pTltay2SOMXSCbVMkDX0wp4AzyFSxhW8q7ofNgZO+/b5XmkH3QNz17h/c/z3?=
 =?us-ascii?Q?yCYqrLY7nt26kxGcFOrvsmOGt4gCq1TuJB6id3ICHJVLFoh/q2D+SYYt/4Cq?=
 =?us-ascii?Q?9/wrqXhnaNg1tTrNIKri4ZetEcEGGNEGj/mY6CPee9Pjov8Cu2CN9N8heP5E?=
 =?us-ascii?Q?+Nu1nIj9xVT6kJnwb4aAGxKkwpFSYjMfBNBTpHE4EYujGW3fBOT83w+zGN02?=
 =?us-ascii?Q?fhvCfGyOTyOb/bJFBDwrTBaFbebqZqPvZJoDmIVnFXAnhM56Wyod1qJRpRIF?=
 =?us-ascii?Q?42oQWc15od4xDjuyZxnI9kuC6cymci/sjo3SC5vlxn2tSDCOJAV/K3H2k6nb?=
 =?us-ascii?Q?Zyz+M5FGlViFlTBJoqcj06B/9lr4+E3lV7aRxRCmgG6i89JIxE2xwkO4s4EF?=
 =?us-ascii?Q?P4E6omQQxQTxL3qHrbXnIWzN93NeH8BQInXUCxkMSd8UvJvzBtfvYVOYCBlN?=
 =?us-ascii?Q?UxI3BUXxZWcCHbjLcX+4CI19vScN9IJs149ZUmgZlCUjyL+7h7gym5j+QeWw?=
 =?us-ascii?Q?SwXZb5nif7ECnywLsoszuF1XKwh6BHzS5zaCk6A/phL5nzhOKfaODhbvNfSb?=
 =?us-ascii?Q?QnG5REwvEcJgSnp5rVrsOMqLWI9cVOfU4LXPR/IqvkPVXR88by6/y4W2tCqq?=
 =?us-ascii?Q?x5xUneK7COf4x0xQh4gZJ8+jxkNrk8Gd5PMVTcvBWANv4NkpnQZvveGgGmOE?=
 =?us-ascii?Q?fwdadPqQyiDlRSgP507s+NjpGB4M25T8nmi5/5/z60BMSk/PaUx4EjWjBPA+?=
 =?us-ascii?Q?pWr89s+EB98pmXsX9lCZ71l4DhvfgnUBZvgEpNu38WaL4lTg2SPk7CKlQEva?=
 =?us-ascii?Q?9pTkxGlGkx13Nuo5TXbdNiJHMw8Hxys57tNz2wmPEWZQW6j+hnW4ZqVtNmKl?=
 =?us-ascii?Q?kapGTaJ4jKvNXzrD/EQ5zPS9XRKEADz/rpbRKw0LrWAFi10GkaH40UemsFho?=
 =?us-ascii?Q?vwMhwBSuyq1UwcrnYZEO0yhGTUcIg2xfmiG6zcUKOIZxMMLzusFQH847jkPc?=
 =?us-ascii?Q?oVnTHTOdmqzw02xVxXLvd+AJbutWT1nqyoLB4iY4inq2zkJjalGCNDY3tqlz?=
 =?us-ascii?Q?QA9hTshZGzrU/HveMyOIWPGQalsn/IhxDmk5H0jQiLw5eoplANwMGNilyOr6?=
 =?us-ascii?Q?d5kOtBJubVNuDFuKZV4bYyDuVLvzGvt8U6OEXOxpZA7AzyJ3gjSUe2wDxLi6?=
 =?us-ascii?Q?ozrkfAFfv5xvd3PTPJ2FzGFSK6l/QC9tcM15xsCzNeJkr7io/mw5wtqAO/OC?=
 =?us-ascii?Q?oQKnHTWZ8HI1teNAlEkdL1gSN5u0rT/VhfHpNGzN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JyO6bK1kGOYIyiOiDft/7pI7NmfWQXK08y65z6sWX7cnIOm4Jn/mLmrFE3OHAfrpxYKTYiSR3xTRvexSkYIoRQXhnhWcY1ZkKYVCwHRU/BSccbbFKdr0pltFjTR16E5auEcyuuZdd+umHcjC+J81QeQieW0hlQEG6pBYtCkPkuDxxmgzSsb0kAlD8FnlvGrnbTD213Svh0O1GvpHeqkkVQwL0iyly8SsHpFpBkFPKGX2AzHu312cE62P0YCKhHBjkH3Tj4Kn/CmvAARmEhOzF3n9/3x6MhsdKNqmHEU2THemqcMpSVMp1OQEbIC8jjZDnw1j7w2CYhLsO6Ze+uauvErT4PT1KlWD0UCg1QC+nSgcic2WNrvNoSC0yN5nUX6OzU7QnzalpTrJyB2o3WPLVeIsdTAgnBrofPuBMl8zaqKPTX0H99iYF1wSLyTgwDKKU2z2R1cCammTUhPMFSl9CQx7riRivxaqY+RVYOUNf6nsb76GutokV4wY1Ll3mgt7cHi8l4+qQ5DIxcAu0xW6Aim146f0aEGbzCCWAV3KT1BE8CIj0PDty8uXyOR4Nfj87vcwELWhKkTeIxkibJElfezBHVOvRUY1upetHyaYNNI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aedc3448-cbc1-49de-a1d8-08dccced2bb0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 14:23:39.3425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBKGkxenhDxMPIjU/aYlaruIdKLCRvxatghwJ5yUSzGrJDsFC643/ziTLOpyKZ0X6NWYWn86b14dtsmPfPhe1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_11,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2409040109
X-Proofpoint-ORIG-GUID: 1ssvVLcqAH7tU4s3yoydAS0tx-dvBIX3
X-Proofpoint-GUID: 1ssvVLcqAH7tU4s3yoydAS0tx-dvBIX3

On Mon, Sep 02, 2024 at 11:57:55AM +1000, NeilBrown wrote:
> On Sun, 01 Sep 2024, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> 
> I had a poke around using the provided disk image and kernel for
> exploring.
> 
> I think the problem is demonstrated by this stack :
> 
> [<0>] rpc_wait_bit_killable+0x1b/0x160
> [<0>] __rpc_execute+0x723/0x1460
> [<0>] rpc_execute+0x1ec/0x3f0
> [<0>] rpc_run_task+0x562/0x6c0
> [<0>] rpc_call_sync+0x197/0x2e0
> [<0>] rpcb_register+0x36b/0x670
> [<0>] svc_unregister+0x208/0x730
> [<0>] svc_bind+0x1bb/0x1e0
> [<0>] nfsd_create_serv+0x3f0/0x760
> [<0>] nfsd_nl_listener_set_doit+0x135/0x1a90
> [<0>] genl_rcv_msg+0xb16/0xec0
> [<0>] netlink_rcv_skb+0x1e5/0x430
> 
> No rpcbind is running on this host so that "svc_unregister" takes a
> long time.  Maybe not forever but if a few of these get queued up all
> blocking some other thread, then maybe that pushed it over the limit.
> 
> The fact that rpcbind is not running might not be relevant as the test
> messes up the network.  "ping 127.0.0.1" stops working.
> 
> So this bug comes down to "we try to contact rpcbind while holding a
> mutex and if that gets no response and no error, then we can hold the
> mutex for a long time".
> 
> Are we surprised? Do we want to fix this?  Any suggestions how?

In the past, we've tried to address "hanging upcall" issues where
the kernel part of an administrative command needs a user space
service that isn't working or present. (eg mount needing a running
gssd)

If NFSD is using the kernel RPC client for the upcall, then maybe
adding the RPC_TASK_SOFTCONN flag might turn the hang into an
immediate failure.

IMO this should be addressed.


-- 
Chuck Lever

