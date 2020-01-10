Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFF971379DB
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2020 23:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgAJWsD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jan 2020 17:48:03 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45324 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbgAJWsD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jan 2020 17:48:03 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00AMh3JF101890;
        Fri, 10 Jan 2020 22:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=Ms/jNJ2MlTOuVdEnCXcgFk7tD96pF463raJJQMZ90xE=;
 b=FZcYxmzbjWWsirlK2XNV5/seyIgxVaF7n1qkoMYfQ3I1tqOuSDxXHrIPxBNPq4DaqKY7
 jQb79HkUEAxnlDoJAKY2uM3Rc4zBOt8JH/kBl45J6lrdkBjbBMF/g8cHWrcmO9+AEFtA
 R2Dlf8jeMHersfuqgwzqm2MIB0ywQKz0CBxoM06XNGLLei+VW2FBRY2rymriLz74jHZs
 JImz1rMt9KV4Jleqjz+ELL0j6gJj7/f3Fy3/8gz6Ioj1gRKgJBvOiW5/w13k3ux+YhBP
 x7SF5teLpMC05dcz/4mlP30rvPBg4XbQ+9SjeYOssXLArPwc8ciXBF3MANfiyDIaWLaO fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xaj4un7ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jan 2020 22:47:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00AMiI34004766;
        Fri, 10 Jan 2020 22:45:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xevfdwgm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jan 2020 22:45:55 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00AMjsOq018106;
        Fri, 10 Jan 2020 22:45:55 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Jan 2020 14:45:54 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 7/7] NFS: Add a mount option for READ_PLUS
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1e12cb6b0f5176263fe52fd624947a6e76f414d2.camel@netapp.com>
Date:   Fri, 10 Jan 2020 17:45:53 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "Trond.Myklebust@hammerspace.com" <Trond.Myklebust@hammerspace.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <88BBC7E6-695A-49EA-999F-6D07EEE0A6F3@oracle.com>
References: <20200110223455.528471-1-Anna.Schumaker@Netapp.com>
 <20200110223455.528471-8-Anna.Schumaker@Netapp.com>
 <41391995-F61E-4CA4-80C5-542A8B2A3947@oracle.com>
 <1e12cb6b0f5176263fe52fd624947a6e76f414d2.camel@netapp.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9496 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001100189
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9496 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001100189
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 10, 2020, at 5:43 PM, Schumaker, Anna =
<Anna.Schumaker@netapp.com> wrote:
>=20
> Hi Chuck,
>=20
> On Fri, 2020-01-10 at 17:41 -0500, Chuck Lever wrote:
>> NetApp Security WARNING: This is an external email. Do not click =
links or open
>> attachments unless you recognize the sender and know the content is =
safe.
>>=20
>>=20
>>=20
>>=20
>> Hi Anna-
>>=20
>>> On Jan 10, 2020, at 5:34 PM, schumaker.anna@gmail.com wrote:
>>>=20
>>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>=20
>>> There are some workloads where READ_PLUS might end up hurting
>>> performance,
>>=20
>> Can you say more about this? Have you seen workloads that are
>> hurt by READ_PLUS? Nothing jumps out at me from the tables in
>> the cover letter.
>=20
> It's mostly something I've seen when using btrfs in a virtual machine =
(so
> probably not a wide use case, and it's possible I need to change =
something in my
> setup to get it working better).
>=20
>>=20
>>=20
>>> so let's be nice to users and provide a way to disable this
>>> operation similar to how READDIR_PLUS can be disabled.
>>=20
>> Does it make sense to hold off on a mount option until there
>> is evidence that there is no other way to work around such a
>> performance regression?
>>=20
>> - Attempt to address the regression directly
>> - Improve the heuristics about when READ_PLUS is used
>> - Document that dropping back to vers=3D4.1 will disable it
>=20
> Yeah, we could hold off on the patch for now and see if anybody has =
any issues
> first.
>=20
>>=20
>> Any experience with NFS/RDMA?
>=20
> Not yet, but I can try to test that next week.

Thanks for your response!


