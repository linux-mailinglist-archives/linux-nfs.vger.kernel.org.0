Return-Path: <linux-nfs+bounces-18773-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIOFDs3khWnCHwQAu9opvQ
	(envelope-from <linux-nfs+bounces-18773-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Feb 2026 13:55:41 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8709CFDC27
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Feb 2026 13:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BD95300AB3D
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Feb 2026 12:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B395D3B8BC8;
	Fri,  6 Feb 2026 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Gv/h3JCk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021125.outbound.protection.outlook.com [40.107.208.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5983B8BC2
	for <linux-nfs@vger.kernel.org>; Fri,  6 Feb 2026 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770382529; cv=fail; b=oBsZbeVenHSkXOVxkEy1grvXS5Fl6/bizH6SwryMPpdC8zWs/9xY+mj8CZI1/Sjcdy+XM2ZvBZ94SsCBidFP3/dyVkmXB3U/a43ftuf8SXZUS8o1/a2fZ5HcYr9xSGojf2XAikyl7jyoKV7j/KlZ+ObggdN7N3Sr8i8Je/qR86I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770382529; c=relaxed/simple;
	bh=dekAC3JmsF3ywBjPR4g4VRkfKkWdNxDIZVIBsv+Y5Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bk2+WMMriM9+CPSWIwouXmY32vdGdWlYlL8+/XU9FwnyBtUzXE+ysomUVxvebPNFtjw5bqiIgPluCkIkHi3VEmHyNmiR1i2tqTDSqK/2V48Wm28jmQVkEHW65lOlIriPB/+/dduHpAifi4LCqgKZkTRRn1mqxeMHHip59yzezs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Gv/h3JCk; arc=fail smtp.client-ip=40.107.208.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBzeE3GfQFwfSyurCOQnzPPdKtvkzz6Ky5Npe1yLdCMvwIzI2Vgk58YfrqLkUT4FAX8WQcHw2+Ix6/Vt61ITb6iK0Lkq5JdJy5UgRS1gl7c2yi0/34Dr7f1RcAOnfWWx8Ui+gt/KsSIqivKRxNdAnLBOPmUzppmrvjCEO5Kh4CvGy/VZFhk8DSyGbp5qDwHskZHGrsrM8fkH6BvE4vjWj839hCuG6E9oFExySSbG5oV71p1lSaa+jL2urxB/ZY4OOLPGrbeY6epoci2IrKxZSCPSJbBe5oyOmyBoscPJWlwmrBSUICG4rJAcEYUQNl4yoBVHeomFXz6WoLbVQHBfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJeFMKGEuJYhJJr5QEczbfq31B3ySSmtCYtsLa1YTLs=;
 b=hRYiXZVB6Dvi4u0nw/5Ex6EuemeXmr0UW6+XGkVpDAHcW6+gtVI2nYLLxOimVyVk3t4rvBDNuB4+6QkWvqOGlSoCK+hQhBKpoL66rIbN3C9lo/iBW0kQGD+jhuiUt16jSSBo3StwQYDW7BAUaHiBnpprj80BQGYluzxMeeMf0Et7UKsc+OIuw7EpxRYCGzqA7xOAgtoo0eBBKuFxRIze1yRJ80S59KSpOxLzGTWhMBX1tw0utiedxJsW33+m45YC+8ClYfSLFBNzfRmCuE2WRQxGBfHvVvpqqRNexoDNxqDCNVa7Mu4v1e5OVtvGwwXWxdKoSVdAS8ozIxbpurD8NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJeFMKGEuJYhJJr5QEczbfq31B3ySSmtCYtsLa1YTLs=;
 b=Gv/h3JCkwVOJwRog7CAv5fWfvTyTXI1I1DdyZe37MNduRa0GahzVd8Qn+tiznoEDhCL36oE0fuHL8oQyFzKSB0JetiQgV+5jLo5dil1ytTr8TCQv0awL7Ciw2u2HYiL5GFccpzZTSebD7s1jEA7r5dH7LWism/v6x+rC0wsce1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DM6PR13MB4463.namprd13.prod.outlook.com (2603:10b6:5:20a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.15; Fri, 6 Feb 2026 12:55:24 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9564.016; Fri, 6 Feb 2026
 12:55:24 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>
Subject: Re: [PATCH v3 2/2] nfsdctl/rpc.nfsd: Add support for passing
 encrypted filehandle key
Date: Fri, 06 Feb 2026 07:55:20 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <F2FB4A29-F090-48C4-B9B9-E74492324971@hammerspace.com>
In-Reply-To: <2edec478ce219943dfced2884f646687c7117892.camel@kernel.org>
References: <cover.1770051230.git.bcodding@hammerspace.com>
 <1b3bdf869fe4075689fd29fe3fdb669ae3ea920c.1770051230.git.bcodding@hammerspace.com>
 <2edec478ce219943dfced2884f646687c7117892.camel@kernel.org>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::35) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DM6PR13MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: 10efb807-e3c9-4ed8-3a14-08de657efe6d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/sKf9O9bl8sWd0myKu1J/t/JEV3bjvrxmjSIll7jAujayVlRewhh2VnyL7JK?=
 =?us-ascii?Q?89O1utC4fVo89jEdnaKAAHV/qX70aARk3+NTcTt5+UgADK6XKWe+vQq2Scbe?=
 =?us-ascii?Q?eXN6OLGQ98Sn8jxBNAKFzXmFZhyKT1DsbM7CoKOgfbp1JPSpBCBU9M/l4z/3?=
 =?us-ascii?Q?NqJ6f5N/6iZ1OhlKuiB0z2sXC2x8ORYEvF4rwNKbTYwn0wdI/8Bu8W1ud2ST?=
 =?us-ascii?Q?knjqv8eRVweEruKjwKypMPd7/kVV3+9Px8MqjfGkD4ogjk4rK4Wn1PDMnvoe?=
 =?us-ascii?Q?f1IFP0VCUIxwUqsazgQnx2f2A/3EhMqM4L8ov63iNR78UdHL1s+k9vDvfTKW?=
 =?us-ascii?Q?XBc+duhWLwCQTUW8GcUQkAguv5EeCTmUwzj32HRRfvdnj/dUfEzPz9cj99LO?=
 =?us-ascii?Q?lOiFJAIOzdXjHvA0bRU5cfjFXZ45k3JVd/biwZv77sTP3YvXyxCXh16BSVPY?=
 =?us-ascii?Q?OblDe4YhqfTt/8yQX7sISGENKIlCgbHWS8GiiETOtopXrr3F5lKJAhIaU8mD?=
 =?us-ascii?Q?Wqve3TkrZWosKkG0VLuH/ZIwvfcB9QlwiSdlRkup0QgpcxVlbOhpgHx2e4yi?=
 =?us-ascii?Q?zwWEh5algDQgWz/w2DfLGVrK+3j0F1R6vwyR1S6ybsw9n7LDGNYOf/57ezjC?=
 =?us-ascii?Q?gcqXgQdilJ9pnHTrQ/J+j/x4PfOa0txrFlbJ6pHi7+Ws6Za7ASPW8i3Ayj5g?=
 =?us-ascii?Q?CpKVE4bBkpbBd3Q5zwkUrc4vxZZ6xyzMdSkh+3knlZn3bD+kSPKevsVDGCkd?=
 =?us-ascii?Q?kY7gIFITZdKlKMKEBQSPtpld3tjwVpkz/zUiJo2sjIOF9xdf0g79splOvr8L?=
 =?us-ascii?Q?99KIh/dvruzKRmdhkYfpp0q7Dh7FSrgmphffh9P0GVhKfIFXl+AWcmK2VDHU?=
 =?us-ascii?Q?GvAfV05+QwrD2fkHqHz3uo7mV8iNsP8XsXV8BZvZah6UbDnw1J3q3MpNOD7e?=
 =?us-ascii?Q?Rwm7TmlRyvWJQzykhJSPOht+RE1SYM4h4sAkLfNfmpDcTDN4XLD1gqUnNiu0?=
 =?us-ascii?Q?48yrkcfDCYbec5uItzkRx4zKLKNPXpNy3rRrE0Rad99xAyRikM9F/aju1jon?=
 =?us-ascii?Q?M+XKRNVkwHsIBYK92CkUSDVKBftbp6PRg7wFwckKQ768BRyRaHuevD2oWgEm?=
 =?us-ascii?Q?Zlr8iiLoM8UiG+yTZUbsnKWZqy62NJuAedSbiFy6ylPUJn5ZxER2g7l4t6cv?=
 =?us-ascii?Q?78Y/kk4lV6FJUlVsa21eEbG42kYLEA4PVz0ME7GvahGrSL9grQIVlTU1GbI9?=
 =?us-ascii?Q?x5cw540D8LwPZtZ1vzAxpJMYQ+hdbmUn0puvMERTrwjGJnS17ta6SyLjTi+6?=
 =?us-ascii?Q?ShXmgS0k0TvSDDKraY0RS+wpOC2hQdkC8ASWrvyonRrWZ7xquErwfMDXY8Z4?=
 =?us-ascii?Q?l0MSBUOXPdL+r+yLW5TntdbADmOQOmCc6AWMwXpX2A+bPTY8CgLp8XRhxMGj?=
 =?us-ascii?Q?VE8Or8IGaqrxZf0GCbxo0xcvMCqH0nlGH+INbruiCSr2ZvbZw1VFsR3sn3ic?=
 =?us-ascii?Q?JVjDEGhuw03xPiM6b3hR8xcTzwuSTuaQTM9NmcQln8xE0MLTrbWrGo+dThd5?=
 =?us-ascii?Q?8oE4+Llxcu8muHXRErc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WWf90IzHyc4cSb/VaKgSrrEIJAXUmfZtdYggdSE0h1Wk6cb/iviaMNXFemIV?=
 =?us-ascii?Q?ZJ2o/FtsJV4gRMEyibCt+15H23ILi5Ts3Xb/nhtHgXVDg7R/1VHk+9+ntsbV?=
 =?us-ascii?Q?mIbo9YoxkdWHbm8GbNz0O1M9bL74sG+29znKzFfZNGX3l7br/JVk+BVCi4/w?=
 =?us-ascii?Q?pnXEuKCV+9OfYvg2a254a14DbYnfJAseN3ylG44JkUStK3f7pqgFAbQ2P1HO?=
 =?us-ascii?Q?OZdR9kbH5glk5uknzJyQU//wyCOTdH1aeTTuQzfE8d1x9XIlJfnzEVDMDE/2?=
 =?us-ascii?Q?dLFVGeTidQl9DqUqFqeIwFX6MmVx6DbPj2FpmtqUYgVeFqZIJwI7CJmQ2bY/?=
 =?us-ascii?Q?33tdSR2SDW7JICECsOIkY7rybQEMAXFesze2dBLE/II6horLMV0cLPNMk8MD?=
 =?us-ascii?Q?2zUvKR9sqPdsvMZkLa3ljURlKDMnNVXWHRZSAMx2P6Y+SU2jYU5UpAWNving?=
 =?us-ascii?Q?kFlTbMJRlo+AIBiQ2oBiAEd8f4hXGLOR9tdfVRMd2Rd0kw7pNcwHysABxHwH?=
 =?us-ascii?Q?KY0D5sbz1dRJkPK/J6pBIqgJ3tuDRLLL6CsapDZoanHFRZ7ZIYGnqXeo9mlr?=
 =?us-ascii?Q?y/6qes9a4Wvcc7/N6/4ywI55DZrimu10fdzfRHlaLqt8w2Q+pJhdMHgv2VrR?=
 =?us-ascii?Q?LzV2nTOhz8fkIsPiWSkQGy4+wbkoc3IZXZYIKeEP20aHP0d/tuhbr3BwJC4S?=
 =?us-ascii?Q?OUqPlJaS+iYIXm4l+x300jAlJCJGWGuXw/XjE4bVIOStWydmicGIJgu+1Szu?=
 =?us-ascii?Q?Eph2ZMZ/EAWawQE1iw/gjjYzIuwRzNhuVKJ2QgZBQWRi2USnwsZ33Bw/Er4o?=
 =?us-ascii?Q?qX/F1a7b7yng8Miu3AquUyKlwiC7Zv3JhFchXwnp+mghqPk6lemFvfvx/+GZ?=
 =?us-ascii?Q?eD8VdBaluiePWNVtQe7Pc5uu8M7nDwxNmmM6vk0mXd+vzFwHPgiBABzyLfkL?=
 =?us-ascii?Q?7X5f80DJzaCqhxWh9lFtaF7Iw5hW2wiMk1PoXqkzcFzatAu3Ug1XgJd1DPar?=
 =?us-ascii?Q?NzCDy+sExYuRr0j5K7ZTnc47bkcSKJk1LZbQ8FLo9xHrAxHhIaeubKly0H1z?=
 =?us-ascii?Q?cR+LzFP+Hwh6ZEuiH+sfyn+MNz50X03fbiGk3qZ9+8rb225PY63Tk1GvQeGG?=
 =?us-ascii?Q?XNZLYMwYfWmomtbgptT8xwT3VEIBzWb3oh+xY40xkT0vyj9IC9we7Dcx0P6p?=
 =?us-ascii?Q?Lm+boL4AMOT3G9il9l1PGHlMZzrbWfZ8WpmKTI8hrZbefNLUNMMH5mhmYTu0?=
 =?us-ascii?Q?9DO88N1fVLeGRHqQkfE4V75CCNaqQtidzmuV9UlW2jEuq6sbmbykH8JMOxDW?=
 =?us-ascii?Q?aRaOXaYyJb2LtabwXHQzbt+mPrkvwJ+AWhSZ3t7l6vB0dmeRcTtWfc1C95rB?=
 =?us-ascii?Q?GQC4y3Nn+qNA0Rcsn4N9orJe4tZh0ZvSqqKQGI6w32C4k8OMyXSClnLYv6Py?=
 =?us-ascii?Q?1cAYeR+UxDVtKOLr5Ik0cbfqL0/znAABQ6y9IGvV1VeM2HlaLn7NzzQCZEEQ?=
 =?us-ascii?Q?XJzDZIvTmMAmGDYmXncviRlulzF4+Wv5KV/H+AMpX6m0wjmJCCvpPR5g03FD?=
 =?us-ascii?Q?oI1IFhzLenK95EQZmeZzHzLJ0g8p1H26wk+6utwNvW+iTGuZeYX/EYslGnJ/?=
 =?us-ascii?Q?R9voge9JhwNoMjWMwWxGlsugHup2nAXt3yCAlTI4f8qRnicW/nOfLiFBl5mf?=
 =?us-ascii?Q?Bx5wboMqFshvQEcCnSHFPgVspSKS0V8RentX0QAdoXPV6u+ps/62cgBYA6I3?=
 =?us-ascii?Q?G4VLcOvCO6rbF7FUOiivngkE8UFA/R0=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10efb807-e3c9-4ed8-3a14-08de657efe6d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 12:55:24.3507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnnXozA16dH3ZtQZH2NVMjoW/5uBwHZ/XBtcu1FJI7Zc1cr99hkoRqfEfLXB6uFQ5SK7eVJNtZitfpXjHBwqhiMqtdoiSkYvvpQAVfuMoPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4463
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18773-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8709CFDC27
X-Rspamd-Action: no action

Super late responding, apologies:

On 4 Feb 2026, at 9:21, Jeff Layton wrote:

> On Mon, 2026-02-02 at 11:59 -0500, Benjamin Coddington wrote:
>> If fh-key-file=<path> is set in the nfsd section of nfs.conf, the "nfsdctl
>> autostart" command will hash the contents of the file with libuuid's
>> uuid_generate_sha1 and send the first 16 bytes into the kernel on
>> NFSD_A_SERVER_FH_KEY.
>>
>> A compatible kernel can use this key to sign filehandles.

...

> diff --git a/utils/nfsdctl/nfsd_netlink.h b/utils/nfsdctl/nfsd_netlink.h
>> index 887cbd12b695..10df6d750fa1 100644
>> --- a/utils/nfsdctl/nfsd_netlink.h
>> +++ b/utils/nfsdctl/nfsd_netlink.h
>> @@ -34,6 +34,7 @@ enum {
>>  	NFSD_A_SERVER_GRACETIME,
>>  	NFSD_A_SERVER_LEASETIME,
>>  	NFSD_A_SERVER_SCOPE,
>> +	NFSD_A_SERVER_FH_KEY,
>>
>
> I forgot this file was even there!
>
> We'll need to add MIN_THREADS to this before your value, or this won't
> line up properly. I suppose if we do that too, then we can rip out the
> autoconf check for that constant as well, and get rid of the #ifdefs. I
> can send a v2 of the series I just sent that just does this.
>
> You will also want to rebase this on top of those patches, so you can
> better handle the case where the kernel doesn't support setting a
> fh_key.

Thanks!  Those patches are very helpful.

> I suppose you probably want to throw a hard error in that case,
> since being unable to set the key could be a security issue (or cause
> stale filehandles)?

I've kept this as a soft error because the server will refuse to give out
filehandles if the key is not set for a "sign_fh" export.  It emits:

[   76.000602] NFSD: unable to sign filehandles, fh_key not set.

This is a pretty good signal and safer than gating the problem in userspace.

Ben

