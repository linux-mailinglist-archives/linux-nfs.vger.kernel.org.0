Return-Path: <linux-nfs+bounces-2050-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4238385FDD7
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Feb 2024 17:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641391C22D28
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Feb 2024 16:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE29153BEB;
	Thu, 22 Feb 2024 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netapp.com header.i=@netapp.com header.b="HS8Mt6xy";
	dkim=pass (2048-bit key) header.d=netapp.com header.i=@netapp.com header.b="HS8Mt6xy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7301534F9
	for <linux-nfs@vger.kernel.org>; Thu, 22 Feb 2024 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708618438; cv=fail; b=CyKLb4vJmn0SsQIoJjYDjC7UjA4EDeUxx30przC2erscM2yyvrvoSURN+x43ghXUo7FhjhO5LoN7cTODbxqn/yoW5keFLwZEpiptw16EbCqDsF2C7bVvfqvn7bEuLtVC1D/Y4Cql3YfzGNO0RZW0GGP/PHWOc/TYpRdfu6n+hdA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708618438; c=relaxed/simple;
	bh=0tu0rq4ewsNUWfLgNzh3PACAOdHW6g1Snp2BC6UG69Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i9ceB5CldL4bidFLcHF/9RfVa06D/1OZU4W5d14y6NVDT9wVoqApSSzhCVyoNG9ru8X7NhjuS/N1iffjiA8ruwnE+2kLC/18yPJobidBEPhJskR/2tRbRA0OmvIWuIcn26zjf8AKLkJO4ki7YLXbMtDcE7EwF/PG+L9kvXwW5Vw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netapp.com; spf=pass smtp.mailfrom=netapp.com; dkim=pass (2048-bit key) header.d=netapp.com header.i=@netapp.com header.b=HS8Mt6xy; dkim=pass (2048-bit key) header.d=netapp.com header.i=@netapp.com header.b=HS8Mt6xy; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netapp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netapp.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=j3k6RWt70LGRtQGsPKHd1vQaxFj4PnNt+niF1SiPUD3HAmwDh7pjsqeiRM1I8vtM0tRk+Ndwu3UrB9+Y/mIerZt2sxhaBaLrTJyA2rcoyYEY2DEWl29VudlE7dWPS7n6NC1+DOnEjQQ9C1YmYrtPiQzv90g4dU3c/1gTL6yMvsmS1XLzP5giZzeRLTI272+bFG1x3889Z0+lJTf1PZTliZHMd87vr8aXwLaemmsuczZZ3tFAqahn/1Zc7xbXiAXWj9DXDmLw3Udf+bdCcYV8XVikVieeX0Fh3TMK4BVLmJxP//b9BKd0KphkMKVH9S4qNSffBvCmQ0/s0CQbfaCM9Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GedbROMzTGOtW8Ap2+wHe+IEqIzqVR9xxIlzJfNGvm4=;
 b=EaVHUQaOdHaM8yML6p3QKRMew8A5wI1m93x9iVsOpP6pQECRgrCEosJ4aAiuI4VzW+4joudxd2zOuDJNnilxWHPSc9rEPP1dXmGU2VXx3RcTRMuG5BAkbIYhX9QSAzz2TZ9Aw2aW4+Y4BzWOD3CoOtwh3gD+KlBVJPVxre7yoETe5HOt0H9rtM+Xr1wI2n1q+dc6cAeX1RKROdd715io4RECHGjUg7Bs2e258MTMBhHNWNKlLkZ0aI9/6ABiyxZW62MJP9ghjoTYZMERWPjqhBfEcw9OXpWzK/N8PPQx79KFN+URgi1tgrcxQfnIRiJVUKVW9yaFPrzN0E9D1YKRPg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 52.8.140.255) smtp.rcpttodomain=oracle.com smtp.mailfrom=netapp.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=netapp.com;
 dkim=pass (signature was verified) header.d=netapp.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=netapp.com] dkim=[1,1,header.d=netapp.com]
 dmarc=[1,1,header.from=netapp.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GedbROMzTGOtW8Ap2+wHe+IEqIzqVR9xxIlzJfNGvm4=;
 b=HS8Mt6xySk+bsEum+3pWq1Sarkl73VxgT/gbmSlJkP6kWmLNKGDeF66Gv0KheqPJiQRABSMDorMg8JV+j72OyaZcw5L7S74TfI9s7rAKbFM1uTP4vHnmxmC2S3FS7fRBOtbUsz2dwzkfzvcBZha+AtJC/hoy8mHc4OkZMH2ltDSt1f97gpzpSdCPIGU4qbQjv/4NFjVpW57I9ZuKNADBe1VVGRSaK5PpoK+ldWmzWlWWY0Fo/L76o3ctgdyFWjXJCgnBcGY0UG6ZnQb2rzEH+BGExl5PFuzQvkGC4+BdsyMsPbjVROGGAOADH9avOnlW6GtqOXgbP9BkPNeW1vVpsg==
Received: from CYXPR02CA0063.namprd02.prod.outlook.com (2603:10b6:930:cd::8)
 by MW5PR06MB8954.namprd06.prod.outlook.com (2603:10b6:303:1cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 16:13:54 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:cd:cafe::30) by CYXPR02CA0063.outlook.office365.com
 (2603:10b6:930:cd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 16:13:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.8.140.255)
 smtp.mailfrom=netapp.com; dkim=pass (signature was verified)
 header.d=netapp.com;dmarc=pass action=none header.from=netapp.com;
Received-SPF: Fail (protection.outlook.com: domain of netapp.com does not
 designate 52.8.140.255 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.8.140.255; helo=haraka01-inline-api-pop.vpc-50c51735.usw1.shn;
Received: from haraka01-inline-api-pop.vpc-50c51735.usw1.shn (52.8.140.255) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 16:13:54 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by haraka01-inline-api-pop.vpc-50c51735.usw1.shn (Haraka/2.8.24) with ESMTPS id F27D4590-712D-4706-86F2-ADF8BF833F67.1
	envelope-from <Jorge.Mora@netapp.com>
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 verify=FAIL);
	Thu, 22 Feb 2024 16:13:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcwTRlXavuQlQ/oYKTE+d3DePWz5yeycJqZEuJG8IWGojR5mDSsZpW9+oSpzbrPpFpHYol9X+kdQekXcqPtArIEQlPhub85+bZrNpJ2yvJBYRR9puTeuGAyHBK1OqLSS97Fu0SAlYNva8GNQsJ5T+3OQZdkQNWMsHEiahEudMBGXZbMwkklQ6Q0eGxYycOmftQG5gSWEr6p76BR5BrTa936lhS8PBp3TET0rHHELaL0ToHSGVjW6IjxARU6+HDXsdz5Q5JhDc1DDXgN7onsstFT6qMT29sCyEN6nZhphMV5bEiY/e/TTRYTo2K0uuIzwiV3YGMF6KNd/QBej5VNYbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GedbROMzTGOtW8Ap2+wHe+IEqIzqVR9xxIlzJfNGvm4=;
 b=YMGciNg+J29Dkh/AlEmr4VnLxAbHaiejESGD9t8jfgGEyYWK7ymmzaVoF26Uw6Qi+kAbknWCR4N2eWFnHjv4b/R/r9Aqote12YLPZJ7bnLb6cnpg5ObOF0iURwx7qGaz6A/guCVVdwA1k3ALnLkLJ8fcR9mXeKgfPpPiwcOtdH71ezNBeQ9f8ImYzFjmqvQia+LcebajbkwF5iYyqFvQaWdVYVdB0em9wOkC/VlqWuFlqcYYX50XOiQzCyFkSFm8RNKLt501o7QFP7MhGDhIkZRHEEQijEnYx2+Zct5DF76QrtY3R9d/UW+P053rJp0WAE2FWSNywQsfcHHJ7Y3yQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GedbROMzTGOtW8Ap2+wHe+IEqIzqVR9xxIlzJfNGvm4=;
 b=HS8Mt6xySk+bsEum+3pWq1Sarkl73VxgT/gbmSlJkP6kWmLNKGDeF66Gv0KheqPJiQRABSMDorMg8JV+j72OyaZcw5L7S74TfI9s7rAKbFM1uTP4vHnmxmC2S3FS7fRBOtbUsz2dwzkfzvcBZha+AtJC/hoy8mHc4OkZMH2ltDSt1f97gpzpSdCPIGU4qbQjv/4NFjVpW57I9ZuKNADBe1VVGRSaK5PpoK+ldWmzWlWWY0Fo/L76o3ctgdyFWjXJCgnBcGY0UG6ZnQb2rzEH+BGExl5PFuzQvkGC4+BdsyMsPbjVROGGAOADH9avOnlW6GtqOXgbP9BkPNeW1vVpsg==
Received: from CO1PR06MB8041.namprd06.prod.outlook.com (2603:10b6:303:e4::14)
 by DM6PR06MB6460.namprd06.prod.outlook.com (2603:10b6:5:22f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40; Thu, 22 Feb
 2024 16:13:49 +0000
Received: from CO1PR06MB8041.namprd06.prod.outlook.com
 ([fe80::d814:180e:2d5c:d31c]) by CO1PR06MB8041.namprd06.prod.outlook.com
 ([fe80::d814:180e:2d5c:d31c%3]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 16:13:48 +0000
From: "Mora, Jorge" <Jorge.Mora@netapp.com>
To: "dai.ngo@oracle.com" <dai.ngo@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>
Subject: Re: [PATCH 1/1] nfstest_posix: add check for EINVAL when open(2)
 called with O_DIRECTORY|O_CREAT
Thread-Topic: [PATCH 1/1] nfstest_posix: add check for EINVAL when open(2)
 called with O_DIRECTORY|O_CREAT
Thread-Index: AQHaSW9IINrtpeCKJ0m33wRznjLfHrET896AgALM3W4=
Date: Thu, 22 Feb 2024 16:13:48 +0000
Message-ID:
 <CO1PR06MB80415138C46D80C7E1E313EDE1562@CO1PR06MB8041.namprd06.prod.outlook.com>
References: <1705514501-2098-1-git-send-email-dai.ngo@oracle.com>
 <60d031c8-fd34-4093-9ffd-0e661de306df@oracle.com>
In-Reply-To: <60d031c8-fd34-4093-9ffd-0e661de306df@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-traffictypediagnostic:
	CO1PR06MB8041:EE_|DM6PR06MB6460:EE_|CY4PEPF0000E9D8:EE_|MW5PR06MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ee6450-9405-41f3-bcdb-08dc33c143fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 RSkwvIeGWsg5wH3iEY00RlPl/+yzpf1IZ+ZL2SzEMlpLStWrfAjoCTn7d9zO7JKsSObueV2tSIz/Bc6pPMzkTqiysaD+0pHboMh+TRXkV8IJmZd2i7ZIS0jGJyhtGKC13EBV9ixBfwWeVdmx9gCyy79ITIvP0CJ5lHziMlY2rQfWP0S0JEqs+jvIhXTtAZdA0CKL6I74yahJMtnecQCo/VsS5zamg+dyLwOGH6t1a9w/0wc1+hLIax4KV2Bm6k/3kyGjQf4MnM4ShjM0leTrzfMwk70Ho/XrKw6NJVYaEwubJCP23nGY2skVOSt5PWsu9OBHedeySNnCzVqWEglS6C0p9kUuMnwU6TvJgytXGQAuUS5p+hH1olIgn3QwhEWErguSpQFnPdosKmKD2fd6N35CDF3xTZNYazgil5HKOt3AsK3YRTBruR4IcKx6bPqRzui7N9MWnNWlpDCups6W407nrRmqJewq4MhaEZEg4S5Xa7fC2urOcSKubc1rdLm+FyV5Uojhb8kNt6smGffvuBAlIRjXAaQlU1m8187fNcbu5yt0lf+JPmfpivilDZI092sCWy3ZK6ijS2sLRwBmaYfZtOyvyRHniwTbmwPpDmqSZmgMco38HamqqraWf22b
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR06MB8041.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6460
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
X-SHN-DLP-SCAN: success
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6e18c7e9-81cc-4f91-75cc-08dc33c140d6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bZ4OASBrsBISd1HQX/GKbs3fkELthA7KFwhT9rTl2e2sqXUP/pNWl5jqjo1NLpru/IkVpHC1fIK/ATQAVu0zs5nhjuFlYxSpSPmR/Br6MrR3U4RVTPQ/HAktuwzMVh04lFhIUggUr0sUBuWl3iqer959mwGrBWNuxuMuucmCQaXpW3+HAA8Gz++0lcOfGpKexW3QmOqOuRZDLtHpL+OnkfUzLL+2vsp2v0nl9fzRHXUa4OWpwkpDAKzacsk3A346vnSGAO+6WUgpu1wB1kkqsfbxvEt8YNHlQd3saQK8xojOG7DUpvx8q60bx/RKoLC22340vAsWxfRHQYsbp8Ji5d0RREAK2QyRNMveIPDObUz0B/Vw6wb41GS3DBbOaIIxvV2JOKKI+Qkk8Fa7fLosAyELckw3Iax4ojovSwq+9tp2C7COoYqGfYRVqNH1e0UWTD0iHiVf1co+hh8p5XDJ6jap5STNCwuCNGr5dwLGJb3DndUNsWlFQjOjLsz1nat0WT5omAIkciDnW3shZjOAbMMEvWi+OPJbME/1VM1e+zpEnn86hBk7sP4wyNMX+Or9yb8UZRidvnDZBtRWxuY0UzShiEmLS6v95AsKysORvMBXt4N3jGW4TD0miHdepK/r9SWQvr1wt4ZjHdpTg8eU4LmpmseSxJ3Qliyyw8W0v7s=
X-Forefront-Antispam-Report:
	CIP:52.8.140.255;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:haraka01-inline-api-pop.vpc-50c51735.usw1.shn;PTR:send1.mail.prod.i-shn.net;CAT:NONE;SFS:(13230031)(230273577357003)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 16:13:54.0259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ee6450-9405-41f3-bcdb-08dc33c143fa
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4b0911a0-929b-4715-944b-c03745165b3a;Ip=[52.8.140.255];Helo=[haraka01-inline-api-pop.vpc-50c51735.usw1.shn]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR06MB8954

Hello Dai,=0A=
=0A=
Looks good, I have pushed it upstream.=0A=
=0A=
Thanks,=0A=
=0A=
--Jorge=0A=
=0A=
________________________________________=0A=
From: dai.ngo@oracle.com <dai.ngo@oracle.com>=0A=
Sent: Tuesday, February 20, 2024 2:25 PM=0A=
To: Mora, Jorge=0A=
Cc: linux-nfs@vger.kernel.org; brauner@kernel.org=0A=
Subject: Re: [PATCH 1/1] nfstest_posix: add check for EINVAL when open(2) c=
alled with O_DIRECTORY|O_CREAT=0A=
=0A=
EXTERNAL EMAIL - USE CAUTION when clicking links or attachments=0A=
=0A=
=0A=
=0A=
=0A=
Hi Jorge,=0A=
=0A=
Have you had a chance to take a look at this patch?=0A=
=0A=
Thanks,=0A=
-Dai=0A=
=0A=
On 1/17/24 10:01 AM, Dai Ngo wrote:=0A=
> The 'open' tests of nfstest_posix failed with 6.7 kernel with these error=
s:=0A=
>=0A=
> FAIL: open - opening existent file should return an error when O_EXCL|O_C=
REAT is used (256 passed, 256 failed)=0A=
> FAIL: open - opening symbolic link should return an error when O_EXCL|O_C=
REAT is used (256 passed, 256 failed)=0A=
>=0A=
> These tests failed due to the commit 43b450632676 that fixes problems=0A=
> with VFS API:=0A=
>=0A=
> 43b450632676: open: return EINVAL for O_DIRECTORY | O_CREAT=0A=
>=0A=
> This patch fixes the problem by adding a check for EINVAL when the=0A=
> open(2) was called with O_DIRECTORY | O_CREAT.=0A=
>=0A=
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>=0A=
> ---=0A=
>   test/nfstest_posix | 7 ++++++-=0A=
>   1 file changed, 6 insertions(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/test/nfstest_posix b/test/nfstest_posix=0A=
> index 57db5d69b072..6d5fd0dfffee 100755=0A=
> --- a/test/nfstest_posix=0A=
> +++ b/test/nfstest_posix=0A=
> @@ -1232,7 +1232,12 @@ class PosixTest(TestUtil):=0A=
>                           fstat =3D posix.fstat(fd)=0A=
>=0A=
>                       if ftype in [EXISTENT, SYMLINK]:=0A=
> -                        if posix.O_EXCL in flags and posix.O_CREAT in fl=
ags:=0A=
> +                        if posix.O_CREAT in flags and posix.O_DIRECTORY =
in flags:=0A=
> +                            # O_CREAT and O_DIRECTORY are set=0A=
> +                            (expr, fmsg) =3D self._oserror(openerr, errn=
o.EINVAL)=0A=
> +                            msg =3D "open - opening %s should return EIN=
VAL error when O_CREAT|O_DIRECTORY is used" % fmap[ftype]=0A=
> +                            self.test(expr, msg, subtest=3Dflag_str, fai=
lmsg=3Dfmsg)=0A=
> +                        elif posix.O_EXCL in flags and posix.O_CREAT in =
flags:=0A=
>                               # O_EXCL and O_CREAT are set=0A=
>                               (expr, fmsg) =3D self._oserror(openerr, err=
no.EEXIST)=0A=
>                               msg =3D "open - opening %s should return an=
 error when O_EXCL|O_CREAT is used" % fmap[ftype]=0A=