> Anna
>=20
>>=20
>>=20
>>> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>> ---
>>> fs/nfs/fs_context.c       | 14 ++++++++++++++
>>> fs/nfs/nfs4client.c       |  3 +++
>>> include/linux/nfs_fs_sb.h |  1 +
>>> 3 files changed, 18 insertions(+)
>>>=20
>>> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
>>> index 0247dcb7b316..82ba07c7c1ce 100644
>>> --- a/fs/nfs/fs_context.c
>>> +++ b/fs/nfs/fs_context.c
>>> @@ -64,6 +64,7 @@ enum nfs_param {
>>>      Opt_proto,
>>>      Opt_rdirplus,
>>>      Opt_rdma,
>>> +     Opt_readplus,
>>>      Opt_resvport,
>>>      Opt_retrans,
>>>      Opt_retry,
>>> @@ -120,6 +121,7 @@ static const struct fs_parameter_spec =
nfs_param_specs[]
>>> =3D {
>>>      fsparam_string("proto",         Opt_proto),
>>>      fsparam_flag_no("rdirplus",     Opt_rdirplus),
>>>      fsparam_flag  ("rdma",          Opt_rdma),
>>> +     fsparam_flag_no("readplus",     Opt_readplus),
>>>      fsparam_flag_no("resvport",     Opt_resvport),
>>>      fsparam_u32   ("retrans",       Opt_retrans),
>>>      fsparam_string("retry",         Opt_retry),
>>> @@ -555,6 +557,12 @@ static int nfs_fs_context_parse_param(struct =
fs_context
>>> *fc,
>>>              else
>>>                      ctx->options |=3D NFS_OPTION_MIGRATION;
>>>              break;
>>> +     case Opt_readplus:
>>> +             if (result.negated)
>>> +                     ctx->options |=3D NFS_OPTION_NO_READ_PLUS;
>>> +             else
>>> +                     ctx->options &=3D ~NFS_OPTION_NO_READ_PLUS;
>>> +             break;
>>>=20
>>>              /*
>>>               * options that take numeric values
>>> @@ -1176,6 +1184,10 @@ static int nfs_fs_context_validate(struct =
fs_context
>>> *fc)
>>>          (ctx->version !=3D 4 || ctx->minorversion !=3D 0))
>>>              goto out_migration_misuse;
>>>=20
>>> +     if (ctx->options & NFS_OPTION_NO_READ_PLUS &&
>>> +         (ctx->version !=3D 4 || ctx->minorversion < 2))
>>> +             goto out_noreadplus_misuse;
>>> +
>>>      /* Verify that any proto=3D/mountproto=3D options match the =
address
>>>       * families in the addr=3D/mountaddr=3D options.
>>>       */
>>> @@ -1254,6 +1266,8 @@ static int nfs_fs_context_validate(struct =
fs_context
>>> *fc)
>>>                        ctx->version, ctx->minorversion);
>>> out_migration_misuse:
>>>      return nfs_invalf(fc, "NFS: 'Migration' not supported for this =
NFS
>>> version");
>>> +out_noreadplus_misuse:
>>> +     return nfs_invalf(fc, "NFS: 'noreadplus' not supported for =
this NFS
>>> version\n");
>>> out_version_unavailable:
>>>      nfs_errorf(fc, "NFS: Version unavailable");
>>>      return ret;
>>> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
>>> index 0cd767e5c977..868dc3c36ba1 100644
>>> --- a/fs/nfs/nfs4client.c
>>> +++ b/fs/nfs/nfs4client.c
>>> @@ -1016,6 +1016,9 @@ static int nfs4_server_common_setup(struct =
nfs_server
>>> *server,
>>>      server->caps |=3D server->nfs_client->cl_mvops->init_caps;
>>>      if (server->flags & NFS_MOUNT_NORDIRPLUS)
>>>                      server->caps &=3D ~NFS_CAP_READDIRPLUS;
>>> +     if (server->options & NFS_OPTION_NO_READ_PLUS)
>>> +             server->caps &=3D ~NFS_CAP_READ_PLUS;
>>> +
>>>      /*
>>>       * Don't use NFS uid/gid mapping if we're using AUTH_SYS or =
lower
>>>       * authentication.
>>> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
>>> index 11248c5a7b24..360e70c7bbb6 100644
>>> --- a/include/linux/nfs_fs_sb.h
>>> +++ b/include/linux/nfs_fs_sb.h
>>> @@ -172,6 +172,7 @@ struct nfs_server {
>>>      unsigned int            clone_blksize;  /* granularity of a =
CLONE
>>> operation */
>>> #define NFS_OPTION_FSCACHE    0x00000001      /* - local caching =
enabled */
>>> #define NFS_OPTION_MIGRATION  0x00000002      /* - NFSv4 migration =
enabled
>>> */
>>> +#define NFS_OPTION_NO_READ_PLUS      0x00000004      /* - NFSv4.2 =
READ_PLUS
>>> enabled */
>>>=20
>>>      struct nfs_fsid         fsid;
>>>      __u64                   maxfilesize;    /* maximum file size */
>>> --
>>> 2.24.1
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20

--
Chuck Lever



