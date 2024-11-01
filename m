Return-Path: <linux-nfs+bounces-7621-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 573819B91D7
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2024 14:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4001C24E68
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2024 13:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE66175B1;
	Fri,  1 Nov 2024 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DqQTR8ON";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yceL1qRf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511D319F117
	for <linux-nfs@vger.kernel.org>; Fri,  1 Nov 2024 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467101; cv=fail; b=IcNdw31Da9H7rQ3qZtRrPiV3PkzDjQLW1npNHkBz64s8LUaf+vLsjbSqrpL3WYd4siYf7M0uEnAIrlLFS/n6KAkSgZys8k6hkH0u04ZWPYBX6OutQbRsRJZ5sWXTNMCkbemJlRcF6kxSNX02I0nQBPLG0eiKUf6BZM4wv5OBwcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467101; c=relaxed/simple;
	bh=2IXDUNCusU9SMqqIXjK1SwP2U46xNoeyHeBWg6w4n8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TukVvjemT2a9BW4IHBVQK79Ee8vz66H4RLpMjXhjD7QYqeahR/8r5ywauem9nFbBrAl+6Bqc33Qv+l6fqKNkjLkyK7sbTYwsCNR4H5xPG/50YZfoFbQlYVIYXnACc47cdWzqi1YQkHU0iaREWrOi3RaJnLsQJwJY0taulMslR5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DqQTR8ON; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yceL1qRf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1C2xOX018426;
	Fri, 1 Nov 2024 13:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=m+cNZHUdoiOeS7cSPL
	yNH12Tf1WYSflAf43ADcbpqU8=; b=DqQTR8ONOvQYxDfk74mvbCelkYTsBWFMvU
	p92kcY9jEVGAgBmIUnMtK2ZjaotRO1W4WErkNEr9xHhTuBwPnbgKhPeJFEfsppSO
	r1qCVpTAvA41C7kzHiYA3O0Z4VCVmLVmvjJHjmCmTZ1P8tz2BqAUlhuFISQUR9I6
	qyZCRdhwTmZ1Pa49n9qWZ70NBMNyfmoyVKg9F7D1c6UTL1Of+sptM1ks86/K7t2W
	LQLq3GiFOTi2Si8WXfnW2YDuhgHf1QyK1IkW89BvzvSdY8UddKcHJdUTsu78+ToI
	Q78wib28bbWp3DlxuVZ/aFz/WLKL+LWT/syrllQSAZfemQCCv+HQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdpc8cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 13:18:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1DFExs011788;
	Fri, 1 Nov 2024 13:18:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnaghq6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 13:18:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyyMYZcaQfEIMDvQPs6cXnwccRar/m0kz89xXHjKq+rr+uhUsTGiNgzcewbQwc2EL5lx5AXGKYWDAOnsxfnrV+LklDJxz1IUghmglno41Em4LaU3xe2XFZxDkiONva+ERn5MSobhCQjb9/aSSejDoA2ZGAtn/Yd/2g0+hfGC2aXTTFdIC4dxYRFoQGjbQDgfwozV+gFjd0O8helQqu814B+/NfxacKTTfBymkgK0pYDfu6M69zqocQuHut9aWKsqzfWFij7W6XEdmriDXbwaO2ndlzeKX1hClVLjU3E6FaadGOaisq6CEfU+3nDubYXG6Si9p4sfm4phHFv951AEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+cNZHUdoiOeS7cSPLyNH12Tf1WYSflAf43ADcbpqU8=;
 b=W6lMKUxgJ1Ys1z4Z3UIj0cJIENrVDC3F5Otfan4+CVMcaKZG+Y8lInZT1epGKZ+Jn2oZW4pBgqAgFi1hkZWr7RDbyScT9G7mLbqE4q7afn3xHo6usjt0IX7oUu82iIt1sMJmb+5a2UylrrEgQoXf7TzOMRtm13r8e3/zWXDMnCG8p2TqY2tYXriqStwMF9QH17jZhNsCsHRgPtj6vQ9SZc6XtYVZP+5lsvchqG/4fjYWD2SsiDcWv5EJd/iZDKdAB1abpNhkujc571rZDHuu5HGb81ecww6INme0A098RCezuCaJ1SA4/qPu4/Lcsu3zK9mCkKIjnUXvOjEkt/JMVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+cNZHUdoiOeS7cSPLyNH12Tf1WYSflAf43ADcbpqU8=;
 b=yceL1qRf2gR5Hny5hQlME2OMjSoAvzIeC6VSy+MMVTHnOltPHc77S6R4P7beIa2tsqoPz7kqjvGQN6XMhwUUWhTVGXSWuJbZvgiJYLcOfVRR1LHdACspIuajclhIAAdhoKLyYHowgcLtMYD0gYd7DZccDhdE5EhBIpp66DPca9Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6340.namprd10.prod.outlook.com (2603:10b6:510:1cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.24; Fri, 1 Nov
 2024 13:18:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.023; Fri, 1 Nov 2024
 13:18:06 +0000
Date: Fri, 1 Nov 2024 09:18:03 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: cel@kernel.org, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 8/8] NFSD: Send CB_OFFLOAD on graceful shutdown
Message-ID: <ZyTVC5kqozgp8DYq@tissot.1015granger.net>
References: <20241031134000.53396-10-cel@kernel.org>
 <20241031134000.53396-18-cel@kernel.org>
 <aafc9341224f4649daa44c15a1abaa62d442e604.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aafc9341224f4649daa44c15a1abaa62d442e604.camel@kernel.org>
