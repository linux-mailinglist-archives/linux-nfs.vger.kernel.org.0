Return-Path: <linux-nfs+bounces-224-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8877FF882
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 18:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612132817AA
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 17:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEE858122;
	Thu, 30 Nov 2023 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bl96SCNh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FJYdsG/a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF0010F4;
	Thu, 30 Nov 2023 09:40:09 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUHMYK8022053;
	Thu, 30 Nov 2023 17:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=Z1YtHh5JQrH8A+MM/eOWr/PXga3BzU3ruhOSVZy0r+0=;
 b=bl96SCNhtacXv45fWHZOo7bt6xEUCLWVfwcry5NXF/R72QgPyb34lpuFqdl7OSIhENlf
 WPEVq8IQLwcyV9AkJUFQPkPXvvAXMBVqtUTYs5hw0WQzE7xO6tgDBUbon2ItlxrcI/EV
 EtfgQE0WW3VaiAPsIP4KPWwnsbYhL9zvHH/ypjC65Jfn3nYSlWJecv/OdhZvzfmPUiHu
 hZrIjVGIs5T5aQrt/FP4VSYwKc7g/Gx+6kuwII+8LUEmI0fd0nHjOy6pYxaB/FmbNMSx
 HcvYIhHCf6tpJBGh20MXXH9O0jHP6AqN046Sg+znIe9GzMIgum2FT1juhgiBWUWgUf0G Sg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3upxqwr2c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 17:39:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUGTf6H009626;
	Thu, 30 Nov 2023 17:39:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cae85p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 17:39:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1E2Ws4gW3KCaRB4deXGkzylsgdEWU8in67AH69a/Jjt0bzt0Uq2UBOlBX9i8sNwJeNLlxx8GkgLtZKx5HfSd7T91I+h8C5dcUTPZdQ5S2bnTIeYAGWwXlPnGiaxqhHleqavIMAmI7CCH6Mdkd2hAU8LNtLQqccuKOSPYhpbSfFexrKNPaFKlEA0CgOLztUyLqBsRA+wEy+EpW/0Kd0aNWK3zxxbiEDePcfkJ/sbBvlJIOn/YkAszLhS3jNEkZqfgo++3M/GSmB81PAgk4Axp5B1MigAcLaOUUNC7GYkSxaGLVXCxeqIaBRA8Xc5dkiUsHehtWbHAD7kuBBNxWGNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkbO2hhCirCq++1FCsyMGuB7kcyiiAcF/TSU8QHHS3o=;
 b=KCXhigRy7z0t5jX/dUi2+LvUEhD+017jLkVfce+LkLExRr3gUHB0jrd3WK8bsxi86PLrt4M9pmU+ECBpPUbjvqBqSMOwR9XqOWuD3YWopDIPAcfS/1BWmuap1K7tRRN1+75P/ENYZPg8yxTZDd8XYzVWUAVM8dBkKVsuw3Kn9dXGsbGGjonI7tGYtadepSrxmEsCX8a1bImQP9p+tlNAzWAZfNohv/0z9Av4aXIkTpsXzT6w3MNjA1l2YxIx1oI2tHLmuAcOo7l2jx+LVxoWp/oLgujS9XThFBlShICFUH5pudu45nc2l5mPmQu+tFDZUAfkQ4XvwTs1qYNWB8u7Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkbO2hhCirCq++1FCsyMGuB7kcyiiAcF/TSU8QHHS3o=;
 b=FJYdsG/aIOAop/B+cdVygeS8JEwA7fm4mKmYsCX9Ibo5Px/4v44rp0Ddt+e6oXcgBFaryVCoZOgHjjdgq3FV6AX7AA7sG0APIyt4UQvgwbFjf7HcX+Flo/A4/unNMF5WH6XbBeu93W9N0O96Y5isV6MV0RHffT5fj6v7V08TU8Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7699.namprd10.prod.outlook.com (2603:10b6:806:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 17:39:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 17:39:56 +0000
Date: Thu, 30 Nov 2023 12:39:54 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        lorenzo.bianconi@redhat.com, neilb@suse.de, netdev@vger.kernel.org,
        kuba@kernel.org
Subject: Re: [PATCH v5 3/3] NFSD: convert write_ports to netlink command
Message-ID: <ZWjI6ppENVu2FPIo@tissot.1015granger.net>
References: <cover.1701277475.git.lorenzo@kernel.org>
 <67251eabfbbccb806991e6437ebcf1cf00166017.1701277475.git.lorenzo@kernel.org>
 <7b21c962c2a6c552c9807d6f382e1097da4ba748.camel@kernel.org>
 <ZWhcc8384pf11sAu@lore-desk>
 <c87becd9af15ad9447030c17dee9c481a8d25442.camel@kernel.org>
 <e85381f3d7575d8784f54c5a3abdb60be190c4af.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e85381f3d7575d8784f54c5a3abdb60be190c4af.camel@kernel.org>
X-ClientProxiedBy: CH5P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: 0150b057-f865-4822-745d-08dbf1cb5e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NiiPzljYrWMzd6EWmkwfyhSM9cW+z9+jRZXHRcYfiV3hTnqSP4r3UeXE2TZgB26k2taOqidyl1qVBdbJFQgjxaW+0T9UPfE5ZHLVhCWI1OzXUJA+BhPwuBbP430YQUFShM9PaIQXjWBVcFnxChRRKENIc97irpDrnd4iKTdARDR8zJdAPAPVxoxjJp4jHnwboqebsxCEFt307/HU0cxz0VSu57jtn0EsoRdsgi4192d49sHEvOYG/IFBnBHirus0QMWyFX5zktKA6t7QpuI/Nf1b6C8VhIBhF/dtvsfMoo4unu8/3Ar1AcwXf9KleYVsajWyTQFqk3qO+/K+x+06n/V/jm7/Nebh2LENis74X/XC8sPFoNTwzqQ+mfqt5qChAworcWP+HSGtRvcTmKv9UrZVL/q0yYNHau/81K/Orv996qsJMWmwEbdpHSm9f+IIJKj3D3co1R3wRp3qi3SuPtG03SckBR5mFoYbz30XpBIAYQb0+zSxQBgvzJxeePAumjpMjPJg9Xt6tRPvnmf4MZKwkbKRlc59yIuKGmvYYSYqQQi7yv7uPLzZRTpo0Nu3
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2906002)(4001150100001)(86362001)(5660300002)(83380400001)(9686003)(38100700002)(6512007)(6506007)(26005)(6486002)(44832011)(41300700001)(66556008)(4326008)(8676002)(66476007)(66946007)(6916009)(478600001)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?R89WZmlxJpvsvwccq5wU6GRbcW8rzK7yssTd5E+zPo1j0lDHpDaMFQERBo?=
 =?iso-8859-1?Q?tlby0YrMx5LNtEYjiFKtNnSwXdtuGoz+dAbgHwZN7UKP8DUjRHioTG6urn?=
 =?iso-8859-1?Q?y/qUgZN4ji3dyErCwh+bDXXiWd9YpeA85MIgW8y240RWS5FRZcuZ2gr72y?=
 =?iso-8859-1?Q?wQrjSvgDWaKRfGgDOViDlyfHcyk25Kl8C5kyb+rjnyn1L+Wml+4ZWcRpID?=
 =?iso-8859-1?Q?uSHVjT9wx3LLTg6X7DoIWgsu01LXqixRhMPAcDoIP2dOmAOrgF7/cEwgJo?=
 =?iso-8859-1?Q?ITtu++W0LceSgFKih/Ay9QrMOsPqqd97mbK5gBwiO+/iggxinxOqyoXsjY?=
 =?iso-8859-1?Q?SoH5Yt+678gTx0fue3jRQH9FoUEE0iDz1byF1s17KhK6nOA/iLLMK8/NPN?=
 =?iso-8859-1?Q?Yl1H/GdkZtS9Rwq71WRHmj9MHviHTu0XIYUFChGOuqxlplY+JiQQr492f5?=
 =?iso-8859-1?Q?FafsmX9VNDMm8OJv+OYuhkpP9E/5aNmfdNWEG0uzfwjMqD9/nRt46SmMz9?=
 =?iso-8859-1?Q?uKcNuPuIu9E9HqYO3IrFuZJm2Ii+kv1DWJx+yGMuvy0BHhYUPCD65vWOkt?=
 =?iso-8859-1?Q?EDhDOjzwamuGpo6pktkdvQbdqF2I4rxDpMHMVtzouM7MkPmVhrq8+cVfoR?=
 =?iso-8859-1?Q?8cRErei6lZBLfBSxB+ztfvLgDnQqF9y/cq8X8a382Ys+3tMBVCOGrE66Cj?=
 =?iso-8859-1?Q?txyy6SWaPTwstJxWfAiDExqSSQ8V9JanEg0H4uiBAu53PCkWwITceK3ZhU?=
 =?iso-8859-1?Q?v1fmexKMPlXEyD1g7Gt0hT3ss14a2E9je+ye3vLXuezFls1ejylFBhBzJF?=
 =?iso-8859-1?Q?FWrYQeBf2xdq0LxqI7WTJXQNWIkSXPV90ZZAvF7FiyNyu3V5gYL6YBcV9K?=
 =?iso-8859-1?Q?hUWVoTpW97b4WgoUBWoxmqPS1uAdvvrNlYUXSsA7l/kHCriLQck3D2tzww?=
 =?iso-8859-1?Q?0wMdgh38JHiHWRPJovZUQaS1HGbwdrEibkGVtdDh60Ddi+kyy96bv6Zk6v?=
 =?iso-8859-1?Q?55GJWkbM5sCnjU5kJYOaZf4YXDJ9nu926MX+a3bJuDjQO/dT3NlTI+vo0E?=
 =?iso-8859-1?Q?8+O9CmFDpLewJhQPmAVGkEy7fBUV0JOLOfJefj/imIu8GePvAWjkTBvwPV?=
 =?iso-8859-1?Q?W+1jtUN66ZuDG6qrFGvIYT97c8L0TK1TDC02ob9d1DKHh2j4MJ8duiRpVg?=
 =?iso-8859-1?Q?UI0o2VarQDTukI+Olq8IwWexcXI81SRAY7pZ7oD2o0hBNGt+xveaU6xbcg?=
 =?iso-8859-1?Q?n3IjgCen51LEU5t8WEW44nmsezd/6OEtEBtOk7z3SDJBUG10BALftdsuqj?=
 =?iso-8859-1?Q?pnBc/Fhx8BySvYSMgJmDfRjvujJsmhUsnKmIrowO0Xt5vQY/NcfgJlxhyL?=
 =?iso-8859-1?Q?syZ3J5znWBMiPIr5PSVNCR5zwV8JhoqjMHJ2hD8Ej6i8OYajEM6JF1JaRG?=
 =?iso-8859-1?Q?+OV9ImB7FwrGmKdxw3QZU3uh0xBKT4u8kBxWVd97sn9pWDpbR7sGyYq9wc?=
 =?iso-8859-1?Q?kXO0QB4KNNUhqT/LCcu2ygjge13cz1Nfx2iGv39cl6bvHGdn8rJx4YdRdw?=
 =?iso-8859-1?Q?yActuTpKjwkHQwS+vr64W/QXPWYfPWmYgyB3O7oC/Vyb2LsM/Z6y4iMfnG?=
 =?iso-8859-1?Q?P16Vx1ISyhse22Hp0vAyYuvixw7mq93FF/3fYrIl46ZbbPi1ZD22Xs/A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZYqxDNORnRtIezrxxAqCNIGZVhvdQ8wPZEpdfy1G7JWrXw2tLopZmyrrPigPGTJbgfdp9ylN3A7H6mO2atQ08wExAeJvZkdDjv5qayEEgqCVAXQ30DGMsFzuYTRFiNilY+JissS62oAJp52gZGnul+srMmTsBskUBRAfUcnrT7aM98s+RQf9t5/XoztAxNjU6tFL8qb+nB92q3hDqoGn3heys0cQ7V2iY+ZjC6IrDwsMZNTHNYJ0OWEV8cA8l9XQBB6e4zYFqjqqOk2nupkk1L6EoLHKyhguQqMNUysyKHA/7ioDoUn/oKQWmqHEH+KBtmzCLHPlw82HKK+Gg5rP113bKDvaQ/JrhGD4R3fqAFFwjjzjeTn0qGZBYI/QceOHxF8DRqvpXN1AOMVo7nT4LFOmTgV/rVaNQG4urcjbbL7/QovoSpzW6e2p6RfgqTbrPrfiLD+fXW3RbKX3HtkMccKoOWyfh3KC0zUHHWPp21gn7awUgX6PtKdwzdsqmlD8A8DTP4J1tAYqoWH8u9sIaPaYof/TM+9/6pSM1bcoaHBXRlO61BCxP+zZwQBQv9fF7M5/LfHDNLcTf74FYjK7iezPpRCa8egY3XodL2uW6TeTBnNWj1VyeYLRS8drQNG89h6i8UQ2cGh7d0XDXAI7mqslLlQW/arEDoxLUqyu/JkLpRCv2WluMo+0DZK926ymR7U0KvjD2v0dNkxnm3KdKbx+9W9MxznQ7unMbob8jaKZXoFe4fJAYajKb5hUH2WqpVNlt/fAqmjjD+k7NlfvxqcElKTxDtdmdVZuJWfNGDoEK7KFKrrqXTQkR19ipZq0H2SvsoS7NvqiuFFIjII+nQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0150b057-f865-4822-745d-08dbf1cb5e40
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 17:39:56.6154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTc7YqnMCD+0W9GkC4fxed7HileAkelVW5Jzbw9jPIP1eZHoueidJ88YbfFw5E3gO/YgkeVe9XH3wwlMntFnZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_17,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300130
X-Proofpoint-ORIG-GUID: fXS8KWAVF3V67QkkJbXGL7TrKTYsy0d6
X-Proofpoint-GUID: fXS8KWAVF3V67QkkJbXGL7TrKTYsy0d6

