Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C704E75C4
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Mar 2022 16:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356318AbiCYPI1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Mar 2022 11:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359833AbiCYPIH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Mar 2022 11:08:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFB5DA093
        for <linux-nfs@vger.kernel.org>; Fri, 25 Mar 2022 08:06:28 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22PEBJRG031973;
        Fri, 25 Mar 2022 15:06:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2jdmsuWc5mNy5AX5s4KMlrlnQpLvTQ7Sc0hwOBxbM/g=;
 b=enOdoo6a1VXQk48jb8nlXReXaWLetZfHDjoFXgE8Y3IxrLc/A029qfyg7UFTEQT5uZdS
 /K+dPFrz0vbs5RTdf0fprSL+3cHMGVYPk3XlTh0mBK+ita/+VJxj5kky7npaE7LuBu9/
 L7HeAo4njimJPJhjvJb4Zk4bIy7jW3/5nae96IhAYKmrghjLgUXHhS+e/k6rGhlc/ujW
 cyyORzx4L24RBCS8ZTBRx5h6/Xfsw5WgYhoy4WSggw3v2aYvERSGXqeoprqgoZc6XVFZ
 h0IJjRIDrsP0HAT5gnnhIR8ggqp6hyJPKl4dfhmOj+3GzyiBEAjUHYo0Xe0QmK7lbzU9 rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5y27mmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 15:06:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22PF0taf105938;
        Fri, 25 Mar 2022 15:06:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3020.oracle.com with ESMTP id 3ew701vk0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 15:06:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4nba4ke93A16cpPx/29h6iE76lip2wTB7d0kf6jWM1q3DMfol+h1FgNez/GQ+0HI8uRJC30Lho6sV85exBRJuwv7afwrt5jJnUpee4EioGFMlpk4B52evtq+iQ/PHEnru63/8iU+JN/pAMCGdFEuhCtt0z+r+CMwE2KzsssglWKU0xtrFCEF/h3bBatDBaKA8yzhGimuootW7bfVG5ZgoiDUiwG8MM/1ODD2sD48h4YcTEl6jDFmwGNzyGlLDxQXEBfXkp8cNYxLZVvDo85UcLI22s1DglER7Ag+mXwYb6MMDMDV1n76q+TxmoDw2HEGsIby3cf0yDqXtvnelcspw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jdmsuWc5mNy5AX5s4KMlrlnQpLvTQ7Sc0hwOBxbM/g=;
 b=mWO53vUA6wxJ72/3l2X3iyAILrFEYfGGamePi1SNoCBLT9+ZzGQX6jfIPNDzYPgP0wbexwUZBrNk5sVJnavz4dD4JgsDzBvqusRNH+vzdTqEwgOkEyRch3cwS/Vzbd0rRxVBUXdfNVaGkJA9cqW2L5N8GD/o/FUBBVn5Sc4DehGSSLchp81NR2oPMsuzmEL+WogG8qKio1eJYNfF/Pja3WFuPcaeMxqVaalKaiah/kjgo3ED3oizWvXObVGfPj8+oNb6emZ2I0xtFk1EyjL6oUEbqt31yoJxgCYx5K1OArrxE/sqlCoGn6bJ1Iu3+uWOPLImvDJbDxk5Kxxd0f5slQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jdmsuWc5mNy5AX5s4KMlrlnQpLvTQ7Sc0hwOBxbM/g=;
 b=l2wr61Lrl3BYhHxNCPYjT3glIcxqGEK1L3V0iqXPReTml5PVX18Ww3HUkQFLvmBxVhOOcG5GwpfhVf250js7boW/Jk9/qTLczIs0or8F2ky4NOrc/ez4JOKy30qBspxcJvgkPpPGFuhUgI3Vwv5H6pglZ24yuSqlXjXAuda2djc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB2473.namprd10.prod.outlook.com (2603:10b6:5:b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 15:06:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%7]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 15:06:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Benjamin Coddington <bcodding@redhat.com>,
        Steve Dickson <SteveD@RedHat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH/RFC] NFSv4: ensure different netns do not share
 cl_owner_id
