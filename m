Return-Path: <linux-nfs+bounces-5140-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A98293F754
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 16:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9F81C2193D
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 14:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2B5152787;
	Mon, 29 Jul 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NRfwEqVk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gkjcNPxM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64F114EC4E
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262230; cv=fail; b=eLwg442sFVgiIBYtj3HKBjPP0sH18Co/O4+43TfUs7hG3xl3Nm6RysXrrAAdslU++YdLQh0QRL8R4zEO63lE/fEfVY0zi5+DW9oVFcWl96fgB0z/1MCBkhqFFUWSfdECGShHscyBZGhIN0C+Pdt2cQpYcwS3h3DUZjfajhWq3WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262230; c=relaxed/simple;
	bh=h7d8ZEctdUIf8mRL4ggyjJhbtm+TWeXpxIzsXXFsNLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jkt+GKRWhdxlna116R/MlPu5qD/bw7F2zZU9IN6pXyR7k+yTKZ6wU0bXBMv6HjGDSwjSe1U8VEOid79StU5nvqH/vTFv7knkCQZBtl3mWHgT8EjOyWrsf0kg1ATHR6MC34VaxQPAH18mYDbU70NkhzhOpcsccvRtsjbvcoYFOe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NRfwEqVk; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gkjcNPxM reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T8MYdN016344;
	Mon, 29 Jul 2024 14:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=WNinq6h/0jfP1gbDlgoo4xy07j27GZx8kgmb2T7Fzxw=; b=
	NRfwEqVkU2SZmcg/2wx+lDl3lXrChZ2O+IwMgJ10VPLc57mSG0IP7p5hAL+5nVLI
	oyB3fhw0iHJ84ZEyB/tG3ftUk8l7tJDRdGI6eRVfQwZxJm6aNk22lPq1gnDqQLxA
	zsqwrVd2Dzflr3vzJozjdqrOkobGAnSh7fhhfvXRCYFUuwAhDos0u/snr7NU2RLQ
	Fw6aaovVnl4a7Gpxhpdo3TxVv4O+7OOzFd3T77qb2650VU/gJtLWXGNAOpQP9LFG
	GbCBrhbjL3YwnD53g+qYKryDp+aMHo2jppf33iWaz9oWmk0aMZ0KY8GD5fHEPMvj
	55RBObJcnesDzeOxda97xQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqfyan5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 14:10:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TD0hkj035587;
	Mon, 29 Jul 2024 14:10:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40nvnutpa8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 14:10:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLrNPp9dLcR+CFn+clqW8QL7IaR3RtRoCoAwKCMX1aCmVuUzJsh1uP1H5RlQ0UgryS0K8oE1xzdcK0a8BkUt8TYOL4VODtBheHuM20EesC+1gBwxnIQfkRzJOkb/1B7tyMZZuKtPp0CCtjrfgF3y1TJt2tzGuhnEd5sTtI4+jFAIfblSx6RewOIyXqL9pT0ixiE2wKYX5LlFnyzbtQrzLd8gUsauapEbMrLZRed5hjQMK2orTPZd/5pX8FQWnIEkkVAoUMw2xVr0kV1bfex+2k75wAukb28B7TEAlvHmCni/kw/iDJzOfdRn059JuYXpgUG5LaNTn4/px9cvPBlMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BblnBXxwzJiRDkpMiXM6Ar8jfjl0VOlzbdzoPuotA8M=;
 b=c2OobL41zcdP65wZex9i2BOiKJ47XuQllDdfKEQTmUWFFAKKXNmGryuPT+VA96X1+4gA58uzWum2RoRIlN1jsUxzUIrkIevg/Z5xy1Nuod5xriqib7kS2qE4I/7gkuxFhCgGWX8JvhwVcwQHfCRX9daSCOboWfWyj9XayvH9eXC+3qScJcnGRYtOq69TTHRVjfG7emQZ4uzjPWMT2UtwBPTYcKP0r/BXN4rntdScL6SWh+UHs7wC+d21477v9fUEhwSMOyydZrQfu+lU+HRuZrDadvEX9q1SPANIFywhJz1KOmrH70kTIR5ZCEV3n8prHWLjM4oo0ow56JwhxzvGVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BblnBXxwzJiRDkpMiXM6Ar8jfjl0VOlzbdzoPuotA8M=;
 b=gkjcNPxMnrDUjy7zslcUVlQuPg+nQBra1+cKa49Iu6nFXsfK9nePSVRnkceVRc9K6UCtNVp4LsMq2TR4b14zJf/0Bt45IGdF5r8uIU373pzt6bTCGjGK9uYihBWtQ01O6GJSIBc/z4LVj4OIfnXHTKEe9q2j2dxOJwHmacwZSyw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4189.namprd10.prod.outlook.com (2603:10b6:208:1de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 14:10:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 14:10:04 +0000
Date: Mon, 29 Jul 2024 10:10:00 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] nfsd: Offer write delegations for o_wronly opens
Message-ID: <ZqeiuJetrBCKfNvS@tissot.1015granger.net>
References: <20240728204104.519041-1-sagi@grimberg.me>
 <20240728204104.519041-3-sagi@grimberg.me>
 <81765320f56c349298be08457ef2211a581c29f9.camel@kernel.org>
 <6a78bd6b-b5c4-489c-a7dd-bd688fed8d94@grimberg.me>
 <cb6cf6834ca3383804b7bd994eeaf310cfbf8c78.camel@kernel.org>
 <0fc73dce-1ab1-4229-a81e-3c058e2bcee3@grimberg.me>
 <ZqeetZx5MjiSnu5J@tissot.1015granger.net>
 <92b8506f-05fe-4ad1-abb4-d2a269041352@grimberg.me>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92b8506f-05fe-4ad1-abb4-d2a269041352@grimberg.me>