X-ClientProxiedBy: CH0P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH8PR10MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e9ef6f-4391-4053-8577-08dcfa779f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?62TppV8Ifdrnf7IYb6ANOmnu3ZU9JHwxTN5EiCdlzD+qq1oh8v4EKHCZsomw?=
 =?us-ascii?Q?vg8csTXByJT/QKBbF25oN70ZY+xSRS/bU2CZPC+G/mdhHG0Q4bpcPhX3z4b8?=
 =?us-ascii?Q?7oRBPojHJ/8dbpSX4R0UAPY0AYC0sCfmyJyui7cJFA3HWLDcg41w5KStc7J4?=
 =?us-ascii?Q?s6F1nJx4y16teICKSQ01Nj6xlT8qSoKfxdo85l5Oroo8nG2Kk6eL9l9Zma1X?=
 =?us-ascii?Q?Fxkz4HEO3wdPJsAjbAU94cUx73dk4GsCsHYQEPyffNWA1PcL/CI8n/LPOUwM?=
 =?us-ascii?Q?QJe30Z0VVuNv9ONU421EKQZiWJS3zF28aAbK/YWFMfwNGWf6NbWjhW5nDrFj?=
 =?us-ascii?Q?/PqjeBcjU8IpGROlg2blVyKScx8XDb6r1OVpP23HnS/b9Ke+EUe9WLg2iwGG?=
 =?us-ascii?Q?YjjxzC3v/jo8IQ3VIoOhezZRoEd4/dxEt55FwFUwt+9Q771HeU2gzB+tfhVf?=
 =?us-ascii?Q?WIZEgKRbb+v36/6Qme4Bqci3K2kMCuUxqXN76Q08zBNcdEQFrEpuOZjLc9NQ?=
 =?us-ascii?Q?IRtn8Z7awutHufy5otxlEDIrTTJr43vplDVQhwCziZNAlyAJuHlURVT/ifUF?=
 =?us-ascii?Q?WvlnKBkebcvTy65f151yLt/VGZVqtVtW0jPSK2k5t28bnE3bw0lGUYLbJSZx?=
 =?us-ascii?Q?Cc9uiWQ8iyWSPBAWpeNV+RcgxQYVCH07l3TzXm92fMWVqrzGP9Mr2RKvZ58l?=
 =?us-ascii?Q?ByWa5P1oz1AXRtAF6KiVGPY99Eq8gkNNZ1w5vJmBW/c5zs+Wm14JwhGLe8RZ?=
 =?us-ascii?Q?zUISnXIsNupLj/fU+MhpMDnBYnflYtaiF5yWcsMJSrzyEGn++XF0XCTBMehP?=
 =?us-ascii?Q?cv42PDBQuy0cRgKlA5dSje/gLEiC2aZCrzc3luzKMQULumyKxBRgSIJIdnjB?=
 =?us-ascii?Q?VEKz1A+gRyfCR2VOmDWkWrctYTFKaFHwy4uy5dfKI3l1EZn4oPLJvwTjHAoH?=
 =?us-ascii?Q?UbyJAHcXJwzKgEWHlae4FboLFSjAWS3cqwd+YWgLEjTbB2SqOSE2tyleGFTS?=
 =?us-ascii?Q?83awJlp42IQWI+k2rEjUTYCCfZxKU6nFgPwlcWMDnRBRkZikjfkOl23S+ZJE?=
 =?us-ascii?Q?w8rZqQaepn3I3znUatp5WZVoPM8ZZArSbi8yIkFwcXsJez1xhjFg1Zb9dU6U?=
 =?us-ascii?Q?f5P1zA1QQPE6g/fJfUf22U7RehPQGk2t4vAnMtqGWVZ32SNWpYAgDKEQ5B0y?=
 =?us-ascii?Q?dvCWN5oGdXPF7YizMUBMJJqW5EoGXRFTZ7eRimMRSfLWXPIcnbXmIewjzyTD?=
 =?us-ascii?Q?fktnKAm6c+gzf+ehQtC0nK3rKJPMkxotFXyjHR92nkYreDvVjNhI+5zKqMTi?=
 =?us-ascii?Q?qx5T/0qAEoZx0lNmqlAij0Kz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7TIoIWpZw6opxDSG73KangKybGumcUNPa02h9V1XBNYrXj/mISDOrpnafLaB?=
 =?us-ascii?Q?dNcP2l7Da3T10sjRn5p+nag0VLAR08z2AJAZT5SXuQMLaeSs4RA7qGQmzDWe?=
 =?us-ascii?Q?k7xLk1BX9np6jbjz4j+0b0Y80rkfq5sljX84y3/zSRw7XZQzn2SgcsLM46qp?=
 =?us-ascii?Q?GMQN/cg9by1poecrzrDRmtVgGczw9mzf0dnV3JuSLknjgGnjSqJtsja1/oIo?=
 =?us-ascii?Q?YWi1gWl/sbfVKNvdSkpghYYvWoTk83Xll/3FvnEJLVXa4+ZNSqr63NYCp8BI?=
 =?us-ascii?Q?j7su/I9+BapXs9dHix5evDT6/0MJjoPTa4GiU3KyVKM04rqTXjsCBcQTpn4e?=
 =?us-ascii?Q?xQ3imX4dEUeQPFinqG8exgubOPkb590cpMRpSFgsPFeyvAgki0Zhc20v+og5?=
 =?us-ascii?Q?6eomanT6lwDthz+Hhw4ziqPvvCLIJ0SuBKst3XCXQfu90OPszSk1uIiDf44N?=
 =?us-ascii?Q?lM65wqODeIyg2KyS5YnoF/Opgm8gd65uHkQMFb0uL7l25beVQMbiO794C4Km?=
 =?us-ascii?Q?xqt9QfOL2Tm3uAuge00y/IdDXY4c7VNkbhBKCzytR74HMuvuPEd39FOlnGQA?=
 =?us-ascii?Q?rivB/PD3c8bP+eWF4A43sjtJkiNiewQVMhATtZ5+UjFHQOC9mRhGc+nMtFCv?=
 =?us-ascii?Q?/5updqfn113e9hNS+VgADZsxCZWuHaleKmQpjZdJa9QAMVwliE0UdDiykTdI?=
 =?us-ascii?Q?lsP7FDqE+9izPEYu9YAoAY+weTxoVJOx15oy1NfHceSAq3xySXGTYSGMMvcI?=
 =?us-ascii?Q?+cPKd2Z2xVZnYsgnxl5vDM4qAfbBG1dKFuiStWq2fuMpasLePwkuLsVuvJQS?=
 =?us-ascii?Q?vdd7mOrEfLrgURLJCfFr4TiGuxFnRXiSPWJYorjlMSwoBUZ+MDoso7/fUOy/?=
 =?us-ascii?Q?MMhnj6nenxt0gnsQyCTr2Fj4LNwHZJuya0SyfSU3w4tVgVfJXhH71WW2T9/5?=
 =?us-ascii?Q?B0RBJ507IsQEV0OsJbi/M7jQKpP68Bl5G3XMOXpXM2PkkPThMxMqLrqnx1q0?=
 =?us-ascii?Q?JNGD24P0HqSmAeYYsrQwvZTwsr0b9Oz2lKTeFXZ7PCafWVA+7v8uMGqbo3LG?=
 =?us-ascii?Q?NIfr3106Z9MnGSyBhKhEpEruIutYRqkL3RGiWtwSTmlso7YEwa2ZhdOgdBbm?=
 =?us-ascii?Q?GhonLU0oudX8dm3nnFjpMgWfZUAb23YdxcTemssGxOSrvqQ5amL5AR5bHtnY?=
 =?us-ascii?Q?rcr8xyrF19eI5IsYtIlK42WjkninsdVb6gV4b2GeoHAx59kmNbkcgF9pqCYT?=
 =?us-ascii?Q?XmN85LDxmjUfxDDJ4VDeu0nq1zy/bNZtf2bsXbUnbUpyUNgE3s/rML2WqyA+?=
 =?us-ascii?Q?yqpizIW/UfFWMG1qPRt0NVZhtShR0dUxNXKzsXbBQ/3//U8TSwvKxFTPLRcF?=
 =?us-ascii?Q?aAqi5OiNUahIX3oTzv0GyAiO5OS6FH8J+b9Hgm0UIEf+oJs5IGR1ysOdCIzd?=
 =?us-ascii?Q?emSD1EJBY0+InB+KQ8U5mMpdcxzUxJw3eDUkltHx02v0wjni4yRgHcz8BvOG?=
 =?us-ascii?Q?SnhdZ0daKx83H8Akg4rMk/1ndekJUayT5+cpt8rQC+RVtRf67aT2RFsuICVo?=
 =?us-ascii?Q?hpvXIFoowthx+SN6kCQ2YL1pF3K300VRnb+5l/9F?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oQzouuRQyP5JpR6YFQ0WZbWqES9xOenNr5jVXCReJ1gwVbRzXlSDwb3b7RcEaHoAaV7NdwIpAgxWxjMV4Z4D0GN3UNoZrUyuVZGBZXqaykoec1UF8LN8J6smmTiYUyLSAxLRQBKCZPz3wp/lIsNocSpfhH973YNgoOfxRWq5jFH1JVs0D8VCkHf4ICymt5seFPVIs4lQFv0BOAmb1SVnI9whkuM4F7A88E+hCrRxxqPs6SWYAs3MpAvwSEDUY83XZqc3fiUWeHgKj81nq5EZmU794pVY0cCrBJ3wJxaqp2zDgqnkqdpCzi4oq6VoeBhctiTeTPFK68rzLEkj6091B/erF8hMWRkmA41CfV8xHMMEPSQiwZhKvUC2V+lDIbgIpdi5DAdX4cMSAYLcxFpC0D97ZjuvZ9gHDUUXHFkjOsIM668FaxTXgDjQ4w3x0/3qIPf+PZxMIVje1jsAYC2ieYhSbx3TEUFY7OHVdJdOrtG3vJNAEzEBq3SI/+RPVEBcnl4KMm24UPrK6r8E9gV/gKaE9ucg9PH4xOyPeuUxC7YiYAB0TVf2YZzlYVO7LT6rpv++nIGj7DD8Ux9iSFSyyRcTiz/Z+UR/kre1zaIimDs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e9ef6f-4391-4053-8577-08dcfa779f89
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:18:06.5837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gylHrSPIF0Tj5h3EzkjhMqdrywlf/hG5LGdM6VKdy/LzZBkRsXxgaUtacvNKmdpGfQxVISXFc+AYHMBGWcMUug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6340
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_08,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010096
X-Proofpoint-ORIG-GUID: 6AA83w4IlK3uUnlwEH7D99R_qpdEYw5A
X-Proofpoint-GUID: 6AA83w4IlK3uUnlwEH7D99R_qpdEYw5A

