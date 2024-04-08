Return-Path: <linux-nfs+bounces-2716-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4776E89BE6C
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 13:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32ED1F220E9
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 11:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C2669E0D;
	Mon,  8 Apr 2024 11:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b="sZl5jlq2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2134.outbound.protection.outlook.com [40.107.94.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134CC69E0C
	for <linux-nfs@vger.kernel.org>; Mon,  8 Apr 2024 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712577071; cv=fail; b=QqbuliMtGD46uBSduFRZOP+TCUgSArdZbN9s1ZC2UCHmGBLOWe3MA7lB1l3S9+AOW+VbPtPLYKwP7pCDDnpzu4U684U1XqT+En5GFixuXhPviNQjYNt7Z8OoyqsAuElv4xNwgiARg7gpxMlx91PKb6CRTe9rKe5uD9QEz5RG8lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712577071; c=relaxed/simple;
	bh=LV8eC158DR+YrafZ10Uk+M91if3uJrlsbtHWsJ/PlA8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E3tSluXd0BGB2kJUA7TMryywUz7VNxc9mhZLUBkTwvUInKchaNkqtWxvDyocQRr9N1OrEiPGniPDFTvNoHkmve2VyeGmfcpLuP/VhVm/wWApRia7xCA40W+VYdlik+Vlw6ef562om6ePYs7BnHqgoJxb9qnNOgbOyEsoUDcdAwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu; spf=none smtp.mailfrom=rutgers.edu; dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b=sZl5jlq2; arc=fail smtp.client-ip=40.107.94.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rutgers.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQtuvWUsM7YRmZ9xtha2nrqyF9oE1oy0nVmTFNe9UywUF+oBOMjASSjwzwEerI4BT8EkwHhLDJ0IS+XH//GVme4SvJtZFpgtjO0yJO21koBLF8PZgd5ibCwNEhIKxsZ7kWLcdaA+0Xs+7WnpUVDR0gYNmddGL6lw6eZrkZuw4iAuyuqDBmOESBO+fCM/ASOdfsANxpEq7Bu/jMI+amdPebGIOhgA+Yr5PdjfesuYLvqFmHgtrkPUb5wvt8zHhlUmWexfWTR96ZQdb+dsNwwQL/AIqEmlbxkfud7tZzKwKMYdCMpREPuPHmE49UBuWgWyCiDiAVTkZEBwHNgdJrXolg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LV8eC158DR+YrafZ10Uk+M91if3uJrlsbtHWsJ/PlA8=;
 b=XZORuRchVWibTrEB+uyxTZ25DxgUc5uqzo0qOL69BQQkofnZ/1BQddhmGYMnt5SslwP2vQ8VwNcOuEyDw+fPN87ssnCLAORzjYws+6PJHHWgxNysGtKcxccSQBbBGoRjXFGO4YcqJJ3LhxZfONg8X48OyVtp2gqBUpQkid3RXexOvUCMky4e6IRVscvsVfFYpWt7i1jgd5W+luUJ//Dh77rBYrgfiPW4ZzanD6g/lnhBLLbgo78s682O2P4cky/EPk1km4v+1P0jrvkbtoDwvwEJeT6v9Fj5AGGHTYV1vM67RnR/bMnUgf4mlrs1cF2q7CVChFhI7/bjQbiDH1PgQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LV8eC158DR+YrafZ10Uk+M91if3uJrlsbtHWsJ/PlA8=;
 b=sZl5jlq2K4S/5wZBLC2BHXCSgA3YgqYxyApCfkNS8JaOF01xm+ghB37hlV1PclpZ0rHWa4lDrvd9LJ4rTzrE74tccNJWE+gAkBTUBCIUEFFrAyYA2pBfw5MtCVMrH+EqLC7EBo1bpH8jFC3LkiKqnG0MVvPRkx47SyVuMfDoLuPtLtrFOgKkE85Y3p7eW620ihCG17S1bWsWfoScsm8tD2G8oopPeJJnharOw7fd1aLyWwev2Zb6vdXrQH3OjpQBx0aq0HjdLNuxyvdbYlViK+1TmFYyCIk9NyY9wFfKxt0ySHIusii7VkMI5w44jkVA7JHtNYzspDO9IJ46DqBfIQ==
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by SJ0PR14MB6602.namprd14.prod.outlook.com (2603:10b6:a03:4ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 11:51:04 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::ae8e:c5ab:50fb:ed4b]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::ae8e:c5ab:50fb:ed4b%3]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 11:51:04 +0000
From: Charles Hedrick <hedrick@rutgers.edu>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: optimization for nfsd_set_fh_dentry
Thread-Topic: optimization for nfsd_set_fh_dentry
Thread-Index: AQHaiOz0yLe16yGdgkeM/Wdo4AR5CLFeQ8QH
Date: Mon, 8 Apr 2024 11:51:04 +0000
Message-ID:
 <PH0PR14MB54937D8D139D9203AF4897C2AA002@PH0PR14MB5493.namprd14.prod.outlook.com>
