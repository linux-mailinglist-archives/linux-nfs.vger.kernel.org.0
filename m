Return-Path: <linux-nfs+bounces-2405-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 318308805AE
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 20:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559B21C20A97
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 19:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DFA3B78D;
	Tue, 19 Mar 2024 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kEN5hJ3B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sa/3UwxW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712773B2A2
	for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710878017; cv=fail; b=MI0tb1fZLlwI5M6QeelKv3dalGyskLv2jwc/YuRNeTHtlYEwkXyhFWIJwO01ki0UdXx9eaG3Z+8tdWvV6bWzreivOnLOaF3TtKaVK3rV+g7sLVMzMFCl20hZSQ5iL48xepvTgwcF897wlwqnsBcibNNg3QPf2D4RqErs+ttUZ1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710878017; c=relaxed/simple;
	bh=Vn+D32wTOm9/T5nLnGuVt57GJ1x51tFQdPpXuXQWSDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AqHUD9nIN9RBI8fYN6MLDnDDeiOKCrS8/Xyt59ue4GAQv9jUsHm1cteNM/tLsnxoWszUgzn5+XZC9X5cQeDCfCJVAqPlcem+faer0Zf8pC/G7I2SOgfOlo3bf626EahSFQ6tf80xQAO+pb94TYEJDbupyaNrmNhwP3gXCYeKUnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kEN5hJ3B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sa/3UwxW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JJDxKS005568;
	Tue, 19 Mar 2024 19:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Vn+D32wTOm9/T5nLnGuVt57GJ1x51tFQdPpXuXQWSDg=;
 b=kEN5hJ3BKC3ZUh+ZD0/VRJX1hOBSkZMuKqHpxdSo7XZmBpLJrupMc9UwOJLd/9ci7t0h
 Aq9/am/NQo0O6tVV1TyiMr2m1BqoS0VMTvSS18BLp4TDRZUmKFSOVN5WLaWUIWQeMHmg
 ZpRSoE+QBzAmbXqpCCKHnDuIV9IeyMPO06pCtDJ+x+1NOWLjZLhfOGc84r4qCfYqW0M/
 5j9Rlc3IWICgSjwNFda3O4dKgJZHS3k7TCDULTGCp6M/lyjfCq8eC2nBj0rJfZKM9X92
 Cudtmk6pAVh0iqXcxj9igy6ZEJXb9Epo0obIwnPTvST67Owdb5rSMNSpAp9HsaER5ja+ 8g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3fcpj66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 19:53:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JIrS2v007241;
	Tue, 19 Mar 2024 19:53:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6s7hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 19:53:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+Fr1rU3DSSe06dRMXlYLZxcF0JdgnBBqcUdwSh4QTfTdOvR+zW0zrIy0Vp+r8IQvmFue+5OvVV4YoG3497qb90gg3+hara+dpiBstMPlY7CZ3FDOdBhlnsaBDmFW+wIHf79+C/TxgG90QxiKhq+g6FjSI9L/nWWGUlNfvxmiQDNT1Oj6PWFdSWSURejqnih11NYz7CxiriFKBMe0JOknT+nw/Wd0U+j0Xp0AiBRruxE8O/tKIvlHnPd9qdyyz1Mi24aNalJB272h1gcuIieIKtxqzHdyVl7/tivPyTbUjqgvt8ZAIEkco4nHLqnSRZSJVHI4XH+WoCFd85jyXHvdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vn+D32wTOm9/T5nLnGuVt57GJ1x51tFQdPpXuXQWSDg=;
 b=MjFSxY6UM2ejcYGjvfYjBS4BQjlhbvlAcxAkiF4KfqCOAxV5/Kof15g/gR7BjO6825a2Q1gBapIdeb/Y2zswBwolh76TLDBMONwh2xu4nDl+ieV5PdpMihAkP3fGm8KLquzg+EW4zeqPuB2Uh0EXIfdLHHCMBmjlgVN3udYOkHhXs2D3SIOBLTIsZ+poYOdKkupG3BwjMSWoT0HgvWZRH4YfbTdhzpD4bKTIHgHH+SR6jR6ATAPrWu9AHtxVTK+Erbd3HDv9v4lOForq5Fzl7eba/H1csbuTOVRb6XXNoCpd0ZD5stW95lESrMgwPSqNnecPXE+E7hK+yb0kgSlPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn+D32wTOm9/T5nLnGuVt57GJ1x51tFQdPpXuXQWSDg=;
 b=sa/3UwxWScqGyck0uNRp4qE/hHx4RVjXMWLN0TYIjbFFlFl7AUnuC/WA9kgx4x9aJ+zbFoMyIoZGgN5Vt6A2vUzQOTmFPLKOhlCSQDrJY8S4ujv8OZDbBUWcTlMEj+R4E+xeuSwrGlSZxZE3Pf+Vv46SkycLp91O5naZIjXkUbg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4418.namprd10.prod.outlook.com (2603:10b6:303:94::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 19:53:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 19:53:24 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Josef Bacik <josef@toxicpanda.com>
CC: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] sunrpc: hold a ref on netns for tcp sockets
Thread-Topic: [PATCH] sunrpc: hold a ref on netns for tcp sockets
Thread-Index: AQHaejbLKipENm5i1E6XvqH+DJiavLE/ebmA
Date: Tue, 19 Mar 2024 19:53:24 +0000
Message-ID: <D43A77E8-44E3-45C3-B03C-1310A830855E@oracle.com>
References: 
 <512efbd56ad3679068759586c6fa9b681aec14f0.1710877783.git.josef@toxicpanda.com>
