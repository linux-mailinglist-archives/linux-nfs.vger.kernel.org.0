Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD974C2FBE
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 16:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbiBXPbc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 10:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiBXPbb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 10:31:31 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01871BE4F4
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 07:31:00 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OFRM4m016941;
        Thu, 24 Feb 2022 15:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kFWpEfbXTUVzNvoZCk9szfaO1Vo2PYFYKb9qI01yNww=;
 b=sHG6Byo/q6rAjkcPERZvWFOCqyMRmSH6swZmJf0DO1k4Sh7JIP6s1tC7/o3+5/GKJNvk
 o4sWJQK5n7nK+V42g4UlCAjsQVypwRex/XYf14FKcMW4n0448X3Q1imIbX2SLLaGCXXA
 XrgVuNA4ibHNok+e6iw2/1RivlB2o0zdO9t3zzTuSfrhgHbgd3nVOmyNrPmSzqn3r7T+
 YkjrwTpX8Mn1OGwyPLned+KSiJO/4MGMcAfDfrdRTlar798zoSfnsNPoHS992nvKy4Ex
 olvdIWCy3TkqA2MW0WPKTEMOmGqOiq+CS4wBo80wS4PmL1K2bi/zEDd+lHhhmpH+S3Qg LQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ect3cqhde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 15:30:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OFLgwi045989;
        Thu, 24 Feb 2022 15:30:56 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by userp3030.oracle.com with ESMTP id 3eannxma38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 15:30:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0QonuWf8OGVgCaj0r6F2XQURI+5p/fPrF1ZmF6WV6ZrUdjPsutBP5DpucrHOHdKG2ZH/1taYFA7YzAVdpBLglVvaPd5t/bcq3GDiz58LivPsW7NojO6Gw/twKNGVFSr0xkAi7Qq8nqngoBJ93YSMHNv6hrI3LFphWF38Y6T6pmIQ4gP3N2IYPgZZ70wg7ytvj/1K8Sl5NT9+TdaKSeMaS5E/nylWen7vr69cFzB/QvHU8/dWOvIn0ZHaI9t/OJfa3qjnaXNm3xvb/uEiqziQWrKm7TKAqvbMADNKTOHZhwPuDwS4bsALI/ATRUBwfu2NOSLZlaeN7Q5406CqCbZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFWpEfbXTUVzNvoZCk9szfaO1Vo2PYFYKb9qI01yNww=;
 b=QyzlCODp+JMFJPdNJlX3+3XbziXdXTImxlEleRUhVLrwoDQcZDGUZUBbgk5yn68D5dlIVMJqZqGUOBDUB7DaMFP/fRDLqOWgVecpnPst63cEe4BuOFUlrjKhbL/GuUz8k6RmfHo9k5kQ20qV3Hnz5mHR15wmB3+FglD0bPXc0rnzejnZXHByljRAoLagBrsCfFu5rDQ76QUl0wLMjPpz+ERaZ12RqhdUoMM93LZ1HR4l5RF2XhdoIQKo1/Li5SqsYYvqj1/CpB42SSoE4ZRN6GRI7yfYQCb/Y1oanmTH8lxwqZcJbm1lnNtnLDUpM11+bQtLZmWF6q91byaNpqMwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFWpEfbXTUVzNvoZCk9szfaO1Vo2PYFYKb9qI01yNww=;
 b=eQieiB0IKLHe2nDNUiQ9Nl8E5rOKfLDg95I1mcuXQU1JelVsSo3mnFD9dG+sYBG+5oBLHenikmvRNOkV6DCUEvzbcC6Tn/Y0byUpQwY1j8OttjrR0EH55VWttbDCkwRoBMF8QpbX5UCvenYfr8cQ+HMVTropqZUNz0sib1yHjS8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB3493.namprd10.prod.outlook.com (2603:10b6:a03:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 15:30:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 15:30:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1] NFSv4.1 provide mount option to toggle trunking
 discovery
Thread-Topic: [PATCH v1] NFSv4.1 provide mount option to toggle trunking
 discovery
