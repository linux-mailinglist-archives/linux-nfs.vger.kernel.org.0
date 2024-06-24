Return-Path: <linux-nfs+bounces-4254-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E75F915169
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 17:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5551F232B0
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 15:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD22A13C3CD;
	Mon, 24 Jun 2024 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RPxU6FQr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dr3qTxDC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50581DFD2
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241712; cv=fail; b=rn60mGXhw5mq58qT8fZkCSFxeoZWm5b6KAeKczZ9leS1nGaG06wMD6xgzL0452wUFr5CmeJ4uoKZrzA8ykAonr0qtBbVe/SKnN8uI2UaFjmai4qGWTQV6r2FG6oRRHSZmkNMNx3Uwsdy8kzUIeIZT2Bw8SgAkIwXqS4YRpw7/WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241712; c=relaxed/simple;
	bh=JwhYMxZS8ADwzO80NbLT0UUi3E3glUoEpHot50uf8jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sztG3YphM1Wj3DTvPS6WEvc/s31UpDqkEHp3NTGGq5s4KTIgX161/MI+NQogDXZEg448LenXhxpHNn5NTKZoK33A7WXDUJcY9yvbcbd+aPqdrwZuzOxr4rFWH0kdbrTnXgckvMvAq1BmqFyfCI1yFHoXOTKf8odldPD/b0AkbY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RPxU6FQr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dr3qTxDC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OEtPkJ006299;
	Mon, 24 Jun 2024 15:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=k8uUS1UiZK7bfDd
	kF6Beg6qpBQYfJRqyKevFEyP9jtk=; b=RPxU6FQrfT6BUvGb2NzGOKHB/q5F2pv
	OK+A72YBGqjRSKWg90CW9OCR+EIho+IqTK9dy01Z69Cjzc8PLfiJJixQ59sp/IPf
	ozly5oxGn0ioKqylERoRUoCzeiOkKxr2k6wJs5dvUjG8ogeNEWf8BmwemvaymUSZ
	NPCeOzvKgAzbF0fVarkG8ZfQrB8dOYEq6lWubuqIL/qyG6biI7bTfjsmdfZDM59q
	2e1yjWXH6piDG7yaI/CA9zcwRXDTtFoqjr74X8WytsgC90i0gk+Q12XuNo/HoNyd
	n8ltN/WFxJNPEKJP5SDvufoguPJMbVm9SH3xXabXTMZd2ppy1gVMYMQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywq5stv6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 15:08:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45OF75ws037105;
	Mon, 24 Jun 2024 15:08:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn26eku9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 15:08:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJ195HMN53BEtG/eyjowkgQenfWX70zl2IuWXX7ilBL3hCmmS+ZKAElfkEJ/u8T+Luw2V9DW6m70S33LTur3jFXvxNzXkRDtvgUmY8ZdHNZtGqzTN/O8PVJZwXS6o7UKN9EvPKQwj7/Y/DKjkqEZhD696JZJxQmvfvTT3zvay1XHEeW6cPcSSLCo8ZUorBfvoHHKz01tcEhvbrPT5YMRdXmaisWfj2rPEFLvH5m6vJrVVl7+awrkQLqDjE4SJVrRB+ADT0ZuqZzJEUBcoVJvyMdIndwSWmoGH30t5xHwFKayjphRfFiG6OojMu3SxR4jsblsyvYndINkqpqwk4spvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8uUS1UiZK7bfDdkF6Beg6qpBQYfJRqyKevFEyP9jtk=;
 b=Qq0R+GzUShgTkALKrYukxlOM1wrmRDzIeHKd0PH0gj729mkbkZc/lCZecdwhqs+5WeHLRamq9F4evnyOHToTdeRxtmqSZCIhLhRqpK93eQ1RN/rfbZEREk9vdRSoALl9nzm5JwwCzdpnVhPKPMqStao6rqdNOvTWTM5HUYuAasQ5yjowuYTsDeCyDbe5C9zzvfNcrZmjuyXb1N3OHD61GQ/P1dG9nMLXPFJWoAvLgJDOGkEOKfwTkELS9XmmlwLk2yK/OpTgXXGo8axRm9g1y9H8kBZa9sksXgi24rM9PIgU/fviijYfrrQECDCrGKEYh0fVTPRPC4HiiqOcAhmcSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8uUS1UiZK7bfDdkF6Beg6qpBQYfJRqyKevFEyP9jtk=;
 b=dr3qTxDC8SuPzotS+Xlmh0v5hKXWU5OMcdAOEbuje3YQODGyFMwyWXb/cThl3OOVQBXopDs74OYCI+EKZdGGJvOGP6wJ/sXz8SPNZLBqNxuq2iHz34GYqGJWy7Pf81Z5JjAct6Gg/ViC5nCKUYEByViYuSwaIlvq3oKNxtJmgqE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4341.namprd10.prod.outlook.com (2603:10b6:610:78::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 15:08:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 15:08:19 +0000
Date: Mon, 24 Jun 2024 11:08:15 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/4] nfs/blocklayout: Fix premature PR key
 unregistration