In-Reply-To: 
 <512efbd56ad3679068759586c6fa9b681aec14f0.1710877783.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4418:EE_
x-ms-office365-filtering-correlation-id: 7a9f1a82-3976-4c98-00ee-08dc484e3cb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 FoyR3C+fCPUn26K0wj161YgdN9R093MyqO6RjFAj/yTytM+g0yhO4wrnRRkgyt87VUtL5RFrTikB4mGoPskJmU11MSghqd5fYXaNnxcO5xd89hSzoHBTX8E+OUTx6Pcpo4hHkfKKwsjpZvbVj/s6ocrQDNH8UqoDSwX2xN3Y1bD7PzdncQbQauAu7D10sp3w4AeilFgUG69ezBSKPGlJ0Rvk05F9M84se0tuKxTY/yXBl2nQi7Kq/AQ6i769Wzx7Cuem3+PkvQe4Yq8BLwFcuqB1xefujdxrs38pliMBOaUrg4ux7E00NU4wr5G2hLqxmOdIZa9QbE7Ii/w0DEL5MlhV7JZmTnfAmGJx2tl84Xj3jrhk+IaiQ6rWjvUUanF82IXzebJVmHU5AESgN14G/C4OMXt7vtx5FGEVvwOBzZri4NS3HbRFedJHbTmmnoC3btb/+RzgiUIN+R6W9/7O+c+eb6+8Z/Kp9nxme4zxQTQiSUPzNd04oeNSTegZ5Z8Ou+US+XFNJyn1C3EB6p8ce4Joe71VXOMt0usa26Q/Mhruxlr6STdMoviNh5w7q7kJih+6stJ1r6DYM0/1tk6iBLTGRHogYGGqeB6IVFJJUa40BA53aPleEVYVFWfxrhW/slk4fL58/ISVkv4IQ67rTeprw39re1somrpB1jQlfHwoq3EHeU9TwrCPrqRV7krwgP30/ti/FGGYe2+8HCuqW0SAqWELOi3gxNrnXqTzLg4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OXQ0SUVqaVhlSCtlOUZoKzQyTkZKSGZVcXJSRTJpV1l5N1pyck9DZmdyNkZO?=
 =?utf-8?B?T2tEMTBZbGlodFJ6QkJJeG5Nc2RHSHF4RUJxWExucjZiSDhGa0Rid3VUQzZ6?=
 =?utf-8?B?czYrYU9vTXUrbllkOXFJcC9tL1IwK2RZd3JFVno3eWF5UnRUWTRMeUtiOGZu?=
 =?utf-8?B?V21ERTVHYUQ4TmZGaUExSXZiNWplOE16N3pDS250WVFFUmFMd2c1ZDhOSUJZ?=
 =?utf-8?B?TGpOVVVmZFNBMlNiYmd5TndDUnpCZ05qTUxSUGdUQmV0cTlWVjBnUFM0NmhG?=
 =?utf-8?B?RmJ0VWZ3cUp5Ulh5RHNKMEZXQWJDRVFmTWUyOTFjOHIwL25PZVRtNWpLdjl5?=
 =?utf-8?B?SXAxLyttMVh1TW9yMk4xViszalFjd3NQOTk0SHhXTDVmQ1FMVTJpQlhpWGc0?=
 =?utf-8?B?WFAvWXUwdGVHOUhHdldoalNhbWhUam4yUVBwZGltdXpsYnJLSjVqbGRDR3Nu?=
 =?utf-8?B?Z2M3MlIyOVFhTEZ3dzU4QjJnNGFDdHRhK3R4ciszaHp0RVFtMmRVdjE2empl?=
 =?utf-8?B?TjcyeDNnaGxJN1BJQmpNbXVPZSs4TnZQM0E0WkdrSEFZcWhVYllseDBidlls?=
 =?utf-8?B?dEtJNnJFN0RTaTMvQVRzVTRDZHhBWmk1TTFzemNWWnBQbXpHUkN4dittM01u?=
 =?utf-8?B?dUZkRWsyZzFzQi82QlZTTXdDNUJSaUE3b1NxbXV2TW43dElzWnYrd3J2Z1Zp?=
 =?utf-8?B?THlHSEduODIweWUveURqbklyaGw2ekpndVlDQmtJUnlCYXhHdFM1ZFVNS3J3?=
 =?utf-8?B?RWNJcG1tWTFjNGZyanFnL3YxV0ZvdnhkZDlFdlN1N3hnOXVoMXNJdHcveENi?=
 =?utf-8?B?c0poWjFJczdoa0QwUEFOeGczd2VXVVVIbDdDNjJIcFhNTERXZ05kNGo5M2VG?=
 =?utf-8?B?ZDRhSmVrYlJoaCtvRUs4ZVdSdkNDM1FiTEU5aVNzcGRZeVBVcTdxK1lkUFNx?=
 =?utf-8?B?eGRPY1ZJNXh6b3UwMUorY09ReUEwenpqTTZkcU9KQTVnNUd2WmhjTkVjZWQr?=
 =?utf-8?B?bXJjTTZHL1hTSFprTUtUZ2xmMzBaMDNMY1RZN0JBbUJ1U2FFcDVnVEdYT1NP?=
 =?utf-8?B?QjFpMGx4U1RDOWRuNmE0MXlQS1FjYVJNeHM0ZmlUbUNic0xrYkExbnlyc1NV?=
 =?utf-8?B?cE1JcENVNjA4M3ZSbHVnSnpFOEFkOW9VSDZOVEhwUElNaFdqNXVzblduTzZz?=
 =?utf-8?B?OG1kNGp5YkxUZ25iUEE3eFhMTVNNNGdTYTRaR0hxRmxTZ3krelNiM1pLYkcv?=
 =?utf-8?B?VFIzdnFpY09YVjFpU0UrejltSytDaHlTTE5mWGF4ZUNpY01BVG1wMkFEUWsy?=
 =?utf-8?B?WUxtMzVQVVJVdzA0L0wxZk55azduc1NCaStrS1l0dElpdjEzMkNGT3dNZGll?=
 =?utf-8?B?V1RBWUR6ZG5obUlKT0N3ekFUZGVhaUp4Wndrbjc5WnB4VlhKQVk5Tkg1STJw?=
 =?utf-8?B?QzkxNjAxd0xEZGM2TkZTR1NVbkliNUVCZVlTRndqdTNGc0loUCtCK0wxcG5T?=
 =?utf-8?B?NUlLK3U4cWRSRHFLNll2ZDlrL2MwSWswT2JCM3RYT0s3QVFhTkVyOFpPZW51?=
 =?utf-8?B?aDFvRHhlSEt0YkpWVE5DbmduZ0V6bURUVUtLcXNobXp3UHNxKzFRQlJqLzhw?=
 =?utf-8?B?b0p1Tko4NlVGd3lNZDVPQ29uY3Z6eTdadzk4ZGtaMUVReWt0eEFDZmpxOCtj?=
 =?utf-8?B?SDdtUk03MXB5OFo5K2hNVHUzRFlsTVp4Q3BUeEN4b3B2Y3V4a0xCWmdjK0NJ?=
 =?utf-8?B?ODBzTytNY3V5ZllhNGUxWU9EcHpxN1JhdDF3NkF0d253YWlJRURZbURjZTdI?=
 =?utf-8?B?V3FyRDRtbkg4LzZ5RHRMcHJUQTV2aURkWTExVkJhaG1CT1MzcXJTNStJNkMr?=
 =?utf-8?B?dDF2cGFudzNzb2hSZlcwRFNJeFp3Vmh0RTBwU1lxamticFJxb0QvS2FDN042?=
 =?utf-8?B?dXN4czdYbjZBdS94Q0NmOFNxR3NOSGFMR0x0T281VER2eFlFdFhTYTkxMTBM?=
 =?utf-8?B?dklnVFlZNXgrbTVuZzlGTlVMQjJwSDFqTzYvRThWM3FCWFJvenpRWlVPNjN5?=
 =?utf-8?B?SjF4QStmZGZhYXJlMnZCd0JVOGppRnlYQTBvMGlDRzZIUUhwTThSQ0NSaWJ2?=
 =?utf-8?B?M3YwUmlRbjF0N3RFZ2pmc3c0NWFWRnVnbm5WdDlqbnN1aWJLeWp4OGFoMUkv?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96765EC496C6EA429CD92C7ADE56AF94@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	m+dn7r1tPN7DsARpRpYb+fl0Zcf86Y5Rg9hqZb0iQCJdfqwIj5QAVmzJN5WE21NGnJHWqdXfAbMo5FgzIluaU+eiQtfkKlvWNyYlSXPOWDoRdxvK81o1LuqUx9qdieQ/v2eKFu+hUMfX3yE0qc/JYbOB1GhQ17rlRrQrzsdn0FcGKKdIiiopl+G7q0I/Mzh2aCKLUSp8cUcmDrSHCKcN0rN4Tj2cEqvx/lbvShniLJSGoqYZpl77ppp/nuCX+5R7oJUC8swnNUbWLTxgzNMEnGFOkeW2LT2CkYicbmH9At5w+AWQ493boOuri1vXDkjlhhSPkxEQXQtMCs+DvuY/z1w7PF0LsMSBPLjwpv0N+PJkIIlAcZWSaXyT6u0pWjMPjmBenSfgZEbrPrxpQ6T3HpYfswkmGVwX/2zz6Gs5Pjx1DVPOEqNqxYHuQvJn8r8tTLafYAxg1hD4APZRmvlQqT3OEXbMjus+OLEFxunZEl00NnAP80wjNaV/AUwlPWWlbt3Ahnpctbp5lUeSkrDXlE8uyq+EDMsjkkJv7HKKO2sTkhg/A5lgBAQcxru8YyPrGrSDp6NyqN6Erpf8LP9pnA2oPj/BIML4ScoDnaclfT4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9f1a82-3976-4c98-00ee-08dc484e3cb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 19:53:24.2486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0atq883ptuo1t4/7mhrrBWFO/gVsrfUzzyeJRAFNVcKeh0pjnpdX4Bt7+DYzwby8kqV069JXTJ5ALQhfCsFeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4418
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403190152
X-Proofpoint-GUID: KJrrZeJ1ZVdgsEgQSD3Z5UIujobArvoU
X-Proofpoint-ORIG-GUID: KJrrZeJ1ZVdgsEgQSD3Z5UIujobArvoU