X-ClientProxiedBy: CH0PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:610:cd::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: a377814b-d6c4-4896-9e46-08dcafd824ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?T4nhqYtyy01s6839ES4i73JufOxXXUSsKKdStO+nq57B9N73UwQX/mSTfH?=
 =?iso-8859-1?Q?lpix8FJAji/Hmes509QvAvR2o3XpuRal2/1SoSewr+71pSNbAUTypLb3to?=
 =?iso-8859-1?Q?Oj/Wh5cfskgoXr2sow1KNCzGJ6YZxtHIDGuRSjXr+Xww2syHjS35m7edq4?=
 =?iso-8859-1?Q?oSFuxCSsmPLa2jrmcGxULk4s8KYNVfon3ohTdj/0tjTigipxICWCB5otXi?=
 =?iso-8859-1?Q?xHHk+9cu3nJ46do0pMT3pkMvb17TPVIaDtpokKwiBGKGZ2UwQkCVdA15P9?=
 =?iso-8859-1?Q?UCfUE7oeeG0Vyn9n8iSlWKNmUFdMW33IVCUYl0GpZ6Ei2hZ8lENeRFZDEE?=
 =?iso-8859-1?Q?DO+64RWuXPW7N4hCtBV7K/m1CM5ooY7yr1swfKbIpGlVKlGRfny5PsqDMG?=
 =?iso-8859-1?Q?51/QQ2InnfDG3jsSNWPsvd6q1ULeE9dDD4DM1QhB83zCW0L1HCtPUMtoHP?=
 =?iso-8859-1?Q?ub8BXPySEN68p4Az7S2Amed/oLBgazj9zSoHuuVsXdGrBX4F3tS9u00I63?=
 =?iso-8859-1?Q?sG7ks+QSZ+rOe0Xf3RPweIhVMCVOElhL8K5edpVEuhtoRw6a7EvGbouUwp?=
 =?iso-8859-1?Q?dzSVUIKli/bL0xy0s21PvtVuJGtEtTr8j8oJF+NCV1+slMIyum5iExTyoF?=
 =?iso-8859-1?Q?jYU46s+M2ahNBE6k5xBFIgCeR2sS+hrbsQysMAJXpeWhkXd9NWlzwBBmTI?=
 =?iso-8859-1?Q?TedNVb4n+Ha0EcFReWYSvskB2HVdvQo4IF9JgJVhAbJgIWyu37d13NDDp9?=
 =?iso-8859-1?Q?oxjVOT6qC2+HANGssF88EjdvsDdO7eVqMHJGV/M6o/eln/zKvsC+ke0AQS?=
 =?iso-8859-1?Q?4HRYHhkmcbhHUiEE6IHHc/mLLV9xU90P4bbggB0gv1oO3l/OreLr8zFfa4?=
 =?iso-8859-1?Q?cag8BRPlgXB/B+JXF0N2E0IyowKwOny7ummLY9XjExxwXrNN1bNr41wY6j?=
 =?iso-8859-1?Q?erbnvcZ+/8rmWig1HecwPPDc/IS29ABn4BLkH25E+n1+AzRzMIkEDxyo3s?=
 =?iso-8859-1?Q?VV3wyVTQl1tpXIUbpNuW48p2rAzCUiO642QC9E3jdnjpQqtBLvtlyXSTHD?=
 =?iso-8859-1?Q?zlRig0rCUmxNfBTGYXFmDD/ja446rNP92Rty2XY7rDJJkW3LQjXXkVt8vW?=
 =?iso-8859-1?Q?tk5FzcziEqO4uDeuWZ1ej5WED3sGuFoE1ipG2cAxMiMdfHH54ziFzBoKaa?=
 =?iso-8859-1?Q?yF+2rLea3qtz04lH1X1M+X+oOZTA7eNDabbVvTXxsREGkeg4pMzAAZ2dm8?=
 =?iso-8859-1?Q?MjFJ/31x50Dc4LMV3Sk84TMom485xCOrM6+aAUHpQqgNt9wdkROzF4YsUx?=
 =?iso-8859-1?Q?LNaKEp/migqvRFfDaPG/2xp4tyIDng322W7GyPbDqG0cyiU1/jxBjRSao/?=
 =?iso-8859-1?Q?Ar/S8uTWAcKuEMUT/1BP1VpcjLrQ6Inw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?gjfNtKS1KlD6yajiTOh6kZyKDm1AKN0LfplesQ61WmrN8FJ/kMtK+iEhCH?=
 =?iso-8859-1?Q?tnu9o9NY23tSaUnF1f6kzUXOzO+hOlLJBMYKk32ekzVOpwGX1rALNCBQ91?=
 =?iso-8859-1?Q?FMsJPyswXNlklCkIRwSJJEM2ixwRlPHoIvw1hvOy3cQtSo6ju9wcV2/+zd?=
 =?iso-8859-1?Q?PbDZU7fcP7MRhMT0jILD1iEXBr3hH1R/IpWXThc+7pGN3/woQU0DE2SjfZ?=
 =?iso-8859-1?Q?YNLUAgZQGRu+RH/jhDvbDfOb8sOtptgzEHuWAF2VaAnkIID7y5CO9cc+dp?=
 =?iso-8859-1?Q?hk+K4Us+zYt3fNZeS0m+op7F9AM17CucrxNTlRMMY4iwtmzXmTDe6+dgaZ?=
 =?iso-8859-1?Q?ktNCnjWH7g4+52+bb0bS6+K5GZb3EKLObGkdG0FUy+9/L7RxpqCUcPP2+c?=
 =?iso-8859-1?Q?gaKXufKSYM9g6sFp3ofw9WgwHrYlr7mHXclyUcB22OZQQ/EQ6jlqSbYT6+?=
 =?iso-8859-1?Q?YuKEtsjpeAJ2XnOWwsfK3ToZwkLFbCFajhJUMqiRpg6HkY+WvYZgaod4aL?=
 =?iso-8859-1?Q?94M1MFD5E7N6MlqzSW0GVqs7QU0YtnsTsyzCXOGzCZQM3fE58QHr6FU+76?=
 =?iso-8859-1?Q?cnvzK1p3KXgIGOpiySs52Vsi+3gMlIxS7CIOvQgVznv85UlmAdcJpumW/x?=
 =?iso-8859-1?Q?3jaRjxNhCFmZHlwv0wx/fIQSBwawII2pZY3FvSZAQ+0kbEb9t8PDd6rGvy?=
 =?iso-8859-1?Q?epJ5/1yc/ZDSTGYgCM7ma3utAuj/qxPkdwGiaE7eGD4GA2xZjSWoR/F6R2?=
 =?iso-8859-1?Q?8K9Zrou7gKxZDSgZEuh4oww2pNw327xztUKVthWly15dyGUt7oujQAOt/e?=
 =?iso-8859-1?Q?N4rk09sU97ZIY+X3gxm6UzET1wgZ6mv+pQOQtzXexHuczDLcgeIKdhPujk?=
 =?iso-8859-1?Q?dG0V058otznqSKaSXHCvfq+FNX1SowYRoxfUR+ndlcDq3c40sPeY8gj3Oy?=
 =?iso-8859-1?Q?b+7TfGlAUkhiD0Mg5rDGdXNO+Uui2MrHVnKzmD+2gXMsRYq+W/K6D5SSDM?=
 =?iso-8859-1?Q?BybKoJHvLeHUhVbC1Rn5DHP77DqouxIAeZ7cge4oiDFMNRYxAQc1B1L6oH?=
 =?iso-8859-1?Q?DhJunQ0/y7hByexdsJNTUTDgGgI8OOnnUX6oW/iUq7QAbB8VCcXB48kd8u?=
 =?iso-8859-1?Q?DzmI8ZORycg63NccNiCpqWOxjvBhtvQVKIu1IcWY4zAceeO4sNxYiq2sgJ?=
 =?iso-8859-1?Q?kcjBftmhQyaVPKDqaSChizx2res8WQ6HWCqFUxyNGknK707eb+inJcerRS?=
 =?iso-8859-1?Q?BFA2y6UtRb5Ga+HdpbROusmo3yRNulY6Pg88H1XPQB0UMjb83cVgZc1Xwz?=
 =?iso-8859-1?Q?xAkKQrbBX+Zn6GnJ5HnfnZRCWxckXmzTvP3Y5M0PuI+I0FhtxUU9nl9rBA?=
 =?iso-8859-1?Q?TTcCUxStz0RCaQlChyjBt0NX8KfXJVk4yR6NoT/+G0y9+26zU3W8reIWyj?=
 =?iso-8859-1?Q?nT5VEmuOMrL7eq5cdW9PFpIiuKsylKqf63sBCCcdbnmws3MfUlrExbTXTm?=
 =?iso-8859-1?Q?F6nJTnGSst+llBF28tSvERf3JEZB5Sesxt6DPX+6nTCUvGRuqEVBZQVeHg?=
 =?iso-8859-1?Q?lKzaj/uf1yI7iSH6dU+QzowzDhzJrVd5lK75S7ya64HVEWOJS2yYUI2cS1?=
 =?iso-8859-1?Q?f79558EF3ByhCi0c30JtJ1RZro11EjOeBc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UTxGOZICxOUrMNf3lHkfuY4cQR7sn4qGMSJk08e9dwN6oJl3JbcCVTKqvHFxH+SGyAf2JSAxM74N3WbKdfON4x8j/9zLIeoYTQmK8q8P4IDseptnbY5JXja9lJYWHqZdICTpLcbtAKnpOROa4FdpV0U7nfNouemYxfUvc/g33DXmJTji0s5tyTNDH3vVcF4LtfHtYREvN0p8HCpUUYTPLIVDFqPB/TvGqORBnCrw2ybXljyx/I9PL/YN5XhXLyhjJDTcR3Li59rDZyIPaWNJUNXFfI5IN9VzxzVE8iygG5rrxx+2T1PgjQyr9xZWg+kea6J32Aq/mld26cPjice7Y3hF9JXbQW4AQBa/KVaKqP3mUBDOxR6rMDH6oD+WFxUmfDCmS1vF7iri201yNyQfBJS78EirX8uAZweXVcOql24x38kcxCV8GYphnGDqZqZVAg8BOrMwX7uAfFExt4FqUUyhU7mP6NdSrSAUncSU+DcOHsyExEkClr4NGLyZIlpr8re13/A+GcXld6dY4h8xYrrvMYPp+NoyyYWEWKxQJ8REjpc17HahZhD+pVqalycIs15D7udUSyfSr9DRRpnCsyBvpcV25pG8WEVtjj0i5RA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a377814b-d6c4-4896-9e46-08dcafd824ab
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 14:10:04.4219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHtU4XwCfC8Rx8EF9/2WFk/pyPGkwcvtx97uBPNV8oyaRmsAlvtYSWNwCrVe3dFqisvnMwduzLjpPy3FiQIDCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407290095
X-Proofpoint-GUID: hO5HAAAjusplMSF7u40JCKMd-c6Iaui2
X-Proofpoint-ORIG-GUID: hO5HAAAjusplMSF7u40JCKMd-c6Iaui2