Thread-Topic: [PATCH/RFC] NFSv4: ensure different netns do not share
 cl_owner_id
Thread-Index: AQHYP97BJY9z/7BNhkSUi9ed5RyvFKzQM/sA
Date:   Fri, 25 Mar 2022 15:06:11 +0000
Message-ID: <CC04FF50-B936-456D-8BF0-4BF04647B4BC@oracle.com>
References: <164816787898.6096.12819715693501838662@noble.neil.brown.name>
In-Reply-To: <164816787898.6096.12819715693501838662@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 056959ef-d0ea-4447-e5c3-08da0e70ffc1
x-ms-traffictypediagnostic: DM6PR10MB2473:EE_
x-microsoft-antispam-prvs: <DM6PR10MB247373AB3BAF6656D316C7A7931A9@DM6PR10MB2473.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eHagJnSUZdYyxab9RhNShKWxoZuWAuWegA5/a4+h08Lg4PrnprMoc0vTlu8Ua3+fkCRFZvHKl0O9PNnf6OXm/qg+FlreygBwE6/qpo4e2MJqDWPcM2Dm9Lln2RtAfxmuavYr1Qbmj8j1vDyZtTs7RABqnFA+LbxAWaa8YlWllqahwwvWXxhWOi1s4+gqs8jL8MefL9Rtxe2efp6M3I6MRtoOdGuC4MGbuwCbKRB9Dc1jlMtnaEh4sfq9MOpItUhHz+vQG8i61CvMC4+1AFfLuX6nyBbGith1DD5E7ZgE3usKz58rAxjS+jdVK7PvdAaE/cWBMixGYRdX4yNkQYiGmv9ed7eeJiu1vog2vbL/jT4FS5xUKDzW6WUKF7hcl2LPylh9+rnQhE99fjcv9AfYHpMd3ur75UjqPcTDWkirhxtvaSDulOExp8A1p8FkX7PGTlISNKIwiUgTa0ZgcGZljImjcjX6gMMtTScp9ssGQtwd+ApC6aVBeIfZfrMWy2iuzFfk5Lf0kjqv0GuoAGYD/cvj4wg3enj0CWXYYPNvdngMbNKX+C7T9xCmW2+DHxJhTySin/k0gNX2nBIjqW6ntgOpmMnMJsw9jiJoaDKC4tc166fLJ+jh17trHJ/6WAPPc9tf7VwuGARyOpyJvfevCejaBJyfK9CSuID7rAr3Aeydr4u3ezBJLMB+MzH+jmQgtasg0KKlyEonL+0TvBx/V1XRMW8YiRs6eAQnxCuYaXmBeXsAhNyxBM68fbA2fyAX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(5660300002)(186003)(26005)(122000001)(2616005)(508600001)(6916009)(53546011)(6506007)(38070700005)(316002)(54906003)(33656002)(2906002)(6512007)(66476007)(6486002)(66556008)(66946007)(64756008)(66446008)(91956017)(76116006)(83380400001)(36756003)(8936002)(86362001)(4326008)(71200400001)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lPFbBVP65CvpEygjnDZ2Jr+sb2fuWFuzFN2QnCr6jbtK1gQeePj8Xb6OpbQz?=
 =?us-ascii?Q?0hSgjGc4n26sRfT1ixqNnXI+un4KEBk2Em0AxDOA20TcznP1u8iLkiLa7i2+?=
 =?us-ascii?Q?DkmiHRuKD/tCxArt6fJEj2Q74sQO6rYS7U9lGe7R4vRataHeZLNo/dKIjV6b?=
 =?us-ascii?Q?lVZFR0h3Id27UhTWZhFSX8MHVI4UyiwNNmfH7v7tuXSOV/QREMChaR/4Yz5A?=
 =?us-ascii?Q?O+EzYKOei86iIYCwz4Gd62F0nrfCl39kwBALvGhfT0AIhUsXCYtbNcOXN+rO?=
 =?us-ascii?Q?lyQxZrqGx2rhYCXywCZy9gkSocjGekvqP9KN+m6XQKde4Y+GdsW0YM1qRStJ?=
 =?us-ascii?Q?e1FUQpVE5PercOIfj9RwvvVXgLb2Tsaa6/0x6ayQm5F/H/ghgn7oHVJn/gEt?=
 =?us-ascii?Q?iuSMJ36vTXvb3lv5i9R8UskWGKN5ihv6OtE+S7GCuLGVpbp0dZzGPqiLSjfv?=
 =?us-ascii?Q?CTXbHxFQAm+uGQa//ifTsvv7nGB8n0/Pru66pJlvcuCFfMn/52JjdCdKzmE1?=
 =?us-ascii?Q?ZpFkuTR+vZcrplTfRSUIc5/ocNkcqB3CpUeA9MaVQsX513bsjooM97d9qsLi?=
 =?us-ascii?Q?jPGnYD+0EEX4kFnoTMq0+SMlozb1UccmfxahjAwH3dyXOK4Zhbch5h+G7wPF?=
 =?us-ascii?Q?Ldb2kIyP/9jlC6FYjCSBIg0I9fZaST6jgTTevFEMpDu3eXJMXppIbC38l2mP?=
 =?us-ascii?Q?HqHd+pde88X8czoZsubhPnKpqhBR8zXpTByCdZNcC0P0Xvc73iXk7mVKm8Pf?=
 =?us-ascii?Q?FHZSExfD+IowRLbRBV0jCeisoNT0tlGnJIBcrbhnVBpoODGDTKZoETOiA/SF?=
 =?us-ascii?Q?fzfgSbZPpGquX6gZmkj02vLefpkNEkZHZPEcu01JH1rtDPxfeKP77IdODrEX?=
 =?us-ascii?Q?wKgGHeaiOeKTI98sTCyH+GOmERSYhkAgH2v3/Q7C1Lf4tdJZIk5HnejWAuBZ?=
 =?us-ascii?Q?wDREYmasp+OpJsy226w4GMYWwDp6LDpKsV5I0hrJpzS5bs7NZ7C+M5gdtUjS?=
 =?us-ascii?Q?0KybdW8njWcmzK59PbS+ijqB1vmkGvphLB2PsR8obRNvYB/dRBP9CuqxLO1F?=
 =?us-ascii?Q?8AwlxXZ0kSuNzhy/gKC44lbXUMk+evoc7ikXBShCf9JnI2lZ7qSCfQQk0n4i?=
 =?us-ascii?Q?c51bzTs87NJJtALkCahFgGZy5ml21avrD5u3PRhmws8cmGjWXmQSJLHu+oJm?=
 =?us-ascii?Q?EAGPVt6OcuPMd7blFjMY8Qwse/ZaHiZrQehM/ofNxzbPDsKYTo7eTSJF19a0?=
 =?us-ascii?Q?B9FW5vmXAg3FEL2FiQBhnI6qxQ6aS/JvBb7VWng5TdZdIoN6THxcu0OQbJOW?=
 =?us-ascii?Q?30HnEQCZOOQUwSyfiFrNrvDuuq6RB7y6wjnJBF2M4KykrOAMsiHocGG+BnSu?=
 =?us-ascii?Q?V9amDQekDtL6qQDkVpM0Q0VgxR3zQUWiZegwpcvP6MPTags/CPfXFiKDfWVk?=
 =?us-ascii?Q?FMB3F2yjsCmFSEOrLiE4QPyylKdUg6zB5ZybL8qToG2ol5d+NqdkAEdLoTCw?=
 =?us-ascii?Q?MzS/hwZ0e9dtk4Ha1xXetzy5fKHD2B9i90QksotqnA7C3S8NNs4egYliTXYb?=
 =?us-ascii?Q?yhAnlRfzdbLwJ1MKVw2dsFYfhWHDeX9fv8Z5bkJRBlwTs5hlO9atON1cP4km?=
 =?us-ascii?Q?YxQsKxX5ZYsIHcMxCKyjP3ZOnyIVhvmFiJhpl3FZFXxv7cmRZcayvnfsD15i?=
 =?us-ascii?Q?yof8NFqf/5Xf6DOgOgcy9o2w2vcpnFGDA3Y8b92aWTWZTVIomev0KYI1k78y?=
 =?us-ascii?Q?vF/7bqUOIbKPTFWvaVncNJI9TPFINiM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <66DF4F30F4EAA34EB5003DEE5C76DB7C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056959ef-d0ea-4447-e5c3-08da0e70ffc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 15:06:11.5276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZWXU96gqattP57Uv2SRCOrgCrX5u43Vym+NYUZUdFbXLqpwwF7VZo9YzkhYy9Ud+NaF8ZcSRPA3bF/5txC9Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2473
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10296 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203250084
X-Proofpoint-GUID: 2lVQdPyj-6tKi_ebt59X5frztI-KF0v8
X-Proofpoint-ORIG-GUID: 2lVQdPyj-6tKi_ebt59X5frztI-KF0v8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil-