References:
 <PH0PR14MB549329F998F7DB972744F45FAA012@PH0PR14MB5493.namprd14.prod.outlook.com>
In-Reply-To:
 <PH0PR14MB549329F998F7DB972744F45FAA012@PH0PR14MB5493.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|SJ0PR14MB6602:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bi5aa/zZZ2n80xJW8d2gQvI25IaZvqohXPW5h7zcWRbUAlHbVcgqeTNxngARcE5ssktUuC3fxfVYn9fmzk2xZj0Cb89OUVcpxMfcYslfsrh2k+p36N6wUjL8HlQwJkYRON08db3rQHuiEzu8GrM6IdC2yj9Boee8wyx2C9Gj7kso66UnV/RtpF9Q+gjoHJn8KNZ7SMzovlC0oX9zMzIF7OFpy9N5+tK3NtWyluP4CrEtQMcDWGeepckltIwmgwTheWAHZ/BwhIZn+okDTtWT+K6bykSQQv47iGJ8lvtF5CFufQY4aiVMAtlDbZuPxmIh6NBcTf/IOpftoz3CIRg1xC/ctKoe5jkrbvVbXs/stwDmDf8oxJagWw1NMCsXIe9Qg/jzUpO+WfJ74dYU5M3TirPl/S5rVmpwDThwn8CLcOJhBgPV4rJtKu+oraJ88tiZa9bTyVN55zMd1/SKes+Vuo1n1hI5LULyhX3afTwh9DtpGqqaYXZUeFwcT87Q7U2Z3h447DvXbuJ6Ksvy9Xo0FADxH8c+ufKzkkrkbGMDyvv0EV7ksWqYboun3OHDGijob1QVEf9E/jw/iSWJzlOxZ6+mj1EHrUeF+Okixz3sYt0c38LbdMI+aaZH+RZApIS46mp543J/iQZN+jXfocN3Ag==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Dv3U5AgJolz6x9Loy2A4T3BrDZBt4lk6taqpVt+I0BMUHQX9HYPassURDO?=
 =?iso-8859-1?Q?6DDH7IWKoLjDrdAgNPUedqQO0fm7Ue2DHDXIfZJr7ZfCwee9TdDwmT5Qha?=
 =?iso-8859-1?Q?bWctOmpkCytGK6AWGaXXI4fjIPKPHh7ecUnME5RFC3aIW+/VjvcIxh46IF?=
 =?iso-8859-1?Q?NSrBQFnWS6u2krgQO7sZOod0n0zwTEo/P6T7sqcwJrAQ7eUrIhG1nuifMs?=
 =?iso-8859-1?Q?KMJDIqE+IrKLK8wiy6TVGpE6ZqmSQcbDW+Zp1okLlimi1QJ9vrY8q92ROG?=
 =?iso-8859-1?Q?rAHyVFR/t9zWgeQ/HFfZ5px5wp/6axprvdGAlVMaRAyCsJ0/VGQ6UGMB5h?=
 =?iso-8859-1?Q?JbXnvMw/p9qmHxUnDao/bQZqQ4K9pgtBq8zN7wHd2Ni4MhCdlV/oJvoiz1?=
 =?iso-8859-1?Q?ucejTbPlf5SvkeW1oAuLBsWp837Ki5WLnz7sdLy7WyozXiAX7DPvE8Pi+l?=
 =?iso-8859-1?Q?krmDHH7eJuo93rLOXMvgY39PD2HkUonA3nv/yucQoqSBgH0qAlqDreYYkA?=
 =?iso-8859-1?Q?ISWwVCKCxeocIl25jjay6cDEI7W1XGV7lO4eBU8nqNYstyI+mb9ZDFWNdq?=
 =?iso-8859-1?Q?Qo+1k5trbVsgmp0hfzCJUMAe4kg5Ccoz9E3m+RquKfqbRDnvtn0c7EG5JB?=
 =?iso-8859-1?Q?tr+ucBWL+4rKa78p78IHO1PA5qYbqVaVOggDEp9fkE9Q3WxCHT3WZ4xKRV?=
 =?iso-8859-1?Q?z2GgL8+7ZsI+vBmJ2CCja7VTsCo9qzgj565EJv9tvc6YSFy7MS/UVU4bJz?=
 =?iso-8859-1?Q?FVpG9r/uQgMJ0AjMNWTSUWd53N+SfFbYPAMAPQyIK79YX8IH54TNk6hZuu?=
 =?iso-8859-1?Q?NL3qTrGRkpT/IDg3NeEoBmLtCiGv6WU0PadD6Idwxh1IGvW81wrm+XYXuU?=
 =?iso-8859-1?Q?j1hepbgu0ptr4vzMYP7Q1o3JEDIPA4dQioBoNUQbMRxBmQl7frpISIpttv?=
 =?iso-8859-1?Q?d5yv8V3KqrcURVX1ajwFSvNOH7AmkKY9/Gjyk/j58wEtUguWWMkMcqXGRk?=
 =?iso-8859-1?Q?GsJzu8LS5L5hfbc3s+0WQeuGyR4VJ8++e04RL8Mhv2BUSkkyAMqqh2i0KI?=
 =?iso-8859-1?Q?aBEaUc137ll/h35bZwkhenEiscC1JpJqDLGgNnwBRJJ4xmyytvmn6fMBBH?=
 =?iso-8859-1?Q?BVxuBkoSETD9QMDp+vgSfB1cSo046PCak3XXC/4bb4ioXMjwoeaCD9lERX?=
 =?iso-8859-1?Q?qvtnE82W+wQsX7NFiEE5ArUW6jaE6Z7FVPnwxTqTAhfXoN1KQjcoMuXnNC?=
 =?iso-8859-1?Q?QtdkWLYW6eCOIMWGetPAEYyOmlBFdOBRZGt32y5vPKHkHaF1NKnsk3qcjl?=
 =?iso-8859-1?Q?rWmCc0Sfu/mbIw9zMTZrF0RbeceZgVDNPlOHqJRhmYfbfynol1CFbPDwy+?=
 =?iso-8859-1?Q?VuJ8TPAqmFVUK0KSCCbAlSmpVF0xQGQ30Me2sHdE4hNJNUkyp5JUe5DKly?=
 =?iso-8859-1?Q?1uDp6UDCNUmble4GEtdJYA9Sce3i8MILYCIaWmRUEE0IGLp4xNSGJRGm6/?=
 =?iso-8859-1?Q?smKphOBTu4dgoVWS/EHzO7mq3c5+DZ42meM4DnEbty8VBPwUMAxnzOQzYb?=
 =?iso-8859-1?Q?ZLt1RDjx/jgO4l2Ou6eWX+vRQ2H2p+vY/5AUG1bysUHkM+aRv+NXTqJK3w?=
 =?iso-8859-1?Q?jTiomJW1GMuuVVmkiVEeyN/Al8TaC482aK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR14MB5493.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16aac063-b04f-4082-012f-08dc57c22b49
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 11:51:04.1111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KxYQDAs6r3jo96vasEsEWr8x6LAhUfuJ8J3+9je4iTMJz4Cx1MHsuGMlxrRliHSvOKZ3enDLg7G2IKcOGEraCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR14MB6602