Thread-Index: AQHYKNyvQiH+fo5gFUC0apKHyPss06yi1UiA
Date:   Thu, 24 Feb 2022 15:30:52 +0000
Message-ID: <77E34F86-FC2E-4CBF-AFCA-272BAA7C4040@oracle.com>
References: <20220223174041.77887-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20220223174041.77887-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce65302f-9858-4e0c-be95-08d9f7aaa446
x-ms-traffictypediagnostic: BYAPR10MB3493:EE_
x-microsoft-antispam-prvs: <BYAPR10MB349373746C4755D0D85F2455933D9@BYAPR10MB3493.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JzXUvgaS8pDwMwK1DM1/VeCJSmJRjuSjxpWeZtLb4kI/GtBAGnlw0en/2mKWF+yB7yKgWuE1kzg1JtoB/FxHCfrWEo266ebWGEOwrZu1oqg2WY/rtvj7F9KpHh5n7rH1O8ei2Y/iwFad+GsssHspF+diEIbLJ6DDntppCKsfJjDBMTAidu0yrty0K1RW95pAQi9hMuyFzQ2ikUpfiQjfNvzgVtmMsWdhtcIELjb6MHmn+jnGLMFgv/2oAZxQr2YnTfRsewn/J66H54pSEPRxtlebQLIqNyTSR81FCO6Vnx1gnhm+nhMSzSc2IXKIHE3DmlJVitPCyXsA3HRYjSwLSRr/rJIfWsowH/7qL76J5kyf6T3/te00umZ7oAWd3V6sRABPH6Ez4WF2u1BHf8ODtF9RR2tIBUcypHIPNlk8gR/UWPZB79hpHGc6hS392Xh8arPXIkLVCA1aoRF0WIKYGBw87p9hGgfRFSaHojuD1H3TB697bVVBhYyXBsQHbUSSwn+Xdib4NfwnfMjmcaGBBi7Qc6CB2gt58X8W00peflw6+rNB19v/BjCZqQVYYLpY5DVhZUyy6fyXoA9LHOq0jRPjIl47A7D5IripCtolZ4Z3HzlEP37lX7cl+PNb5dRNVvVkRV9isOYhX+a1NPjWKtDMRCAmryK06G1wqWCmVPSXqcZIwmQGYWGWQPQI2N7bBDD8OxXaEBqG+scc8utjoJGnwUpAsOjy+E6tUFafW45QaeAPsNDKqrdH91ETnpfM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(2906002)(122000001)(38100700002)(33656002)(2616005)(83380400001)(38070700005)(66946007)(66446008)(53546011)(5660300002)(76116006)(508600001)(316002)(66556008)(86362001)(36756003)(6506007)(66476007)(8936002)(91956017)(6916009)(6486002)(8676002)(54906003)(71200400001)(64756008)(6512007)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oNZDBYROdHrkVD+IVwbeDCVwRvqCt5XuPDN5jhEqYcrrUipHaM7TkB6RUDYb?=
 =?us-ascii?Q?HOjHOuyecJpuxxsSdwD74d/3jDK2WxUXxVQ1YsFqXlbeFsKTgegBOUGKFyCU?=
 =?us-ascii?Q?fMKZHxHr5S2xxOZLeItjkP/jqJv1ttHArbgXfr+ItxAS7/7cnSfVzDJtJ5Nh?=
 =?us-ascii?Q?5BA8FuUztb1f49q5ZE4d0i64jkxy+iBkGOADe3bKb4tw8I9a/cdmN8Wh1zTw?=
 =?us-ascii?Q?xRwDKE7FIsSHdOLSWZHXF5WazI9oeAFiq5E3eGg4MVyf5vLKEd1pXJ12vRV3?=
 =?us-ascii?Q?aWqT4ypuy5ROpN9Dj8CW1UKJTURpsACpuUqfghbxIUQ3pJ7ozZnhV1VLjqtB?=
 =?us-ascii?Q?2N4SxpeByA8nX5IwuM5YTiqozFAeLT7twRjvZRX6C1wDPpfG2u6Cv9E8v7VR?=
 =?us-ascii?Q?w7pkzFqC8sKEn35hH4kX17vyixqckwtUCWau7tDAVI2Dsgqxk16RA7xJYrS7?=
 =?us-ascii?Q?VD1m2xlhUaZ4LY0NPnGV3XK/5KiUiVT2YbZTh08bHdcQGwEoOT0vzEy1j6lL?=
 =?us-ascii?Q?v+fdInkANy7QsFPJA9aeKiccQX34EyvKtlQZ4smQSCkRG8tNvSsughNRRy94?=
 =?us-ascii?Q?ifJM49c6y+tbAH4HyAqOuBo2SJBZVNjTcKLVw/640BoyAm7ByCutP9UqIQn8?=
 =?us-ascii?Q?P7tXo5DlD3yHDU3fiSQ30lS6wLF3/A5AeG2lLml51elRHw0gSnFu3xOEne+G?=
 =?us-ascii?Q?Z9nm93wkBG8MeIAScBAIdjpE4UD9Vk0elNGtLfqQSipq24TVL0CZ1ivwkkjD?=
 =?us-ascii?Q?Us8OpRlR6zATXfZB3/L5w11jnriZ0DJfBdy3Dy70D288dDMskfuz7hBwsYXC?=
 =?us-ascii?Q?MthEw5tCj3Ct4BuO8HJhajKeLjlsF8P9fk002VVdI9FebOVRTAWo6nmJWIYx?=
 =?us-ascii?Q?NPSs61TN+oRyZClcu/ua0OHCfEOm1Ocy4i5Uy+TKYEw83Yhn8blzeKIOWcej?=
 =?us-ascii?Q?RJWiMoc22l70+9aG82iJ9Y8nh+8VgJyT11kd5k55uYVLCBp3pbjhAt9GbpIN?=
 =?us-ascii?Q?zN5pjnaR30vJQuymK1CLPg4LRGBtgjyChCAyQPI1C9iEQ3Khk4NiFeygjORu?=
 =?us-ascii?Q?dSdl034UrkfDGNZY3MlFpjtHerOMS9KBhOXY6Fh8cn1tDHkDu8TZSNLbVlXa?=
 =?us-ascii?Q?uLOL7810SMSa5n/RQIm/2cwZTvYfhUpekEvMfruv5S4nLyN+b1buWW78TX8H?=
 =?us-ascii?Q?oF5DsO9lLrPeeXkYcyLSzR9PLbenQVm/JufO2mdLZtJ9JUGeUCLQPpnI9s5p?=
 =?us-ascii?Q?Gk7txHyW+xrbtoLW1JXxuV1UKc/5Cp1k3+xrcMRsTIJt6geRU63+fsUPZyL6?=
 =?us-ascii?Q?E0VmvBe/JO+vYUsRK4BH8PNdRGMEDjgz8Mk0knzEbNC9sZAcT8IGvrk3yYT5?=
 =?us-ascii?Q?d4Am65S/CJIAt5+AZitiEI1P/DAbvzyycUFyu81mIigQ6n3JSMDjsrF6iN7K?=
 =?us-ascii?Q?lcJ5LNf2BC2bS4KSOszIY/YragOQGpWIrH9K9fIGQSRya5+mT/XcTt5KlHez?=
 =?us-ascii?Q?uRzY6p3sJrS5TwUpiQMGn84CexLmze6L8HLVaG5BongnCw+oM1bw1F9YSmkJ?=
 =?us-ascii?Q?K53tOECV4YETjPD2IrdG9mhDVU5GCvxN5E3K+MX0Totqaj1MvpHanaClpHiV?=
 =?us-ascii?Q?XHTuAbDgHjPCMA132PkliX4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D1DAE4804052654E865DC8C7EC568C59@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce65302f-9858-4e0c-be95-08d9f7aaa446
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 15:30:52.0674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /n01Rv5I4vXdifT/Pyhyu/oMpLTCY8eEguWiwaWZp3K8qO6T+5fDjgO9aULPvbd1BIuslMUuggN1B5QJ8/jaXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3493
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240092
X-Proofpoint-ORIG-GUID: CBsh_qeYTrPwVrrHxS8ZW3O3OslS7XVN
X-Proofpoint-GUID: CBsh_qeYTrPwVrrHxS8ZW3O3OslS7XVN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 23, 2022, at 12:40 PM, Olga Kornievskaia <olga.kornievskaia@gmail.=
com> wrote:
>=20
> From: Olga Kornievskaia <kolga@netapp.com>
>=20
> Introduce a new mount option -- trunkdiscovery,notrunkdiscovery -- to
> toggle whether or not the client will engage in actively discovery
> of trunking locations.