DQoNCj4gT24gTWFyIDE5LCAyMDI0LCBhdCAzOjQ54oCvUE0sIEpvc2VmIEJhY2lrIDxqb3NlZkB0
b3hpY3BhbmRhLmNvbT4gd3JvdGU6DQo+IA0KPiBXZSd2ZSBiZWVuIHNlZWluZyB2YXJpYXRpb25z
IG9mIHRoZSBmb2xsb3dpbmcgcGFuaWMgaW4gcHJvZHVjdGlvbg0KPiANCj4gIEJVRzoga2VybmVs
IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRkcmVzczogMDAwMDAwMDAwMDAwMDAwMA0KPiAg
UklQOiAwMDEwOmlwNl9wb2xfcm91dGUrMHg1OS8weDdhMA0KPiAgQ2FsbCBUcmFjZToNCj4gICA8
SVJRPg0KPiAgID8gX19kaWUrMHg3OC8weGMwDQo+ICAgPyBwYWdlX2ZhdWx0X29vcHMrMHgyODYv
MHgzODANCj4gICA/IGZpYjZfdGFibGVfbG9va3VwKzB4OTUvMHhmNDANCj4gICA/IGV4Y19wYWdl
X2ZhdWx0KzB4NWQvMHgxMTANCj4gICA/IGFzbV9leGNfcGFnZV9mYXVsdCsweDIyLzB4MzANCj4g
ICA/IGlwNl9wb2xfcm91dGUrMHg1OS8weDdhMA0KPiAgID8gdW5saW5rX2Fub25fdm1hcysweDM3
MC8weDM3MA0KPiAgIGZpYjZfcnVsZV9sb29rdXArMHg1Ni8weDFiMA0KPiAgID8gdXBkYXRlX2Js
b2NrZWRfYXZlcmFnZXMrMHgyYzYvMHg2YTANCj4gICBpcDZfcm91dGVfb3V0cHV0X2ZsYWdzKzB4
ZDIvMHgxMzANCj4gICBpcDZfZHN0X2xvb2t1cF90YWlsKzB4M2IvMHgyMjANCj4gICBpcDZfZHN0
X2xvb2t1cF9mbG93KzB4MmMvMHg4MA0KPiAgIGluZXQ2X3NrX3JlYnVpbGRfaGVhZGVyKzB4MTRj
LzB4MWUwDQo+ICAgPyB0Y3BfcmVsZWFzZV9jYisweDE1MC8weDE1MA0KPiAgIF9fdGNwX3JldHJh
bnNtaXRfc2tiKzB4NjgvMHg2YjANCj4gICA/IHRjcF9jdXJyZW50X21zcysweGNhLzB4MTUwDQo+
ICAgPyB0Y3BfcmVsZWFzZV9jYisweDE1MC8weDE1MA0KPiAgIHRjcF9zZW5kX2xvc3NfcHJvYmUr
MHg4ZS8weDIyMA0KPiAgIHRjcF93cml0ZV90aW1lcisweGJlLzB4MmQwDQo+ICAgcnVuX3RpbWVy
X3NvZnRpcnErMHgyNzIvMHg4NDANCj4gICA/IGhydGltZXJfaW50ZXJydXB0KzB4MmM5LzB4NWYw
DQo+ICAgPyBzY2hlZF9jbG9ja19jcHUrMHhjLzB4MTcwDQo+ICAgaXJxX2V4aXRfcmN1KzB4MTcx
LzB4MzMwDQo+ICAgc3lzdmVjX2FwaWNfdGltZXJfaW50ZXJydXB0KzB4NmQvMHg4MA0KPiAgIDwv
SVJRPg0KPiAgIDxUQVNLPg0KPiAgIGFzbV9zeXN2ZWNfYXBpY190aW1lcl9pbnRlcnJ1cHQrMHgx
Ni8weDIwDQo+ICBSSVA6IDAwMTA6Y3B1aWRsZV9lbnRlcl9zdGF0ZSsweGU3LzB4MjQzDQo+IA0K
PiBJbnNwZWN0aW5nIHRoZSB2bWNvcmUgd2l0aCBkcmduIHlvdSBjYW4gc2VlIHdoeSB0aGlzIGlz
IGEgTlVMTCBwb2ludGVyIGRlcmVmDQo+IA0KPj4+PiBwcm9nLmNyYXNoZWRfdGhyZWFkKCkuc3Rh
Y2tfdHJhY2UoKVswXQ0KPiAgICAjMCBhdCAweGZmZmZmZmZmODEwYmZhODkgKGlwNl9wb2xfcm91
dGUrMHg1OS8weDc5NikgaW4gaXA2X3BvbF9yb3V0ZSBhdCBuZXQvaXB2Ni9yb3V0ZS5jOjIyMTI6
NDANCj4gDQo+ICAgIDIyMTIgICAgICAgIGlmIChuZXQtPmlwdjYuZGV2Y29uZl9hbGwtPmZvcndh
cmRpbmcgPT0gMCkNCj4gICAgMjIxMyAgICAgICAgICAgICAgc3RyaWN0IHw9IFJUNl9MT09LVVBf
Rl9SRUFDSEFCTEU7DQo+IA0KPj4+PiBwcm9nLmNyYXNoZWRfdGhyZWFkKCkuc3RhY2tfdHJhY2Uo
KVswXVsnbmV0J10uaXB2Ni5kZXZjb25mX2FsbA0KPiAgICAoc3RydWN0IGlwdjZfZGV2Y29uZiAq
KTB4MA0KPiANCj4gTG9va2luZyBhdCB0aGUgc29ja2V0IHlvdSBjYW4gc2VlIHRoYXQgaXQncyBi
ZWVuIGNsb3NlZA0KPiANCj4+Pj4gZGVjb2RlX2VudW1fdHlwZV9mbGFncyhwcm9nLmNyYXNoZWRf
dGhyZWFkKCkuc3RhY2tfdHJhY2UoKVsxMV1bJ3NrJ10uX19za19jb21tb24uc2tjX2ZsYWdzLCBw
cm9nLnR5cGUoJ2VudW0gc29ja19mbGFncycpKQ0KPiAgICAnU09DS19ERUFEfFNPQ0tfS0VFUE9Q
RU58U09DS19aQVBQRUR8U09DS19VU0VfV1JJVEVfUVVFVUUnDQo+Pj4+IGRlY29kZV9lbnVtX3R5
cGVfZmxhZ3MoMSA8PCBwcm9nLmNyYXNoZWRfdGhyZWFkKCkuc3RhY2tfdHJhY2UoKVsxMV1bJ3Nr
J10uX19za19jb21tb24uc2tjX3N0YXRlLnZhbHVlXygpLCBwcm9nWyJUQ1BGX0NMT1NFIl0udHlw
ZV8sIGJpdF9udW1iZXJzPUZhbHNlKQ0KPiAgICAnVENQRl9GSU5fV0FJVDEnDQo+IA0KPiBUaGlz
IG9jY3VycyBpbiBvdXIgY29udGFpbmVyIHNldHVwIHdoZXJlIHdlIGhhdmUgYW4gTkZTIG1vdW50
IHRoYXQNCj4gYmVsb25ncyB0byB0aGUgY29udGFpbmVycyBuZXR3b3JrIG5hbWVzcGFjZS4gIE9u
IGNvbnRhaW5lciBzaHV0ZG93biBvdXINCj4gbmV0bnMgZ29lcyBhd2F5LCB3aGljaCBzZXRzIG5l
dC0+aXB2Ni5kZWZjb25mX2FsbCA9IE5VTEwsIGFuZCB0aGVuIHdlDQo+IHBhbmljLiAgSW4gdGhl
IGtlcm5lbCB3ZSdyZSByZXNwb25zaWJsZSBmb3IgZGVzdHJveWluZyBvdXIgc29ja2V0cyB3aGVu
DQo+IHRoZSBuZXR3b3JrIG5hbWVzcGFjZSBleGl0cywgb3IgaG9sZGluZyBhIHJlZmVyZW5jZSBv
biB0aGUgbmV0d29yaw0KPiBuYW1lc3BhY2UgZm9yIG91ciBzb2NrZXRzIHNvIHRoaXMgZG9lc24n
dCBoYXBwZW4uDQo+IA0KPiBFdmVuIG9uY2Ugd2Ugc2h1dGRvd24gdGhlIHNvY2tldCB3ZSBjYW4g
c3RpbGwgaGF2ZSBUQ1AgdGltZXJzIHRoYXQgZmlyZQ0KPiBpbiB0aGUgYmFja2dyb3VuZCwgaGVu
Y2UgdGhpcyBwYW5pYy4gIFNVTlJQQyBzaHV0cyBkb3duIHRoZSBzb2NrZXQgYW5kDQo+IHRocm93
cyBhd2F5IGFsbCBrbm93bGVkZ2Ugb2YgaXQsIGJ1dCBpdCdzIHN0aWxsIGRvaW5nIHRoaW5ncyBp
biB0aGUNCj4gYmFja2dyb3VuZC4NCj4gDQo+IEZpeCB0aGlzIGJ5IGdyYWJiaW5nIGEgcmVmZXJl
bmNlIG9uIHRoZSBuZXR3b3JrIG5hbWVzcGFjZSBmb3IgYW55IHRjcA0KPiBzb2NrZXRzIHdlIG9w
ZW4uICBXaXRoIHRoaXMgcGF0Y2ggSSdtIGFibGUgdG8gY3ljbGUgbXkgNTAwIG5vZGUgc3RyZXNz
DQo+IHRpZXIgb3ZlciBhbmQgb3ZlciBhZ2FpbiB3aXRob3V0IHBhbmljaW5nLCB3aGVyZWFzIHBy
ZXZpb3VzbHkgSSB3YXMNCj4gbG9zaW5nIDEwLTIwIG5vZGVzIGV2ZXJ5IHNodXRkb3duIGN5Y2xl
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9zZWYgQmFjaWsgPGpvc2VmQHRveGljcGFuZGEuY29t
Pg0KPiAtLS0NCj4gbmV0L3N1bnJwYy94cHJ0c29jay5jIHwgMjAgKysrKysrKysrKysrKysrKysr
KysNCj4gMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9uZXQvc3VucnBjL3hwcnRzb2NrLmMgYi9uZXQvc3VucnBjL3hwcnRzb2NrLmMNCj4gaW5kZXgg
YmI4MTA1MGM4NzBlLi5mMDIzODc3NTFhOTQgMTAwNjQ0DQo+IC0tLSBhL25ldC9zdW5ycGMveHBy
dHNvY2suYw0KPiArKysgYi9uZXQvc3VucnBjL3hwcnRzb2NrLmMNCj4gQEAgLTIzMzMsNiArMjMz
Myw3IEBAIHN0YXRpYyBpbnQgeHNfdGNwX2ZpbmlzaF9jb25uZWN0aW5nKHN0cnVjdCBycGNfeHBy
dCAqeHBydCwgc3RydWN0IHNvY2tldCAqc29jaykNCj4gDQo+IGlmICghdHJhbnNwb3J0LT5pbmV0
KSB7DQo+IHN0cnVjdCBzb2NrICpzayA9IHNvY2stPnNrOw0KPiArIHN0cnVjdCBuZXQgKm5ldCA9
IHNvY2tfbmV0KHNrKTsNCj4gDQo+IC8qIEF2b2lkIHRlbXBvcmFyeSBhZGRyZXNzLCB0aGV5IGFy
ZSBiYWQgZm9yIGxvbmctbGl2ZWQNCj4gKiBjb25uZWN0aW9ucyBzdWNoIGFzIE5GUyBtb3VudHMu
DQo+IEBAIC0yMzUwLDcgKzIzNTEsMjYgQEAgc3RhdGljIGludCB4c190Y3BfZmluaXNoX2Nvbm5l
Y3Rpbmcoc3RydWN0IHJwY194cHJ0ICp4cHJ0LCBzdHJ1Y3Qgc29ja2V0ICpzb2NrKQ0KPiB0Y3Bf
c29ja19zZXRfbm9kZWxheShzayk7DQo+IA0KPiBsb2NrX3NvY2soc2spOw0KPiArIC8qDQo+ICsg
KiBCZWNhdXNlIHRpbWVycyBjYW4gZmlyZSBhZnRlciB0aGUgZmFjdCB3ZSBuZWVkIHRvIGhvbGQg
YQ0KPiArICogcmVmZXJlbmNlIG9uIHRoZSBuZXRucyBmb3IgdGhpcyBzb2NrZXQuDQo+ICsgKi8N
Cj4gKyBpZiAoIXNrLT5za19uZXRfcmVmY250KSB7DQo+ICsgaWYgKCFtYXliZV9nZXRfbmV0KG5l
dCkpIHsNCj4gKyAgICAgICByZWxlYXNlX3NvY2soc2spOw0KPiArICAgICAgIHJldHVybiAtRU5P
VENPTk47DQo+ICsgICAgICAgfQ0KPiArICAgICAgIC8qDQo+ICsgKiBGb3Iga2VybmVsIHNvY2tl
dHMgd2UgaGF2ZSBhIHRyYWNrZXIgcHV0IGluIHBsYWNlIGZvcg0KPiArICogdGhlIHRyYWNpbmcs
IHdlIG5lZWQgdG8gZnJlZSB0aGlzIHRvIG1haW50YWluZQ0KPiArICogY29uc2lzdGVudCB0cmFj
a2luZyBpbmZvLg0KPiArICovDQo+ICsgICAgICAgX19uZXRuc190cmFja2VyX2ZyZWUobmV0LCAm
c2stPm5zX3RyYWNrZXIsIGZhbHNlKTsNCj4gDQo+ICsgICAgICAgc2stPnNrX25ldF9yZWZjbnQg
PSAxOw0KPiArICAgICAgIG5ldG5zX3RyYWNrZXJfYWxsb2MobmV0LCAmc2stPm5zX3RyYWNrZXIs
IEdGUF9LRVJORUwpOw0KPiArICAgICAgIHNvY2tfaW51c2VfYWRkKG5ldCwgMSk7DQo+ICsgfQ0K
PiB4c19zYXZlX29sZF9jYWxsYmFja3ModHJhbnNwb3J0LCBzayk7DQo+IA0KPiBzay0+c2tfdXNl
cl9kYXRhID0geHBydDsNCj4gLS0gDQo+IDIuNDMuMA0KPiANCg0KSGkgSm9zZWYtDQoNClRoaXMg
aXMgYW4gUlBDIGNsaWVudCBzaWRlIGZpeC4gQ2FuIHlvdSByZXNlbmQgdG8gVHJvbmQgYW5kIEFu
bmE/DQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