On Thu, Nov 30, 2023 at 11:55:29AM -0500, Jeff Layton wrote:
> On Thu, 2023-11-30 at 11:22 -0500, Jeff Layton wrote:
> > On Thu, 2023-11-30 at 10:57 +0100, Lorenzo Bianconi wrote:
> > > > > 
> > > > > +/* ============== NFSD_CMD_LISTENER_START ============== */
> > > > > +/* NFSD_CMD_LISTENER_START - do */
> > > > > +struct nfsd_listener_start_req {
> > > > > +	struct {
> > > > > +		__u32 transport_name_len;
> > > > > +		__u32 port:1;
> > > > > +	} _present;
> > > > > +
> > > > > +	char *transport_name;
> > > > > +	__u32 port;
> > > > > +};
> > > > 
> > > > How do you deconfigure a listener with this interface? i.e. suppose I
> > > > want to stop nfsd from listening on a particular port? I think this too
> > > > is a place where a declarative interface would be better:
> > > 
> > > Is it possible with current APIs? as for 2/3 so far I have just added netlink
> > > counter for current implementation but I am fine to change the logic here to
> > > better APIs.
> > > 
> > > > 
> > 
> > No, I don't think you can do this with the current API at all. I
> > consider it a major deficiency. I don't think we want to repeat that
> > mistake in the new interface.
> > 
> > > > Have userland send down a list of the ports that we should currently be
> > > > listening on, and let the kernel do the work to match the request. Again
> > > > too, an empty list could mean "close everything".
> 
> Another thought: should this interface also report and allow you to
> specify the address to listen on?
> 
> When the write_ports interface was first created, it lacked a field for
> the address to listen on. Later we added a way to just hand off a socket
> to the kernel to pass that info.
> 
> I think it's possible today to send down a socket that only listens on a
> particular address, and you have no real way to tell that with the
> current "ports" file.

All agreed, but listening on a particular address isn't something we
need today. (Or is it?)

Does the socket-passing thing work for non socket-based transports
like RDMA? I would think that mechanism is legacy.


> Should we instead plumb a complete struct sockaddr_storage (or some
> other suitable address structure) into this interface?

How difficult would it be to add this later, when we actually have a
specific use case?


-- 
Chuck Lever