On Mon, Jul 29, 2024 at 05:05:13PM +0300, Sagi Grimberg wrote:
> 
> 
> 
> On 29/07/2024 16:52, Chuck Lever wrote:
> > On Mon, Jul 29, 2024 at 04:39:07PM +0300, Sagi Grimberg wrote:
> > > 
> > > 
> > > On 29/07/2024 16:10, Jeff Layton wrote:
> > > > On Mon, 2024-07-29 at 15:58 +0300, Sagi Grimberg wrote:
> > > > > 
> > > > > On 29/07/2024 15:10, Jeff Layton wrote:
> > > > > > On Sun, 2024-07-28 at 23:41 +0300, Sagi Grimberg wrote:
> > > > > > > In order to support write delegations with O_WRONLY opens, we
> > > > > > > need to
> > > > > > > allow the clients to read using the write delegation stateid (Per
> > > > > > > RFC
> > > > > > > 8881 section 9.1.2. Use of the Stateid and Locking).
> > > > > > > 
> > > > > > > Hence, we check for NFS4_SHARE_ACCESS_WRITE set in open request,
> > > > > > > and
> > > > > > > in case the share access flag does not set NFS4_SHARE_ACCESS_READ
> > > > > > > as
> > > > > > > well, we'll open the file locally with O_RDWR in order to allow
> > > > > > > the
> > > > > > > client to use the write delegation stateid when issuing a read in
> > > > > > > case
> > > > > > > it may choose to.
> > > > > > > 
> > > > > > > Plus, find_rw_file singular call-site is now removed, remove it
> > > > > > > altogether.
> > > > > > > 
> > > > > > > Note: reads using special stateids that conflict with pending
> > > > > > > write
> > > > > > > delegations are undetected, and will be covered in a follow on
> > > > > > > patch.
> > > > > > > 
> > > > > > > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > > > > > > ---
> > > > > > >     fs/nfsd/nfs4proc.c  | 18 +++++++++++++++++-
> > > > > > >     fs/nfsd/nfs4state.c | 42 ++++++++++++++++++++------------------
> > > > > > > ----
> > > > > > >     fs/nfsd/xdr4.h      |  2 ++
> > > > > > >     3 files changed, 39 insertions(+), 23 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > > > > index 7b70309ad8fb..041bcc3ab5d7 100644
> > > > > > > --- a/fs/nfsd/nfs4proc.c
> > > > > > > +++ b/fs/nfsd/nfs4proc.c
> > > > > > > @@ -979,8 +979,22 @@ nfsd4_read(struct svc_rqst *rqstp, struct
> > > > > > > nfsd4_compound_state *cstate,
> > > > > > >     	/* check stateid */
> > > > > > >     	status = nfs4_preprocess_stateid_op(rqstp, cstate,
> > > > > > > &cstate-
> > > > > > > > current_fh,
> > > > > > >     					&read->rd_stateid,
> > > > > > > RD_STATE,
> > > > > > > -					&read->rd_nf, NULL);
> > > > > > > +					&read->rd_nf, &read-
> > > > > > > > rd_wd_stid);
> > > > > > > +	/*
> > > > > > > +	 * rd_wd_stid is needed for nfsd4_encode_read to allow
> > > > > > > write
> > > > > > > +	 * delegation stateid used for read. Its refcount is
> > > > > > > decremented
> > > > > > > +	 * by nfsd4_read_release when read is done.
> > > > > > > +	 */
> > > > > > > +	if (!status) {
> > > > > > > +		if (read->rd_wd_stid &&
> > > > > > > +		    (read->rd_wd_stid->sc_type != SC_TYPE_DELEG
> > > > > > > ||
> > > > > > > +		     delegstateid(read->rd_wd_stid)->dl_type !=
> > > > > > > +					NFS4_OPEN_DELEGATE_WRITE
> > > > > > > )) {
> > > > > > > +			nfs4_put_stid(read->rd_wd_stid);
> > > > > > > +			read->rd_wd_stid = NULL;
> > > > > > > +		}
> > > > > > > +	}
> > > > > > >     	read->rd_rqstp = rqstp;
> > > > > > >     	read->rd_fhp = &cstate->current_fh;
> > > > > > >     	return status;
> > > > > > > @@ -990,6 +1004,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct
> > > > > > > nfsd4_compound_state *cstate,
> > > > > > >     static void
> > > > > > >     nfsd4_read_release(union nfsd4_op_u *u)
> > > > > > >     {
> > > > > > > +	if (u->read.rd_wd_stid)
> > > > > > > +		nfs4_put_stid(u->read.rd_wd_stid);
> > > > > > >     	if (u->read.rd_nf)
> > > > > > >     		nfsd_file_put(u->read.rd_nf);
> > > > > > >     	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> > > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > > index 0645fccbf122..538b6e1127a2 100644
> > > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > > @@ -639,18 +639,6 @@ find_readable_file(struct nfs4_file *f)
> > > > > > >     	return ret;
> > > > > > >     }
> > > > > > > -static struct nfsd_file *
> > > > > > > -find_rw_file(struct nfs4_file *f)
> > > > > > > -{
> > > > > > > -	struct nfsd_file *ret;
> > > > > > > -
> > > > > > > -	spin_lock(&f->fi_lock);
> > > > > > > -	ret = nfsd_file_get(f->fi_fds[O_RDWR]);
> > > > > > > -	spin_unlock(&f->fi_lock);
> > > > > > > -
> > > > > > > -	return ret;
> > > > > > > -}
> > > > > > > -
> > > > > > >     struct nfsd_file *
> > > > > > >     find_any_file(struct nfs4_file *f)
> > > > > > >     {
> > > > > > > @@ -5784,15 +5772,11 @@ nfs4_set_delegation(struct nfsd4_open
> > > > > > > *open,
> > > > > > > struct nfs4_ol_stateid *stp,
> > > > > > >     	 *  "An OPEN_DELEGATE_WRITE delegation allows the client
> > > > > > > to
> > > > > > > handle,
> > > > > > >     	 *   on its own, all opens."
> > > > > > >     	 *
> > > > > > > -	 * Furthermore the client can use a write delegation for
> > > > > > > most READ
> > > > > > > -	 * operations as well, so we require a O_RDWR file here.
> > > > > > > -	 *
> > > > > > > -	 * Offer a write delegation in the case of a BOTH open,
> > > > > > > and
> > > > > > > ensure
> > > > > > > -	 * we get the O_RDWR descriptor.
> > > > > > > +	 * Offer a write delegation for WRITE or BOTH access
> > > > > > >     	 */
> > > > > > > -	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) ==
> > > > > > > NFS4_SHARE_ACCESS_BOTH) {
> > > > > > > -		nf = find_rw_file(fp);
> > > > > > > +	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> > > > > > >     		dl_type = NFS4_OPEN_DELEGATE_WRITE;
> > > > > > > +		nf = find_writeable_file(fp);
> > > > > > >     	}
> > > > > > >     	/*
> > > > > > > @@ -5934,8 +5918,8 @@ static void
> > > > > > > nfsd4_open_deleg_none_ext(struct
> > > > > > > nfsd4_open *open, int status)
> > > > > > >      * open or lock state.
> > > > > > >      */
> > > > > > >     static void
> > > > > > > -nfs4_open_delegation(struct nfsd4_open *open, struct
> > > > > > > nfs4_ol_stateid
> > > > > > > *stp,
> > > > > > > -		     struct svc_fh *currentfh)
> > > > > > > +nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open
> > > > > > > *open,
> > > > > > > +		struct nfs4_ol_stateid *stp, struct svc_fh
> > > > > > > *currentfh)
> > > > > > >     {
> > > > > > >     	struct nfs4_delegation *dp;
> > > > > > >     	struct nfs4_openowner *oo = openowner(stp-
> > > > > > > > st_stateowner);
> > > > > > > @@ -5994,6 +5978,20 @@ nfs4_open_delegation(struct nfsd4_open
> > > > > > > *open,
> > > > > > > struct nfs4_ol_stateid *stp,
> > > > > > >     		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
> > > > > > >     		dp->dl_cb_fattr.ncf_initial_cinfo =
> > > > > > >     			nfsd4_change_attribute(&stat,
> > > > > > > d_inode(currentfh->fh_dentry));
> > > > > > > +		if ((open->op_share_access &
> > > > > > > NFS4_SHARE_ACCESS_BOTH)
> > > > > > > != NFS4_SHARE_ACCESS_BOTH) {
> > > > > > > +			struct nfsd_file *nf = NULL;
> > > > > > > +
> > > > > > > +			/* make sure the file is opened locally
> > > > > > > for
> > > > > > > O_RDWR */
> > > > > > > +			status = nfsd_file_acquire_opened(rqstp,
> > > > > > > currentfh,
> > > > > > > +				nfs4_access_to_access(NFS4_SHARE
> > > > > > > _ACC
> > > > > > > ESS_BOTH),
> > > > > > > +				open->op_filp, &nf);
> > > > > > > +			if (status) {
> > > > > > > +				nfs4_put_stid(&dp->dl_stid);
> > > > > > > +				destroy_delegation(dp);
> > > > > > > +				goto out_no_deleg;
> > > > > > > +			}
> > > > > > > +			stp->st_stid.sc_file->fi_fds[O_RDWR] =
> > > > > > > nf;
> > > > > > I have a bit of a concern here. When we go to put access references
> > > > > > to
> > > > > > the fi_fds, that's done according to the st_access_bmap. Here
> > > > > > though,
> > > > > > you're adding an extra reference for the O_RDWR fd, but I don't see
> > > > > > where you're calling set_access for that on the delegation stateid?
> > > > > > Am
> > > > > > I missing where that happens? Not doing that may lead to fd leaks
> > > > > > if it
> > > > > > was missed.
> > > > > Ah, this is something that I did not fully understand...
> > > > > However it looks like st_access_bmap is not something that is
> > > > > accounted on the delegation stateid...
> > > > > 
> > > > > Can I simply set it on the open stateid (stp)?
> > > > That would likely fix the leak, but I'm not sure that's the best
> > > > approach. You have an NFS4_SHARE_ACCESS_WRITE-only stateid here, and
> > > > that would turn it a NFS4_SHARE_ACCESS_BOTH one, wouldn't it?
> > > > 
> > > > It wouldn't surprise me if that might break a testcase or two.
> > > Well, if the server handed out a write delegation, isn't it effectively
> > > equivalent to
> > > NFS4_SHARE_ACCESS_BOTH open?
> > It has to be equivalent, since the write delegation gives the client
> > carte blanche to perform any open it wants to, locally. The server
> > does not know about those local client-side opens, and it has a
> > notification set up to fire if anyone else wants to open that file.
> > 
> > In nfs4_set_delegation(), we have this comment:
> > 
> > >        /*
> > >         * Try for a write delegation first. RFC8881 section 10.4 says:
> > >         *
> > >         *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
> > >         *   on its own, all opens."
> > >         *
> > >         * Furthermore the client can use a write delegation for most READ
> > >         * operations as well, so we require a O_RDWR file here.
> > >         *
> > >         * Offer a write delegation in the case of a BOTH open, and ensure
> > >         * we get the O_RDWR descriptor.
> > >         */
> > I think we did it this way only to circumvent the broken test cases.
> > 
> > A write delegation stateid uses a local O_RDWR OPEN, yes? If so, why
> > can't it be used for READ operations already? All that has to be
> > done is hand out the write delegation in the correct cases.
> > 
> > Instead of gating the delegation on the intent presented by the OPEN
> > operation, gate it on whether the user who is opening the file has
> > both read and write access to the file.
> 
> Umm, I'm a little unclear on what is the suggestion here Chuck. You mean
> checking the openowner permissions to access the file?

Yes. OPEN already does that. Can this user access the file for read
and for write? If yes, this OPEN is eligible for a write delegation.


> If so, won't buffered read-modify-write be a problem ?

I'm not sure what problem you're referring to.


-- 
Chuck Lever