> On Mar 24, 2022, at 8:24 PM, NeilBrown <neilb@suse.de> wrote:
>=20
>=20
> [[ This implements an idea I had while discussing the issues around
>   NFSv4 client identity.  It isn't a solution, but instead aims to make
>   the problem more immediately visible so that sites can "fix" their
>   configuration before they get strange errors.
>   I'm not convinced it is a good idea, but it seems worthy of a little
>   discussion at least.
>   There is a follow up patch to nfs-utils which expands this more
>   towards a b-grade solution, but again if very open for discussion.
> ]]
>=20
> The default cl_owner_id is based on host name which may be common
> amongst different network namespaces.  If two clients in different
> network namespaces with the same cl_owner_id attempt to mount from the
> same server, problem will occur as each client can "steal" the lease
> from the other.

The immediate issue, IIUC, is that this helps only when the potentially
conflicting containers are located on the same physical host. I would
expect there are similar, but less probable, collision risks across
a population of clients.

I guess I was also under the impression that NFS mount(2) can return
EADDRINUSE already, but I might be wrong about that.

In regard to the general issues around client ID, my approach has been
to increase the visibility of CLID_INUSE errors. At least on the
server, there are trace points that fire when this happens. Perhaps
the server and client could be more verbose about this situation.

Our server might also track the last few boot verifiers for a client
ID, and if it sees them repeating, issue a warning? That becomes
onerous if there are more than a handful of clients with the same
co_ownerid, however.