Message-ID: <ZnmK0X9z/kp4wX8x@tissot.1015granger.net>
References: <20240621162227.215412-6-cel@kernel.org>
 <20240621162227.215412-7-cel@kernel.org>
 <20240622050324.GA11110@lst.de>
 <ZncJMl0eYOeLw5v9@tissot.1015granger.net>
 <20240623073627.GA28166@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623073627.GA28166@lst.de>
X-ClientProxiedBy: CH0PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:610:b2::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 3490a61a-01ad-4f13-64d0-08dc945f7b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Lh8Yu12PM4FWtXfhvVkuMujszpZujbZMqV8qZEuQecxhKv0ekRcek8ng5AX0?=
 =?us-ascii?Q?MPjK7q7PIflXArlbOVlrfJa7MykEEvtR7eigbS6VjJ2Y0KoThwDZG9uSoE2w?=
 =?us-ascii?Q?j/0/UMfuavfKkcbaIDsJ6mT247U5p7/mA5taoy7aywGk66xyuz2ptYmmb0pH?=
 =?us-ascii?Q?khzZ0RLUrY75T6GmOATj6zdsdVFFs7S9hZK1AJWVn5g+DeHvRuuXAof1SkKB?=
 =?us-ascii?Q?Erze5stTege+XFSpZscjca64j9HycZbQHXoC/OjjX5/bsS80x4o3rt9497Yz?=
 =?us-ascii?Q?n7LYwonKcEvq84ikbARqYSDUPGzWUZjsa3n+f1UXkZKq7e0XBVIEtb1yxtpa?=
 =?us-ascii?Q?2x20qoAuB+aaHhg9fqvKnb6/2e76flZdCo6laYiPBUxxXtAHY/rdK4Asdwgy?=
 =?us-ascii?Q?J+ZbbIixIHU81cSNbSPbfOogvsPxodwJQ5jVt8I4cl6BZRRr3vqB2fFv/dc/?=
 =?us-ascii?Q?12GXjYVStcX/BOLanRu6MhsJfxYAbghDiOBdWIR0XsSjxEzydu45r1XdP4G6?=
 =?us-ascii?Q?/MMpNiSHpBnsapYyfavHv2CckYRDrj9fNKXWYjtm/aM+aBzFbd4+Ok5oGySK?=
 =?us-ascii?Q?wHZI7jR943irp6aWq6lkQG/QjZq80ZgSkkbuf4GXTWJUkHUaIKcOVkaO1yMK?=
 =?us-ascii?Q?kC3ZTysqBdyi4tOYw40vQMaDdEkQ/dUhGu41FxDZYZBMZ+Nlb0b50yGyWLrJ?=
 =?us-ascii?Q?JjE41xvZuoJAwDzoJ1+GxQAG+GLwMOQ36BjNcFYYclk4/zCY9r6LqAdKdJ8z?=
 =?us-ascii?Q?yq4nzF9YChCiTkckoT1RhBUMmJI9sjbFOHpa/vn9UhITKF8j61E4ZVaxqFXi?=
 =?us-ascii?Q?JFx7eBI4gKqDS9nVU+mJs2QsdU5pRF95t+iOtnFxU/7RoUMVPz6dX/5htwkl?=
 =?us-ascii?Q?1VaB3vqAVYQOr4ZiwfhM1mvjNTLk7K2HOmdtIA8V/NDiBkgpf5riBCElLi9F?=
 =?us-ascii?Q?tj2mInIWXcHSlZvWV+ZBt1pCV0NOT6idy1KO2YjFnz93a+Nmf1jyQ4I1jvnr?=
 =?us-ascii?Q?4augrLpM5dd/QRiIii2ywBpve3alw57gV46flBgPJswWrDATLl7/jsgbaiee?=
 =?us-ascii?Q?hO2bJEe9kmLEiXXcHpJXwIJUtqVNW3DlWcHFCTHIXjN0qwAmt24asEP29PTz?=
 =?us-ascii?Q?SwiSsW/AZ5BWTJ3q9iZtbBjVOmI/tbORSZP8rpHsTPb/zOhuijjH2M9YWQSL?=
 =?us-ascii?Q?HDmIivcHQgfIuRsGBzI4qaCAAGo0Vb3Fl0FwXd4ZYtq0vr9JsCL6PgRlK3Fz?=
 =?us-ascii?Q?JY/CxzmAGm+IwsWuaV5Ev3Deum1jarMMxCaIQ0Ag2NoDSomRoB9a4d3+odek?=
 =?us-ascii?Q?4NQb6e4uNKRfBcn/fWC1qFj8?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MQLfWINgjhaKOqVHBFHxP/H6P2pxj0h4grVfTR2IZCXQdBcSZxdIP8Q1dAO5?=
 =?us-ascii?Q?mzpT05XNT8M3ex8dlFt9WeJhJUCKPiopAYHgqOcI9gmDIJtt98ojV+OfQJ9B?=
 =?us-ascii?Q?MvhkLguOV9hJi3jPK4ZXoO0jgqZr47+uqXwlKKoXW/j2A4HgM4ejlvhZGa6X?=
 =?us-ascii?Q?PVHWfdjMbJ+6Pg+NaILa0ukEyBhMLzpRCNixME29vzD+JG+im0rg6mFi8JLC?=
 =?us-ascii?Q?tXWRPzfqORO6G2YwYTXvEDvyNA7k6SU2zuPfZiqpCdqYvM5OcjjxYQyqxCao?=
 =?us-ascii?Q?d9O+YZQ6SsL/ZbRRFKXf7lecVXF3+XfNvdW0K/D2btdvF3WnzL65yaBj7JI4?=
 =?us-ascii?Q?ggECSfS8udVZw8NaUOGFp+DFpGJKZOdQiIk8JhapM6Xz0NNOyZrctMautw+x?=
 =?us-ascii?Q?U26q9uDlvcfDTRXRtEJPX9BD/0l8N88721m1Jace5x2lyPRG8bmQP1eOuFfB?=
 =?us-ascii?Q?i0aHN8D/4QnUocyrSH8ef7Amq2/kB/viDDLDl6uJ+9vZ3dby1VHN3MLosvZJ?=
 =?us-ascii?Q?MA8+BmdHLV4AyRyYtWz3a0n9hteCKJzDpuBHBcOEmwc8RdN3uXbWWO02DzoR?=
 =?us-ascii?Q?OSjA5sDebirzwYdztl+hPd+qLh3DzBSVreWwIVV4bcATohL0w5NZfZMJLXxB?=
 =?us-ascii?Q?QqzyhzzlJ0Z0E1mkXt6CDYpCkCF8DpnzD/CSjvZcMo2t08VzJp7Dl/3k/PQu?=
 =?us-ascii?Q?BNQN6sA975CDqC4Om+4u3Dk50AeQ+MJMv9hyeJ2dEPEAjfel3cqlNApiiKmV?=
 =?us-ascii?Q?yIsQBmO666K2lyhhUZt45oOm7ihHa/ySXTmfXXmxSTWWpULxFXDEk1KKWkuE?=
 =?us-ascii?Q?vQebkPIHRUC4hMHj+iHPcNaeBR6hVNA4MNeDscxK/pClixPGpW17pKQwaLDA?=
 =?us-ascii?Q?e1PrJB+fWVbEEqZT1NGXUM7/yMX6F+H+jE0Gm9LgCdVQdPv2QjnFarEyGA/K?=
 =?us-ascii?Q?N74YAbOzVVtAN7ea6nDh5LsoojftHLeBWulST/DynfCWAKa0BRRsWcLkyjXO?=
 =?us-ascii?Q?cRbCn+aMnm/4fjf5Mn7g39Yp5T/XrVbD8gYJCcTmQPzSjMdPf4g0oabVaE86?=
 =?us-ascii?Q?1JhL5CK0EvoIt7jGqqRajBumVU0IyvMedzZA8o9QWUBADJ8y6PyW9oIHeFpP?=
 =?us-ascii?Q?2HPyEm8Ib2l9FnRlP5/dgp1ILDIqRkZLgRNNt9+opm++D3FAfraiqgjRe061?=
 =?us-ascii?Q?/fX36vi+PUdxtA7xU1bDkE4rAWb1H0W5Rk1v12SKwDUw7LhGfr0FVKtEDK68?=
 =?us-ascii?Q?IwzeiPb61BgTku7VrzaDerc5xYkTFm9WbJ02rn8S1nlaJuNhLcdoWiVg0KMu?=
 =?us-ascii?Q?wzlqfbvjqkIctUxwPzdv+YyXjb3URnb06r4gtUJ3rdlEZvbrx3Ah+LzFlAWS?=
 =?us-ascii?Q?jy+un4Yu3g8R2qEtmCXOcnEY2fG/Ni6Fax2GCYtleWBYkmk1bayhzbKMOG3l?=
 =?us-ascii?Q?mjnSenLVI2slnUWyUbEZoxruJUvyT5Kvg7sJlsntMbTNetF4/hDbAcleyZzC?=
 =?us-ascii?Q?3/KbFWcEnD/e56bUwQbwNjKuTq2WlWz2SjqXvEmeyT2+j1O/35INiO+3IWcB?=
 =?us-ascii?Q?Bi7lrnuoHW1L4BdvOAgDxyVcGGBt986iG9DTcc7V?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JJPqwAeGX1e89+4YHC5CfpQ7v+P7AfbQFD7qtmDnE1fogjLUX7g+PmofxwEIoX/zi9Fg6pf5tpFrKFrgN8MAliaDwT+7AEiUEWmZY5UKbcesWi0JmZfc3hbuPPzZk4J7QtEyFYAw75+H3C3wuSCSITGI+Oar32JgcqD54lpVVbuBmEW9zr7Aowjtoy437tUU8ZntqBhLF3Lgoi+q/JvEAQKmbWH18BsTHEQKBiexktaEsof2Dz87F+W5BeA3LCDj2W5RfsYKvcFL+0GIOrcFA0BZ+SXjwProYd9ER2wCRFtx4zNOwyOOaU+tfk4Hal8dy3OjOXxESG0KR8a1q7005Hz+1txN4dDafItyVIoNStq7rFBJ8WcvrYPmwGp4H8blI8NxPCH0j3LpaO1NruLQcX9CUCJ5pIgXEigOTEQ6sGba2+XcD02u2NQzQgz0aNY1HlCJAdLFPRs0LnPx9KlSNv1bsCYNdYzgMrpt0Ni9wF+miqsEq4ZH7WnagWbFQQB5U6ClwFBHjR0hNrxXNm2mhReZzTXMh5UxRUvy6umHPjSduALFdNO7mHjCZpKfMVeeMlKuDIgSXMTlqvT4h1MStxQDx6gsJH7CUFt+8jomnhk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3490a61a-01ad-4f13-64d0-08dc945f7b17
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 15:08:19.1784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYx7MJTzt/2YUCbIoz/fFLYgtSJO0+6ZM4lmmMkaEG570/cEzYVjgRJKdcq2nmbQDfngOJWbEpwLyVNc7w7lig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4341
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_11,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406240121
X-Proofpoint-GUID: ICGSnq48zL89CoOX0owQzUgbfU6BX2R-
X-Proofpoint-ORIG-GUID: ICGSnq48zL89CoOX0owQzUgbfU6BX2R-

