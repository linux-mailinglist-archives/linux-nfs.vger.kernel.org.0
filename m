Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6072CA7CB
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 17:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388738AbgLAQKP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 11:10:15 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:32974 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388716AbgLAQKP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Dec 2020 11:10:15 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1G4vKR062861;
        Tue, 1 Dec 2020 16:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=pTOz3/VlSywwEN8OmV2/WhPRxU1ypLQsFUMKKQMLxA4=;
 b=ZJIHuceI/q7hEppUOohWtNd+YEF3+ULqbL61jU3e9QdH0ttRrK3WLrK9VvuDkNWuvo8q
 6wigVW+rz2pE19gQE3N7aGkNGjbrPSTQmgCUTz+O/fGTbuYBcfBN6UEPyqJbd7Tc96Kw
 PwTXnfEUbo7M3Ut1Jb8QVmea96FZOBm9IvKxG0al9MK+x51O8pte4R+Gu8QnSNSzCvfu
 U87b9fs3W+HsvJcnxAjdgLtUwCDhslFIq0nMYNXvFoUu+xwFqnVW44uLMG+6B229b4lV
 RCqYF0R1KMvxaxtrhgNl3QokLxElYEo9bjocioYigpET+T8LerFFE3uGUtp/SJDKZyZM Vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 353c2auhbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Dec 2020 16:09:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1G65mx042668;
        Tue, 1 Dec 2020 16:07:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 3540ey5ppv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Dec 2020 16:07:25 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B1G7I1j023319;
        Tue, 1 Dec 2020 16:07:20 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Dec 2020 08:07:18 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] nfs_common: need lock during iterate through the list
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201201120635.5127-1-wang.yi59@zte.com.cn>
Date:   Tue, 1 Dec 2020 11:07:17 -0500
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xue.zhihong@zte.com.cn, wang.liang82@zte.com.cn,
        Cheng Lin <cheng.lin130@zte.com.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4E2EB304-EE09-424C-9939-48A9BE1C539A@oracle.com>
References: <20201201120635.5127-1-wang.yi59@zte.com.cn>
To:     Yi Wang <wang.yi59@zte.com.cn>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=1 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 lowpriorityscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010101
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello!

> On Dec 1, 2020, at 7:06 AM, Yi Wang <wang.yi59@zte.com.cn> wrote:
>=20
> From: Cheng Lin <cheng.lin130@zte.com.cn>=20
>=20
> If the elem is deleted during be iterated on it, the iteration
> process will fall into an endless loop.
>=20
> kernel: NMI watchdog: BUG: soft lockup - CPU#4 stuck for 22s! =
[nfsd:17137]
>=20
> PID: 17137  TASK: ffff8818d93c0000  CPU: 4   COMMAND: "nfsd"=20
>     [exception RIP: __state_in_grace+76]
>     RIP: ffffffffc00e817c  RSP: ffff8818d3aefc98  RFLAGS: 00000246
>     RAX: ffff881dc0c38298  RBX: ffffffff81b03580  RCX: =
ffff881dc02c9f50
>     RDX: ffff881e3fce8500  RSI: 0000000000000001  RDI: =
ffffffff81b03580
>     RBP: ffff8818d3aefca0   R8: 0000000000000020   R9: =
ffff8818d3aefd40
>     R10: ffff88017fc03800  R11: ffff8818e83933c0  R12: =
ffff8818d3aefd40
>     R13: 0000000000000000  R14: ffff8818e8391068  R15: =
ffff8818fa6e4000
>     CS: 0010  SS: 0018
>  #0 [ffff8818d3aefc98] opens_in_grace at ffffffffc00e81e3 [grace]
>  #1 [ffff8818d3aefca8] nfs4_preprocess_stateid_op at ffffffffc02a3e6c =
[nfsd]
>  #2 [ffff8818d3aefd18] nfsd4_write at ffffffffc028ed5b [nfsd]
>  #3 [ffff8818d3aefd80] nfsd4_proc_compound at ffffffffc0290a0d [nfsd]
>  #4 [ffff8818d3aefdd0] nfsd_dispatch at ffffffffc027b800 [nfsd]
>  #5 [ffff8818d3aefe08] svc_process_common at ffffffffc02017f3 [sunrpc]
>  #6 [ffff8818d3aefe70] svc_process at ffffffffc0201ce3 [sunrpc]
>  #7 [ffff8818d3aefe98] nfsd at ffffffffc027b117 [nfsd]
>  #8 [ffff8818d3aefec8] kthread at ffffffff810b88c1
>  #9 [ffff8818d3aeff50] ret_from_fork at ffffffff816d1607
>=20
> The troublemake elem:
> crash> lock_manager ffff881dc0c38298
> struct lock_manager {
>   list =3D {
>     next =3D 0xffff881dc0c38298,
>     prev =3D 0xffff881dc0c38298
>   },
>   block_opens =3D false
> }
>=20
> Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>=20
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>=20
> ---
>  fs/nfs_common/grace.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfs_common/grace.c b/fs/nfs_common/grace.c
> index b73d9dd37..26f2a50ec 100644
> --- a/fs/nfs_common/grace.c
> +++ b/fs/nfs_common/grace.c
> @@ -69,10 +69,14 @@ __state_in_grace(struct net *net, bool open)
>      if (!open)
>          return !list_empty(grace_list);
>  =20
> +    spin_lock(&grace_lock);
>      list_for_each_entry(lm, grace_list, list) {
> -        if (lm->block_opens)
> +        if (lm->block_opens) {
> +            spin_unlock(&grace_lock);
>              return true;
> +        }
>      }
> +    spin_unlock(&grace_lock);
>      return false;
>  }
>  =20
> --

This looks most closely related to NFSD, so I've applied it to
my NFSD tree for the next merge window. I've also added

Fixes: c87fb4a378f9 ("lockd: NLM grace period shouldn't block NFSv4 =
opens")

You can find it in the cel-next topic branch in my kernel repo:

git://git.linux-nfs.org/projects/cel/cel-2.6.git

Incidentally, the e-mail encoding mangled the white space and I
don't see the e-mail showing up on lore.kernel.org. I applied it
by hand since it was small, but this should be addressed for
future patches so our patch handling infrastructure can deal
properly with your submissions. Thanks!


--
Chuck Lever