> To make this failure more immediate, keep track of all cl_owner_id in
> use, and return an error if there is an attempt to use one in two
> different network namespaces.
>=20
> We use an rhl_table which is a resizeable hash table which can contain
> multiple entries with the same key.  All nfs_client are added to this
> table with the cl_owner_id as the key.
>=20
> This doesn't fix the problem of non-unique client identifier, it only
> makes it more visible and causes a hard immediate failure.  The failure
> is reported to userspace which *could* make a policy decision to set
>  /sys/fs/nfs/net/nfs_client/identifier
> to a random value and retry the mount.
>=20
> Note that this *could* cause a regression of configurations which are
> currently working, is different network namespaces only mount from
> different servers.  Such configurations are fragile and supporting them
> might not be justified.  It would require rejecting mounts only when the
> netns is different and the server is the same, but at the point when we
> commit to the client identifer, we don't have a unique identity for the
> server.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
> fs/nfs/nfs4_fs.h          |  7 +++
> fs/nfs/nfs4client.c       |  1 +
> fs/nfs/nfs4proc.c         | 89 +++++++++++++++++++++++++++++++++++++++
> fs/nfs/nfs4state.c        |  4 ++
> fs/nfs/nfs4super.c        |  8 ++++
> include/linux/nfs_fs_sb.h |  2 +
> 6 files changed, 111 insertions(+)
>=20
> diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
> index 84f39b6f1b1e..83a70ea300d1 100644
> --- a/fs/nfs/nfs4_fs.h
> +++ b/fs/nfs/nfs4_fs.h
> @@ -336,6 +336,13 @@ extern void nfs4_update_changeattr(struct inode *dir=
,
> extern int nfs4_buf_to_pages_noslab(const void *buf, size_t buflen,
> 				    struct page **pages);
>=20
> +/* Interfaces for owner_id hash table, which ensures no two
> + * clients in the name net use the same owner_id.
> + */
> +void nfs4_drop_owner_id(struct nfs_client *clp);
> +int nfs4_init_owner_id_hash(void);
> +void nfs4_destroy_owner_id_hash(void);
> +
> #if defined(CONFIG_NFS_V4_1)
> extern int nfs41_sequence_done(struct rpc_task *, struct nfs4_sequence_re=
s *);
> extern int nfs4_proc_create_session(struct nfs_client *, const struct cre=
d *);
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index 47a6cf892c95..2a659d14b663 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -289,6 +289,7 @@ static void nfs4_shutdown_client(struct nfs_client *c=
lp)
> 		nfs_idmap_delete(clp);
>=20
> 	rpc_destroy_wait_queue(&clp->cl_rpcwaitq);
> +	nfs4_drop_owner_id(clp);
> 	kfree(clp->cl_serverowner);
> 	kfree(clp->cl_serverscope);
> 	kfree(clp->cl_implid);
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 0e0db6c27619..8f171e8b45b4 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -55,6 +55,8 @@
> #include <linux/utsname.h>
> #include <linux/freezer.h>
> #include <linux/iversion.h>
> +#include <linux/rhashtable.h>
> +#include <linux/xxhash.h>
>=20
> #include "nfs4_fs.h"
> #include "delegation.h"
> @@ -6240,6 +6242,89 @@ nfs4_get_uniquifier(struct nfs_client *clp, char *=
buf, size_t buflen)
> 	return strlen(buf);
> }
>=20
> +static u32 owner_id_hash(const void *obj, u32 len, u32 seed)
> +{
> +	const char *const *idp =3D obj;
> +	const char *id =3D *idp;
> +
> +	return xxh32(id, strlen(id), seed);
> +}
> +
> +static int owner_id_cmp(struct rhashtable_compare_arg *arg,
> +			const void *obj)
> +{
> +	const char *const *idp =3D arg->key;
> +	const char *id =3D *idp;
> +	const struct nfs_client *clp =3D obj;
> +
> +	return strcmp(id, clp->cl_owner_id);
> +}
> +
> +static struct rhltable nfs4_owner_id;
> +static DEFINE_SPINLOCK(nfs4_owner_id_lock);
> +const struct rhashtable_params nfs4_owner_id_params =3D {
> +	.key_offset =3D offsetof(struct nfs_client, cl_owner_id),
> +	.head_offset =3D offsetof(struct nfs_client, cl_owner_id_hash),
> +	.key_len =3D 1,
> +	.automatic_shrinking =3D true,
> +	.hashfn =3D owner_id_hash,
> +	.obj_cmpfn =3D owner_id_cmp,
> +};
> +
> +int nfs4_init_owner_id_hash(void)
> +{
> +	return rhltable_init(&nfs4_owner_id, &nfs4_owner_id_params);
> +}
> +
> +void nfs4_destroy_owner_id_hash(void)
> +{
> +	rhltable_destroy(&nfs4_owner_id);
> +}
> +
> +static bool nfs4_record_owner_id(struct nfs_client *clp)
> +{
> +	/*
> +	 * Any two nfs_client with the same cl_owner_id must
> +	 * have the same cl_net.
> +	 */
> +	int ret;
> +	int loops =3D 0;
> +	struct rhlist_head *h;
> +
> +	/* rhltable_insert can fail for transient reasons, so loop a few times =
*/
> +	while (loops < 5) {
> +		spin_lock(&nfs4_owner_id_lock);
> +		rcu_read_lock();
> +		h =3D rhltable_lookup(&nfs4_owner_id, &clp->cl_owner_id,
> +				    nfs4_owner_id_params);
> +		if (h &&
> +		    container_of(h, struct nfs_client,
> +				 cl_owner_id_hash)->cl_net !=3D clp->cl_net) {
> +			rcu_read_unlock();
> +			spin_unlock(&nfs4_owner_id_lock);
> +			return false;
> +		}
> +		rcu_read_unlock();
> +		ret =3D rhltable_insert(&nfs4_owner_id,
> +				      &clp->cl_owner_id_hash,
> +				      nfs4_owner_id_params);
> +		spin_unlock(&nfs4_owner_id_lock);
> +		if (ret =3D=3D 0)
> +			return true;
> +		/* Transient error */
> +		msleep(20);
> +		loops +=3D 1;
> +	}
> +	return false;
> +}
> +
> +void nfs4_drop_owner_id(struct nfs_client *clp)
> +{
> +	if (clp->cl_owner_id)
> +		rhltable_remove(&nfs4_owner_id, &clp->cl_owner_id_hash,
> +				nfs4_owner_id_params);
> +}
> +
> static int
> nfs4_init_nonuniform_client_string(struct nfs_client *clp)
> {
> @@ -6289,6 +6374,8 @@ nfs4_init_nonuniform_client_string(struct nfs_clien=
t *clp)
> 	rcu_read_unlock();
>=20
> 	clp->cl_owner_id =3D str;
> +	if (!nfs4_record_owner_id(clp))
> +		return -EADDRINUSE;
> 	return 0;
> }
>=20
> @@ -6331,6 +6418,8 @@ nfs4_init_uniform_client_string(struct nfs_client *=
clp)
> 			  clp->rpc_ops->version, clp->cl_minorversion,
> 			  clp->cl_rpcclient->cl_nodename);
> 	clp->cl_owner_id =3D str;
> +	if (!nfs4_record_owner_id(clp))
> +		return -EADDRINUSE;
> 	return 0;
> }
>=20
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index f5a62c0d999b..a5cd5c2d6dac 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -2276,6 +2276,10 @@ int nfs4_discover_server_trunking(struct nfs_clien=
t *clp,
> 	case -EINTR:
> 	case -ERESTARTSYS:
> 		break;
> +	case -EADDRINUSE: /* cl_owner_id not unique */
> +		dprintk("NFS: client id \"%s\" is used in other network namespace\n",
> +			clp->cl_owner_id);
> +		break;
> 	case -ETIMEDOUT:
> 		if (clnt->cl_softrtry)
> 			break;
> diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
> index d09bcfd7db89..62f6d15c2bf9 100644
> --- a/fs/nfs/nfs4super.c
> +++ b/fs/nfs/nfs4super.c
> @@ -280,11 +280,17 @@ static int __init init_nfs_v4(void)
> 	if (err)
> 		goto out2;
>=20
> +	err =3D nfs4_init_owner_id_hash();
> +	if (err)
> +		goto out3;
> +
> #ifdef CONFIG_NFS_V4_2
> 	nfs42_ssc_register_ops();
> #endif
> 	register_nfs_version(&nfs_v4);
> 	return 0;
> +out3:
> +	nfs4_unregister_sysctl();
> out2:
> 	nfs_idmap_quit();
> out1:
> @@ -298,6 +304,8 @@ static void __exit exit_nfs_v4(void)
> 	/* Not called in the _init(), conditionally loaded */
> 	nfs4_pnfs_v3_ds_connect_unload();
>=20
> +	nfs4_destroy_owner_id_hash();
> +
> 	unregister_nfs_version(&nfs_v4);
> #ifdef CONFIG_NFS_V4_2
> 	nfs4_xattr_cache_exit();
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index ca0959e51e81..a9da00b6aeb6 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -8,6 +8,7 @@
> #include <linux/wait.h>
> #include <linux/nfs_xdr.h>
> #include <linux/sunrpc/xprt.h>
> +#include <linux/rhashtable-types.h>
>=20
> #include <linux/atomic.h>
> #include <linux/refcount.h>
> @@ -84,6 +85,7 @@ struct nfs_client {
>=20
> 	/* Client owner identifier */
> 	const char *		cl_owner_id;
> +	struct rhlist_head	cl_owner_id_hash;
>=20
> 	u32			cl_cb_ident;	/* v4.0 callback identifier */
> 	const struct nfs4_minor_version_ops *cl_mvops;
> --=20
> 2.35.1
>=20

--
Chuck Lever