My apologies. Please ignore this. I misread a backtrace and code.=0A=
=0A=
> nfsd_set_fh_dentry is used in setfh and a number of other places. It call=
s exportfs_decode_fh_raw with an argument > > >nfsd_acceptable.=0A=
>=0A=
>That is a test that always returns 1 if NFSEXP_NOSUBTREECHECK is set.=0A=
>=0A=
>However there is an optimization in exportfs_decode_fh_raw that skips a lo=
t of file system stuff if NULL is passed as the test. A >test that always r=
eturns 1 still triggers all the file system stuff, even though it's not nee=
ded.=0A=
>=0A=
>nfsd_set_fh_dentry should pass NULL to exportfs_decode_fh_raw if NFSEXP_NO=
SUBTREECHECK is set.=0A=
>=0A=
> discovered this while looking into a performance problem caused by a path=
ological client that was sending 40,000 RPCs/sec, ?>almost all get=0A=
>GETATTR or ACCESS. It was causing the nfsd's to be stuck at 100% CPU by lo=
cks in file system code invoked by this unnecessary >code.=0A=
=0A=
(We fixed the client by mounting with NFS3 rather than NFS4. This suggests =
an issue with the NFS 4 client side. Unfortunately I don't have enough info=
rmation to make a useful report.)=0A=
=0A=
=0A=
=0A=
=0A=

