Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF9E1849AC
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2020 15:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgCMOlx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Mar 2020 10:41:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50144 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgCMOlx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Mar 2020 10:41:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DEciLe049372;
        Fri, 13 Mar 2020 14:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=QlE6BF79h5NHgpRDoUzcEpSw7XtvD4SHXlP4GYYf3VA=;
 b=S1bt9EkGWwXQBnUMyE2nxcKa3Uibg2o1uu4274js9Hf+wX8fXyY0x7LJFEVmiQQpa84C
 v8KUi2X5KNcRf7qR5Ehz+2IlcW3+TQeKFL570kDpL02p5fUWKJmrOheI59DHkKO1o3zo
 nnBJ1AWPtBqV4/qynKfgYZtgfPMmtgOkVbG+DA0OmNhtCaTzetAELgw5nXcslzPjlpXO
 moSvEUGYnqB68PRAOZIuwicMVWPVqmBKiWHXnog3V7F7lJPw8MCIiAvbe+eG2vwmJg6z
 kmMTYqM8pAmUHxDH1H2q5dpb81fdHmJuQ2mNAJSr0JgB8+yQ3jab3a+aoYg/XKsn8U6D sg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2yqtagc7tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Mar 2020 14:41:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DEcLEt065974;
        Fri, 13 Mar 2020 14:41:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2yqtad9x9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Mar 2020 14:41:46 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02DEfjQS016592;
        Fri, 13 Mar 2020 14:41:45 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Mar 2020 07:41:45 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/1] nfsd: remove read permission bit for ctl sysctl
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200313123957.6122-1-pvorel@suse.cz>
Date:   Fri, 13 Mar 2020 10:41:44 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A8BA7E5-C24D-4FA6-9D4B-1216398CDF38@oracle.com>
References: <20200313123957.6122-1-pvorel@suse.cz>
To:     Petr Vorel <pvorel@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130077
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 13, 2020, at 8:39 AM, Petr Vorel <pvorel@suse.cz> wrote:
>=20
> It's meant to be read only.
>=20
> Fixes: 89c905beccbb ("nfsd: allow forced expiration of NFSv4 clients")
>=20
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
>=20
> does not really fix anything, it's just confusing to have read
> permission bit when not used.

Hi Petr, applied to nfsd-5.7-testing, with the patch description =
corrected
to read:

"It's meant to be write-only."


> Kind regards,
> Petr
>=20
> fs/nfsd/nfs4state.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 65cfe9ab47be..475ece438cfc 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2636,7 +2636,7 @@ static const struct file_operations =
client_ctl_fops =3D {
> static const struct tree_descr client_files[] =3D {
> 	[0] =3D {"info", &client_info_fops, S_IRUSR},
> 	[1] =3D {"states", &client_states_fops, S_IRUSR},
> -	[2] =3D {"ctl", &client_ctl_fops, S_IRUSR|S_IWUSR},
> +	[2] =3D {"ctl", &client_ctl_fops, S_IWUSR},
> 	[3] =3D {""},
> };

--
Chuck Lever



