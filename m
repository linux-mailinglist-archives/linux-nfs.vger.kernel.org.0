Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740C723BC7
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2019 17:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbfETPMw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 May 2019 11:12:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39364 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733009AbfETPMw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 May 2019 11:12:52 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4KF4kW1145104;
        Mon, 20 May 2019 15:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=xmkRE8yTKn1GwlYJAqEL4WpXXcRG/Uxsjn1XQ73w5wg=;
 b=VKnuUQsmFbtYt+H5wwzBIptggqezpJAJ6QWW3Z39aQoD+FcaNwt007oTSjmPzZZ5B5iI
 WDefKzCREDqLvhlN2KuwUj0AA5MkZFk1y5H6ZiXBh5NpIdciUoV9RAfhnwQhoR8aYxwU
 6G3+z2yDulBx0oTbiNYG3xJ6oa2QWbyNJD3L7UHEMPhoebPKPkYQH4AN5vEiUOj8g8HL
 LpctH44q01aPgv36LA8HsvEowMjCS81rMfPj+CxtBYY/veorftLuTKyDyNQvAesn0q6/
 r/3j2O8ADKR3RLKYmu0sAP1o4087KfhBkm6NIsn4vDqUKoe+/ljSyya41k1JGa87JbSp +Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2sj7jdfu7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 15:12:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4KFA20G189053;
        Mon, 20 May 2019 15:10:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2sks18ncu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 15:10:21 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4KFAJUK027332;
        Mon, 20 May 2019 15:10:19 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 May 2019 15:10:18 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] NFSv4: Add lease_time and lease_expired to 'nfs4:' line
 of mountstats
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1558127201-7481-1-git-send-email-dwysocha@redhat.com>
Date:   Mon, 20 May 2019 11:10:17 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <230AB123-B417-4F6F-A50C-053B9B3E0C19@oracle.com>
References: <1558127201-7481-1-git-send-email-dwysocha@redhat.com>
To:     Dave Wysochanski <dwysocha@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905200099
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905200099
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 17, 2019, at 5:06 PM, Dave Wysochanski <dwysocha@redhat.com> =
wrote:
>=20
> On the NFS client there is no low-impact way to determine the nfs4
> lease time or whether the lease is expired, so add these to mountstats
> with times displayed in seconds.
>=20
> If the lease is not expired, display lease_expired=3D0. Otherwise,
> display lease_expired=3Dseconds_since_expired, similar to 'age:' line
> in mountstats.
>=20
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> ---
> fs/nfs/super.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>=20
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index c27ac96..6e52f0c 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -730,6 +730,16 @@ int nfs_show_options(struct seq_file *m, struct =
dentry *root)
> EXPORT_SYMBOL_GPL(nfs_show_options);
>=20
> #if IS_ENABLED(CONFIG_NFS_V4)
> +static void show_lease(struct seq_file *m, struct nfs_server *server)
> +{
> +	struct nfs_client *clp =3D server->nfs_client;
> +	unsigned long expire;
> +
> +	seq_printf(m, ",lease_time=3D%ld", clp->cl_lease_time / HZ);
> +	expire =3D clp->cl_last_renewal + clp->cl_lease_time;
> +	seq_printf(m, ",lease_expired=3D%ld",
> +		   time_after(expire, jiffies) ?  0 : (jiffies - expire) =
/ HZ);
> +}
> #ifdef CONFIG_NFS_V4_1
> static void show_sessions(struct seq_file *m, struct nfs_server =
*server)
> {
> @@ -838,6 +848,7 @@ int nfs_show_stats(struct seq_file *m, struct =
dentry *root)
> 		seq_printf(m, ",acl=3D0x%x", nfss->acl_bitmask);
> 		show_sessions(m, nfss);
> 		show_pnfs(m, nfss);
> +		show_lease(m, nfss);
> 	}
> #endif
>=20
> --=20
> 1.8.3.1
>=20

I didn't look closely at the patch content, but IMO this is a good
observability enhancement.


--
Chuck Lever