On Sun, Jun 23, 2024 at 09:36:27AM +0200, Christoph Hellwig wrote:
> On Sat, Jun 22, 2024 at 01:26:10PM -0400, Chuck Lever wrote:
> > This patch currently adds the pr_reg callback to
> > bl_find_get_deviceid(), which has no visibility of the volume
> > hierarchy. Where should the registration be done instead? I'm
> > missing something.
> 
> Something like the patch below (untested Sunday morning coding) should
> do the trick:
> 
> diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
> index 947b2c52344097..6db54b215066e0 100644
> --- a/fs/nfs/blocklayout/blocklayout.c
> +++ b/fs/nfs/blocklayout/blocklayout.c
> @@ -564,34 +564,32 @@ bl_find_get_deviceid(struct nfs_server *server,
>  		gfp_t gfp_mask)
>  {
>  	struct nfs4_deviceid_node *node;
> -	struct pnfs_block_dev *d;
> -	unsigned long start, end;
> +	int err = -ENODEV;
>  
>  retry:
>  	node = nfs4_find_get_deviceid(server, id, cred, gfp_mask);
>  	if (!node)
>  		return ERR_PTR(-ENODEV);
>  
> -	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags))
> -		goto transient;
> +	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags)) {
> +		unsigned long end = jiffies;
> +		unsigned long start = end - PNFS_DEVICE_RETRY_TIMEOUT;
>  
> -	d = container_of(node, struct pnfs_block_dev, node);
> -	if (d->pr_register)
> -		if (!d->pr_register(d))
> -			goto out_put;
> -	return node;
> -
> -transient:
> -	end = jiffies;
> -	start = end - PNFS_DEVICE_RETRY_TIMEOUT;
> -	if (!time_in_range(node->timestamp_unavailable, start, end)) {
> -		nfs4_delete_deviceid(node->ld, node->nfs_client, id);
> -		goto retry;
> +		if (!time_in_range(node->timestamp_unavailable, start, end)) {
> +			nfs4_delete_deviceid(node->ld, node->nfs_client, id);
> +			goto retry;
> +		}
> +		goto out_put;
>  	}
>  
> +	err = bl_register_dev(container_of(node, struct pnfs_block_dev, node));
> +	if (err)
> +		goto out_put;
> +	return node;
> +
>  out_put:
>  	nfs4_put_deviceid_node(node);
> -	return ERR_PTR(-ENODEV);
> +	return ERR_PTR(err);
>  }
>  
>  static int
> diff --git a/fs/nfs/blocklayout/blocklayout.h b/fs/nfs/blocklayout/blocklayout.h
> index cc788e8ce90933..7efbef9d10dba8 100644
> --- a/fs/nfs/blocklayout/blocklayout.h
> +++ b/fs/nfs/blocklayout/blocklayout.h
> @@ -104,6 +104,7 @@ struct pnfs_block_dev {
>  	u64				start;
>  	u64				len;
>  
> +	enum pnfs_block_volume_type	type;
>  	u32				nr_children;
>  	struct pnfs_block_dev		*children;
>  	u64				chunk_size;
> @@ -116,7 +117,6 @@ struct pnfs_block_dev {
>  
>  	bool (*map)(struct pnfs_block_dev *dev, u64 offset,
>  			struct pnfs_block_dev_map *map);
> -	bool (*pr_register)(struct pnfs_block_dev *dev);
>  };
>  
>  /* pnfs_block_dev flag bits */
> @@ -178,6 +178,7 @@ struct bl_msg_hdr {
>  #define BL_DEVICE_REQUEST_ERR          0x2 /* User level process fails */
>  
>  /* dev.c */
> +int bl_register_dev(struct pnfs_block_dev *d);
>  struct nfs4_deviceid_node *bl_alloc_deviceid_node(struct nfs_server *server,
>  		struct pnfs_device *pdev, gfp_t gfp_mask);
>  void bl_free_deviceid_node(struct nfs4_deviceid_node *d);
> diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
> index 16fb64d4af31db..72e061e87e145a 100644
> --- a/fs/nfs/blocklayout/dev.c
> +++ b/fs/nfs/blocklayout/dev.c
> @@ -13,9 +13,74 @@
>  
>  #define NFSDBG_FACILITY		NFSDBG_PNFS_LD
>  
> +static void bl_unregister_scsi(struct pnfs_block_dev *dev)
> +{
> +	struct block_device *bdev = file_bdev(dev->bdev_file);
> +	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
> +
> +	if (!test_and_clear_bit(PNFS_BDEV_REGISTERED, &dev->flags))
> +		return;
> +
> +	if (ops->pr_register(bdev, dev->pr_key, 0, false))
> +		pr_err("failed to unregister PR key.\n");
> +}
> +
> +static bool bl_register_scsi(struct pnfs_block_dev *dev)
> +{
> +	struct block_device *bdev = file_bdev(dev->bdev_file);
> +	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
> +	int status;
> +
> +	if (test_and_set_bit(PNFS_BDEV_REGISTERED, &dev->flags))
> +		return true;
> +
> +	status = ops->pr_register(bdev, 0, dev->pr_key, true);
> +	if (status) {
> +		pr_err("pNFS: failed to register key for block device %s.",
> +		       bdev->bd_disk->disk_name);
> +		return false;
> +	}
> +	return true;
> +}
> +
> +static void bl_unregister_dev(struct pnfs_block_dev *dev)
> +{
> +	if (dev->nr_children) {
> +		for (u32 i = 0; i < dev->nr_children; i++)
> +			bl_unregister_dev(&dev->children[i]);
> +		return;
> +	}
> +
> +	if (dev->type == PNFS_BLOCK_VOLUME_SCSI)
> +		bl_unregister_scsi(dev);
> +}
> +
> +int bl_register_dev(struct pnfs_block_dev *dev)
> +{
> +	if (dev->nr_children) {
> +		for (u32 i = 0; i < dev->nr_children; i++) {
> +			int ret = bl_register_dev(&dev->children[i]);
> +
> +			if (ret) {
> +				while (i > 0)
> +					bl_unregister_dev(&dev->children[--i]);
> +				return ret;
> +			}
> +		}
> +
> +		return 0;
> +	}
> +
> +	if (dev->type == PNFS_BLOCK_VOLUME_SCSI)
> +		return bl_register_scsi(dev);
> +	return 0;
> +}
> +
>  static void
>  bl_free_device(struct pnfs_block_dev *dev)
>  {
> +	bl_unregister_dev(dev);
> +
>  	if (dev->nr_children) {
>  		int i;
>  
> @@ -23,17 +88,6 @@ bl_free_device(struct pnfs_block_dev *dev)
>  			bl_free_device(&dev->children[i]);
>  		kfree(dev->children);
>  	} else {
> -		if (test_and_clear_bit(PNFS_BDEV_REGISTERED, &dev->flags)) {
> -			struct block_device *bdev = file_bdev(dev->bdev_file);
> -			const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
> -			int error;
> -
> -			error = ops->pr_register(file_bdev(dev->bdev_file),
> -				dev->pr_key, 0, false);
> -			if (error)
> -				pr_err("failed to unregister PR key.\n");
> -		}
> -
>  		if (dev->bdev_file)
>  			fput(dev->bdev_file);
>  	}
> @@ -226,30 +280,6 @@ static bool bl_map_stripe(struct pnfs_block_dev *dev, u64 offset,
>  	return true;
>  }
>  
> -/**
> - * bl_pr_register_scsi - Register a SCSI PR key for @d
> - * @dev: pNFS block device, key to register is already in @d->pr_key
> - *
> - * Returns true if the device's PR key is registered, otherwise false.
> - */
> -static bool bl_pr_register_scsi(struct pnfs_block_dev *dev)
> -{
> -	struct block_device *bdev = file_bdev(dev->bdev_file);
> -	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
> -	int status;
> -
> -	if (test_and_set_bit(PNFS_BDEV_REGISTERED, &dev->flags))
> -		return true;
> -
> -	status = ops->pr_register(bdev, 0, dev->pr_key, true);
> -	if (status) {
> -		pr_err("pNFS: failed to register key for block device %s.",
> -		       bdev->bd_disk->disk_name);
> -		return false;
> -	}
> -	return true;
> -}
> -
>  static int
>  bl_parse_deviceid(struct nfs_server *server, struct pnfs_block_dev *d,
>  		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask);
> @@ -392,7 +422,6 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
>  		goto out_blkdev_put;
>  	}
>  
> -	d->pr_register = bl_pr_register_scsi;
>  	return 0;
>  
>  out_blkdev_put:
> @@ -478,7 +507,9 @@ static int
>  bl_parse_deviceid(struct nfs_server *server, struct pnfs_block_dev *d,
>  		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask)
>  {
> -	switch (volumes[idx].type) {
> +	d->type = volumes[idx].type;
> +
> +	switch (d->type) {
>  	case PNFS_BLOCK_VOLUME_SIMPLE:
>  		return bl_parse_simple(server, d, volumes, idx, gfp_mask);
>  	case PNFS_BLOCK_VOLUME_SLICE:
> @@ -490,7 +521,7 @@ bl_parse_deviceid(struct nfs_server *server, struct pnfs_block_dev *d,
>  	case PNFS_BLOCK_VOLUME_SCSI:
>  		return bl_parse_scsi(server, d, volumes, idx, gfp_mask);
>  	default:
> -		dprintk("unsupported volume type: %d\n", volumes[idx].type);
> +		dprintk("unsupported volume type: %d\n", d->type);
>  		return -EIO;
>  	}
>  }

Thanks. I've applied this as a separate patch (I can squash it into
1/4 once it passes testing). The first write I/O segfaults at L143
in do_add_page_to_bio() :

 142         if (!offset_in_map(disk_addr, map)) {                       
 143                 if (!dev->map(dev, disk_addr, map) || !offset_in_map(disk_addr, map))
 144                         return ERR_PTR(-EIO);

I'm looking into it.


-- 
Chuck Lever