On Fri, Nov 01, 2024 at 09:05:07AM -0400, Jeff Layton wrote:
> On Thu, 2024-10-31 at 09:40 -0400, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > If an async COPY operation happens to be running when the server is
> > shut down, notify the requesting client that the copy has completed.
> > 
> > Since the nfs4_client is going away, seems like this could introduce
> > some UAFs.
> > 
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/nfs4proc.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 4c964bce6bd7..51b3f85f3791 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -68,6 +68,8 @@ MODULE_PARM_DESC(nfsd4_ssc_umount_timeout,
> >  
> >  #define NFSDDBG_FACILITY		NFSDDBG_PROC
> >  
> > +static void nfsd4_send_cb_offload(struct nfsd4_copy *copy);
> > +
> >  static u32 nfsd_attrmask[] = {
> >  	NFSD_WRITEABLE_ATTRS_WORD0,
> >  	NFSD_WRITEABLE_ATTRS_WORD1,
> > @@ -1381,8 +1383,10 @@ void nfsd4_shutdown_copy(struct nfs4_client *clp)
> >  {
> >  	struct nfsd4_copy *copy;
> >  
> > -	while ((copy = nfsd4_get_copy(clp)) != NULL)
> > +	while ((copy = nfsd4_get_copy(clp)) != NULL) {
> >  		nfsd4_stop_copy(copy);
> > +		nfsd4_send_cb_offload(copy);
> > +	}
> 
> Not sure about a UAF, but it seems like NFS4ERR_DELAY returns might
> delay the client destruction for quite a while.

The nfsd4_copy() is removed from the nfs4_client's async_copies
list, and the RPC proceeds in the background. It doesn't block the
destruction of the CLIENTID.

But it might be a problem for the RPC logic to transmit the call
when there's no nfs4_client to dereference. I should probably
drop this patch and try a different approach.


> Maybe this CB_OFFLOAD shouldn't retry on DELAY?
> 
> 
> >  }
> >  #ifdef CONFIG_NFSD_V4_2_INTER_SSC
> >  
> 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Chuck Lever