An alternative solution might be to change the client's
probe to treat NFS4ERR_DELAY as "no trunking information
available" and then allow operation to proceed on the
known good transport.

I can't think of a reason why normal operation needs to
stop until this request succeeds...?


> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
> fs/nfs/client.c           | 3 ++-
> fs/nfs/fs_context.c       | 8 ++++++++
> include/linux/nfs_fs_sb.h | 1 +
> 3 files changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index d1f34229e11a..84c080ddfd01 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -857,7 +857,8 @@ static int nfs_probe_fsinfo(struct nfs_server *server=
, struct nfs_fh *mntfh, str
> 	}
>=20
> 	if (clp->rpc_ops->discover_trunking !=3D NULL &&
> -			(server->caps & NFS_CAP_FS_LOCATIONS)) {
> +			(server->caps & NFS_CAP_FS_LOCATIONS &&
> +			 !(server->flags & NFS_MOUNT_NOTRUNK_DISCOVERY))) {
> 		error =3D clp->rpc_ops->discover_trunking(server, mntfh);
> 		if (error < 0)
> 			return error;
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index ea17fa1f31ec..ad1448a63aa0 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -80,6 +80,7 @@ enum nfs_param {
> 	Opt_source,
> 	Opt_tcp,
> 	Opt_timeo,
> +	Opt_trunkdiscovery,
> 	Opt_udp,
> 	Opt_v,
> 	Opt_vers,
> @@ -180,6 +181,7 @@ static const struct fs_parameter_spec nfs_fs_paramete=
rs[] =3D {
> 	fsparam_string("source",	Opt_source),
> 	fsparam_flag  ("tcp",		Opt_tcp),
> 	fsparam_u32   ("timeo",		Opt_timeo),
> +	fsparam_flag_no("trunkdiscovery", Opt_trunkdiscovery),
> 	fsparam_flag  ("udp",		Opt_udp),
> 	fsparam_flag  ("v2",		Opt_v),
> 	fsparam_flag  ("v3",		Opt_v),
> @@ -529,6 +531,12 @@ static int nfs_fs_context_parse_param(struct fs_cont=
ext *fc,
> 		else
> 			ctx->flags &=3D ~NFS_MOUNT_NOCTO;
> 		break;
> +	case Opt_trunkdiscovery:
> +		if (result.negated)
> +			ctx->flags |=3D NFS_MOUNT_NOTRUNK_DISCOVERY;
> +		else
> +			ctx->flags &=3D ~NFS_MOUNT_NOTRUNK_DISCOVERY;
> +		break;
> 	case Opt_ac:
> 		if (result.negated)
> 			ctx->flags |=3D NFS_MOUNT_NOAC;
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index ca0959e51e81..d0920d7f5f9e 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -151,6 +151,7 @@ struct nfs_server {
> #define NFS_MOUNT_SOFTREVAL		0x800000
> #define NFS_MOUNT_WRITE_EAGER		0x01000000
> #define NFS_MOUNT_WRITE_WAIT		0x02000000
> +#define NFS_MOUNT_NOTRUNK_DISCOVERY	0x04000000
>=20
> 	unsigned int		fattr_valid;	/* Valid attributes */
> 	unsigned int		caps;		/* server capabilities */
> --=20
> 2.27.0
>=20

--
Chuck Lever



