Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB89333BCF1
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Mar 2021 15:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbhCOOam (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Mar 2021 10:30:42 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43322 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbhCOOa2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Mar 2021 10:30:28 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12FETkwM059392;
        Mon, 15 Mar 2021 14:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=f1eCFW/v721QrEr2rTDo+90bnjgCs/AMutOB1OF/oCU=;
 b=fB3ans89zg9eChKbLKpZ1RQpgap4icq9kBpsnuabMuj7a2nG7v23BpPKxTryYimeuvkM
 Yc8cjmNXOi4otlwdhtAnfYOoOg3oe8UYWmvYT0dxMXtn9yIaUBbk+8LRnilg27t6Sx/8
 BNwTSGA9N9Rfox8sPVeJhuLlzvJQFyuufxNPgupRWkW9FDZZasaZC7Nu30GaP1nw9umc
 mXd5DP4MJA+I5AHk3ZdP9JL0nclJhmNjR9N/JoWv6SUVs9pf7c44vpDpyIf2djyQsfib
 72ChKsQOwS9ZL9Pka2V7rQEwMF9fXj+DvKzIhXWhKVQn6v896DU/nXoop7ZmEPvdUHY4 bA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 378jwbc5dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 14:30:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12FETjRG182030;
        Mon, 15 Mar 2021 14:30:23 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2056.outbound.protection.outlook.com [104.47.36.56])
        by userp3030.oracle.com with ESMTP id 3797axr3uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 14:30:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTYphm/xWSjIogmBkdF1opU1+fzuT43EmoNFQCahJsC4Gr0kDwzVmQT61ybu6LPr20OxYvl03Dj+kemh08lisxfvz1Z9bhbpmI3rVptUEv0+bQeA/ZCsc+oTb1jUslMHVsp76nRn6kX4O+Nrm/Wu3MECHUVzOnY8mSNFJXvnMctqrk9Lfx6phzxIlDCn8w8zJKmAzV2yOd3hqmoWqS6+EzWDEvhQTK1luLwBV3Y2qMeYo206zL82SX8bpnQk3JdOfb/nRbiUglz98rQPDNOpl32DrGWPgKomHGqjsQCm3hk9vk92pEzjYkcnkTruDvCRR3Ij/vob8OoP0La7MZdyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1eCFW/v721QrEr2rTDo+90bnjgCs/AMutOB1OF/oCU=;
 b=Gm7904/xFpmJtVomDZTi25259OsnZhPgTR1si6sgAlxA5pEixiGegeHFGkl32UDI6w6cUUoBcl6Y3NecGjH7L5w4aQvUJicoNvuOYbvj/Mh4UzMIs2QGyTFo4pYlMV9NoJ1vLQNG9wtrHQpTfuWCxYnLW4BS835TY0tBJVmo0Ast9y6nre5o3gzVvaDQv/oJv/szDtL4CciDKvfFryEkSntwMXjchmV9GplPt+/JZoIlseI78YxibNnPhX9CorRFBnC7HcppwI++V3BQdZHUyMWK6MG+5Z6eyOdLkoh420BByXgKKzUHVKUdeybEoz2YID65v4NkuudiBHyZkC7VXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1eCFW/v721QrEr2rTDo+90bnjgCs/AMutOB1OF/oCU=;
 b=td+VG4dDgiRlb6XaHWDgZpIk9JnEv6Vnc8120VdlRnX11jXoJALMUFUmtc5urbLOXLWpTeKqatT3ddLC3Vbr4zhZSgUXLIPp5A5EsSj0ghyAO6qNgSi/c19krQnFe2B9YspdH62ky2JnPNnw1VVz8fJsP4+Y/offB7W55T8+cn4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2869.namprd10.prod.outlook.com (2603:10b6:a03:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 14:30:21 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 14:30:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Ensure knfsd shuts down when the "nfsd" pseudofs is
 unmounted
Thread-Topic: [PATCH] nfsd: Ensure knfsd shuts down when the "nfsd" pseudofs
 is unmounted
Thread-Index: AQHXGE0TeKcnmbpiEkis/ppV016GpKqFHtkA
Date:   Mon, 15 Mar 2021 14:30:21 +0000
Message-ID: <3E0EA1A3-8257-4C20-97FD-C8712029F41D@oracle.com>
References: <20210313210847.569041-1-trondmy@kernel.org>
In-Reply-To: <20210313210847.569041-1-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e69e1d7-0f21-43b7-93aa-08d8e7bedd19
x-ms-traffictypediagnostic: BYAPR10MB2869:
x-microsoft-antispam-prvs: <BYAPR10MB2869082CECBDD2D79873F428936C9@BYAPR10MB2869.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:389;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I2SOCkMzEJZ0hWzv3E098W8a2XPewqB7H91GIugNQYUhYiAlyWxf+c/WIgkDkgGwxZQB1hGtKYO8lp9fdRYF7YT2ymOHZa8tBBxOvZH49lxP7aLxC1C+okAz6bH5CW+qDIiaiO3pA16YlUASBqfMNfkGrlQbCEWC7notBI5xyMtGPWmrVJJ3HUEkQg/0j7bS7MA7UgQZ2pR8UthC2V57JB1DOvzCxsnXtVh7Z2Dk5D3PP5/GReiV+iuOgX+ihQsfjWIB93m2urf1f8TATvxbjE7CsgqTFp5kq4azRtcrAMj3hqJgk/fHxhs1mP2x+hulEz2/i1+lMD1Q4rTnjS9y1ulNnwYHtmpoP3MR9Qg77FCzwdDAOjpUEKmZDhibJGfomZ/J9+JzmE2epHwy9dyQxuNQGiHzzZplbEYOuKlauedSBu0+IPI3xq3cgr/d/sZo/8U8WupoYP6eG0doITQ9hmqEpQ2zTTYb5AHhuNbYtZwYldUYezFXzdizSN70sn8LuPsOIvOMk5VuYcMohhGirvIICIYFi70nebtUKbiFQEJH2PHTAWrBRDSQ/KDJcOiBX9pQowlK0/NEMtIxT9r7Y8D0oC9UxDVVyw5Fq2JnaVrbP11jnL6iipzv+LZQWXxH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(376002)(366004)(136003)(66946007)(66556008)(66446008)(64756008)(76116006)(66476007)(91956017)(8936002)(53546011)(83380400001)(6506007)(71200400001)(36756003)(4326008)(86362001)(2616005)(5660300002)(478600001)(33656002)(6486002)(26005)(8676002)(6512007)(186003)(2906002)(316002)(54906003)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?taY+v2G98caEVT1NhwV+lGT/Gjn+XWoKupyQGci4P39Zt1ZpCRfIuXn37sBG?=
 =?us-ascii?Q?3jWS+vZl7zlWBjUKFo2Ypvqh7dy6UDo5lyE/evRUxQXJHMnyq1gqa3wz0OPl?=
 =?us-ascii?Q?zRKzHhsC7JuXHp1O9eMbIIdHnl/aqI+hlHtCo1N1rn7OIjidHlmq7jpj9oNW?=
 =?us-ascii?Q?SehJJKb1vNbFnmOM0uIsxYAG+lZTlsJJy/FBpQNSSv8zH6i6VDyEd88d5ebM?=
 =?us-ascii?Q?zrAITiK0xN8FXUXIOc8lRPA275NFmdrXuA4JXf8PEDUGGuvsex2egoVh9qYn?=
 =?us-ascii?Q?ayVwHNmO7trCQxLzx+6LgyaihbiRWv9cBlfC+klin0eUW/VEb/xJO+ZJ95Pl?=
 =?us-ascii?Q?OBvr1axzpsrz0aL5WZdN003Zg1MB5Q6NZ9G2tQWapMMa+i3M2FMrGZ3QsfYw?=
 =?us-ascii?Q?PAOARYL+ZPgrOkDHBptGJl47o6J7QXnkt9SDS8MYzjiX0L9qTn3jwi0PTI2W?=
 =?us-ascii?Q?/gVYg1touN4bf2UWL5WTExmkKMkGl1noweOwwwEMt/aD7SOSvzU8fxIVOidp?=
 =?us-ascii?Q?tFVo6JI3lK0GgDVvDc+6cLEaSrV+bXIPuOiGHuTv/Ud3W2mw8Xj0yTYXFhcN?=
 =?us-ascii?Q?JVZetNLNtMA683D+s12tQtnU7W1wss3u34Gl2meAUgzzvUk4g4QH0ez0YpTz?=
 =?us-ascii?Q?xfsu/bRpmv5eydVAmYRamRc+gcTN3sPqx3zi/xQ5ESsCTRqxfSGK0vrzoGVv?=
 =?us-ascii?Q?u7XY2tTZy5sMfYMD8EdxEkNI5NI0DnAP3n15X4tVHp69G62VjMZNLNaMVZ6r?=
 =?us-ascii?Q?wqd95pE0+C+u4HTJ/nF6cKQV7rvZuMI17QVmOBrm7RE/BvTg53q4MM4NBu4A?=
 =?us-ascii?Q?pzr6FmBOCX2kadpV+gVXUZdOU7QqEOc+5pd+gm1bch0+wWoh2uJEyFMux8wc?=
 =?us-ascii?Q?RLTFCSwXnlboD4LU6acwz14fFrecorUJ2lRDyRKAhStVTmDxZQhlB/oVzJ4e?=
 =?us-ascii?Q?yqbBSdVbyUpYaNarN4V6zwGKdPbTxVNvL++AY+X5Ml6D5XbzvahsQrgbaDEV?=
 =?us-ascii?Q?7kTqrqXu8hjc5MILdRC0SpV6TadeuSQWui9YhI4/2Z2CrPDpsjEjzAJsktyq?=
 =?us-ascii?Q?qECe9ids1/OdqUUzk8NKpCPnd2S6VeUJMHiFrW0ZYqYv4C1+fUua1L/tK7fY?=
 =?us-ascii?Q?p6BU440ZUN4BcLuYrtPU9Bjjj11reeIO6J1dM1Rr54s/xTNdnqli8doE0ufS?=
 =?us-ascii?Q?3+4m0IUI+RBBfDkIIBPWXsACgkZLPpaKMmM077ousDPBnmzBu+edyGmOsIl1?=
 =?us-ascii?Q?c40ID5UA/DAM/bZ1oL3BJiOeXSegii+Ug0XVysuOo+NX4zyTWaZLMbzsRTk8?=
 =?us-ascii?Q?+I1+NJ/oZx41MTKmtOtY8dqE?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <699332976C30EA428A804AD0E23FBBEA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e69e1d7-0f21-43b7-93aa-08d8e7bedd19
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 14:30:21.0944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hWE+/Lt35uW4RcJamqwEGFnADuVamusir+ffvsG0gk5iPd2x5qlNIHwTbPV3shmYPAbC8g9TsI7tc9IVSmOPHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2869
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150105
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150105
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 13, 2021, at 4:08 PM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> In order to ensure that knfsd threads don't linger once the nfsd
> pseudofs is unmounted (e.g. when the container is killed) we let
> nfsd_umount() shut down those threads and wait for them to exit.
>=20
> This also should ensure that we don't need to do a kernel mount of
> the pseudofs, since the thread lifetime is now limited by the
> lifetime of the filesystem.
>=20
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Hey Trond, I've included your patch in the for-next topic branch at

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


> ---
> fs/nfsd/netns.h     |  6 +++---
> fs/nfsd/nfs4state.c |  8 +-------
> fs/nfsd/nfsctl.c    | 14 ++------------
> fs/nfsd/nfsd.h      |  3 +--
> fs/nfsd/nfssvc.c    | 35 ++++++++++++++++++++++++++++++++++-
> 5 files changed, 41 insertions(+), 25 deletions(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index c330f5bd0cf3..a75abeb1e698 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -51,9 +51,6 @@ struct nfsd_net {
> 	bool grace_ended;
> 	time64_t boot_time;
>=20
> -	/* internal mount of the "nfsd" pseudofilesystem: */
> -	struct vfsmount *nfsd_mnt;
> -
> 	struct dentry *nfsd_client_dir;
>=20
> 	/*
> @@ -130,6 +127,9 @@ struct nfsd_net {
> 	wait_queue_head_t ntf_wq;
> 	atomic_t ntf_refcnt;
>=20
> +	/* Allow umount to wait for nfsd state cleanup */
> +	struct completion nfsd_shutdown_complete;
> +
> 	/*
> 	 * clientid and stateid data for construction of net unique COPY
> 	 * stateids.
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 423fd6683f3a..8bf840661d67 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7346,14 +7346,9 @@ nfs4_state_start_net(struct net *net)
> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> 	int ret;
>=20
> -	ret =3D get_nfsdfs(net);
> -	if (ret)
> -		return ret;
> 	ret =3D nfs4_state_create_net(net);
> -	if (ret) {
> -		mntput(nn->nfsd_mnt);
> +	if (ret)
> 		return ret;
> -	}
> 	locks_start_grace(net, &nn->nfsd4_manager);
> 	nfsd4_client_tracking_init(net);
> 	if (nn->track_reclaim_completes && nn->reclaim_str_hashtbl_size =3D=3D 0=
)
> @@ -7423,7 +7418,6 @@ nfs4_state_shutdown_net(struct net *net)
>=20
> 	nfsd4_client_tracking_exit(net);
> 	nfs4_state_destroy_net(net);
> -	mntput(nn->nfsd_mnt);
> }
>=20
> void
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index ef86ed23af82..02ff7f762e2d 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1416,6 +1416,8 @@ static void nfsd_umount(struct super_block *sb)
> {
> 	struct net *net =3D sb->s_fs_info;
>=20
> +	nfsd_shutdown_threads(net);
> +
> 	kill_litter_super(sb);
> 	put_net(net);
> }
> @@ -1428,18 +1430,6 @@ static struct file_system_type nfsd_fs_type =3D {
> };
> MODULE_ALIAS_FS("nfsd");
>=20
> -int get_nfsdfs(struct net *net)
> -{
> -	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> -	struct vfsmount *mnt;
> -
> -	mnt =3D  vfs_kern_mount(&nfsd_fs_type, SB_KERNMOUNT, "nfsd", NULL);
> -	if (IS_ERR(mnt))
> -		return PTR_ERR(mnt);
> -	nn->nfsd_mnt =3D mnt;
> -	return 0;
> -}
> -
> #ifdef CONFIG_PROC_FS
> static int create_proc_exports_entry(void)
> {
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 8bdc37aa2c2e..27c1308ffc2b 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -93,13 +93,12 @@ int		nfsd_get_nrthreads(int n, int *, struct net *);
> int		nfsd_set_nrthreads(int n, int *, struct net *);
> int		nfsd_pool_stats_open(struct inode *, struct file *);
> int		nfsd_pool_stats_release(struct inode *, struct file *);
> +void		nfsd_shutdown_threads(struct net *net);
>=20
> void		nfsd_destroy(struct net *net);
>=20
> bool		i_am_nfsd(void);
>=20
> -int get_nfsdfs(struct net *);
> -
> struct nfsdfs_client {
> 	struct kref cl_ref;
> 	void (*cl_release)(struct kref *kref);
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 6de406322106..f014b7aa0726 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -596,6 +596,37 @@ static const struct svc_serv_ops nfsd_thread_sv_ops =
=3D {
> 	.svo_module		=3D THIS_MODULE,
> };
>=20
> +static void nfsd_complete_shutdown(struct net *net)
> +{
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +
> +	WARN_ON(!mutex_is_locked(&nfsd_mutex));
> +
> +	nn->nfsd_serv =3D NULL;
> +	complete(&nn->nfsd_shutdown_complete);
> +}
> +
> +void nfsd_shutdown_threads(struct net *net)
> +{
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	struct svc_serv *serv;
> +
> +	mutex_lock(&nfsd_mutex);
> +	serv =3D nn->nfsd_serv;
> +	if (serv =3D=3D NULL) {
> +		mutex_unlock(&nfsd_mutex);
> +		return;
> +	}
> +
> +	svc_get(serv);
> +	/* Kill outstanding nfsd threads */
> +	serv->sv_ops->svo_setup(serv, NULL, 0);
> +	nfsd_destroy(net);
> +	mutex_unlock(&nfsd_mutex);
> +	/* Wait for shutdown of nfsd_serv to complete */
> +	wait_for_completion(&nn->nfsd_shutdown_complete);
> +}
> +
> bool i_am_nfsd(void)
> {
> 	return kthread_func(current) =3D=3D nfsd;
> @@ -618,11 +649,13 @@ int nfsd_create_serv(struct net *net)
> 						&nfsd_thread_sv_ops);
> 	if (nn->nfsd_serv =3D=3D NULL)
> 		return -ENOMEM;
> +	init_completion(&nn->nfsd_shutdown_complete);
>=20
> 	nn->nfsd_serv->sv_maxconn =3D nn->max_connections;
> 	error =3D svc_bind(nn->nfsd_serv, net);
> 	if (error < 0) {
> 		svc_destroy(nn->nfsd_serv);
> +		nfsd_complete_shutdown(net);
> 		return error;
> 	}
>=20
> @@ -671,7 +704,7 @@ void nfsd_destroy(struct net *net)
> 		svc_shutdown_net(nn->nfsd_serv, net);
> 	svc_destroy(nn->nfsd_serv);
> 	if (destroy)
> -		nn->nfsd_serv =3D NULL;
> +		nfsd_complete_shutdown(net);
> }
>=20
> int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
> --=20
> 2.30.2
>=20

--
Chuck Lever



