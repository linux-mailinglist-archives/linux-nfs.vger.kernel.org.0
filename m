Return-Path: <linux-nfs+bounces-11701-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F34AB5BDC
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 19:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1A9F4C0E2D
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 17:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C803D2BFC6C;
	Tue, 13 May 2025 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuqQVUbO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BFF2C2AB1
	for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747158611; cv=none; b=aOHdNIS6Kn9NLqeM7y3Iq5V2xI12A28uwGEZaEz7wfBTzbN4/JsYdWZZAlOwuLQpZydb28pOSsG994TzHdm3OxDgoIL0yXtf4DXqnarNh85B73nxFjO1Z3StlOqPgqNlPwET0GoisUkzXZCbfFbEoI58BSOleeh6MQAkV+bxGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747158611; c=relaxed/simple;
	bh=YJSrV6T8sxPjZqNXVHskQpT1iRmuJC8Ydz8/ZcSsdso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hp8Iu9VxRV/qbJgaFIqcA069dNTM+9GtaoMXTsT9F9B1VZFgcL4fpTWqSM0VtItSWlD9/NHypuR6z9LNtVnbk+cuJjnY76ce8wywlt3aAd2tpqxyBV3cSfLFUEjGlB9Iy3SMXCkqffP/BKs1dbf0VJUocM2k7K8v/wY/KZqzwVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OuqQVUbO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747158608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4bVf9ZNn7cPvLdxzlLtWP+OOGhy4MfZrE3WBXP6aUI=;
	b=OuqQVUbOzoy5IEKQI0WUh+w3ZMF9wWz/vRXWLXff8KpDOcdM4keQbZMhq/iEz2F38aXmKz
	JR/40zUq8iHpyr9Ek9qIsCDil80IY7H8NqpOd3GkTPC5mXT+Itb4b1Om+AbfOdJtOn8lQR
	V99vd9q7Znjb5PomoeZNClrtawMZ/Zo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-4YxHi1ANN0yq354MywpXJQ-1; Tue,
 13 May 2025 13:50:06 -0400
X-MC-Unique: 4YxHi1ANN0yq354MywpXJQ-1
X-Mimecast-MFC-AGG-ID: 4YxHi1ANN0yq354MywpXJQ_1747158605
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9EDC1800874;
	Tue, 13 May 2025 17:50:05 +0000 (UTC)
Received: from [10.22.88.54] (unknown [10.22.88.54])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19A961953B80;
	Tue, 13 May 2025 17:50:04 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: =?utf-8?q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH v2] nfsv4: Add support for the birth time attribute
Date: Tue, 13 May 2025 13:47:53 -0400
Message-ID: <5F6FC0B6-D88A-4144-BE9B-D95867396BD0@redhat.com>
In-Reply-To: <CA+1jF5puYFtPJ+sdUxHEy9JrOeq13VW-ROXpj8UwOZz4b4hsLw@mail.gmail.com>
References: <20230901083421.2139-1-chenhx.fnst@fujitsu.com>
 <3461ADBE-EAD4-4EEF-B7B0-45348BCDB92C@redhat.com>
 <CA+1jF5puYFtPJ+sdUxHEy9JrOeq13VW-ROXpj8UwOZz4b4hsLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 13 May 2025, at 12:36, Aur=C3=A9lien Couderc wrote:

> On Tue, May 13, 2025 at 6:08=E2=80=AFPM Benjamin Coddington <bcodding@r=
edhat.com> wrote:
>>
>> I'm interested in this work, Chen are you still interested in moving t=
his
>> forward?   I have another question below --
>>
>> On 1 Sep 2023, at 4:34, Chen Hanxiao wrote:
>>
>>> nfsd already support btime by commit e377a3e698.
>>>
>>> This patch enable nfs to report btime in nfs_getattr.
>>> If underlying filesystem supports "btime" timestamp,
>>> statx will report btime for STATX_BTIME.
>>>
>>> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
>>>
>>> ---
>>> v1.1:
>>>       minor fix
>>> v2:
>>>       properly set cache validity
>>>
>>>  fs/nfs/inode.c          | 28 ++++++++++++++++++++++++----
>>>  fs/nfs/nfs4proc.c       |  3 +++
>>>  fs/nfs/nfs4xdr.c        | 23 +++++++++++++++++++++++
>>>  include/linux/nfs_fs.h  |  2 ++
>>>  include/linux/nfs_xdr.h |  5 ++++-
>>>  5 files changed, 56 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
>>> index 8172dd4135a1..cfdf68b07982 100644
>>> --- a/fs/nfs/inode.c
>>> +++ b/fs/nfs/inode.c
>>> @@ -196,7 +196,8 @@ void nfs_set_cache_invalid(struct inode *inode, u=
nsigned long flags)
>>>               if (!(flags & NFS_INO_REVAL_FORCED))
>>>                       flags &=3D ~(NFS_INO_INVALID_MODE |
>>>                                  NFS_INO_INVALID_OTHER |
>>> -                                NFS_INO_INVALID_XATTR);
>>> +                                NFS_INO_INVALID_XATTR |
>>> +                                NFS_INO_INVALID_BTIME);
>>>               flags &=3D ~(NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_S=
IZE);
>>>       }
>>>
>>> @@ -515,6 +516,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *=
fh, struct nfs_fattr *fattr)
>>>               memset(&inode->i_atime, 0, sizeof(inode->i_atime));
>>>               memset(&inode->i_mtime, 0, sizeof(inode->i_mtime));
>>>               memset(&inode->i_ctime, 0, sizeof(inode->i_ctime));
>>> +             memset(&nfsi->btime, 0, sizeof(nfsi->btime));
>>>               inode_set_iversion_raw(inode, 0);
>>>               inode->i_size =3D 0;
>>>               clear_nlink(inode);
>>> @@ -538,6 +540,10 @@ nfs_fhget(struct super_block *sb, struct nfs_fh =
*fh, struct nfs_fattr *fattr)
>>>                       inode->i_ctime =3D fattr->ctime;
>>>               else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
>>>                       nfs_set_cache_invalid(inode, NFS_INO_INVALID_CT=
IME);
>>> +             if (fattr->valid & NFS_ATTR_FATTR_BTIME)
>>> +                     nfsi->btime =3D fattr->btime;
>>> +             else if (fattr_supported & NFS_ATTR_FATTR_BTIME)
>>> +                     nfs_set_cache_invalid(inode, NFS_INO_INVALID_BT=
IME);
>>>               if (fattr->valid & NFS_ATTR_FATTR_CHANGE)
>>>                       inode_set_iversion_raw(inode, fattr->change_att=
r);
>>>               else
>>> @@ -835,6 +841,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const st=
ruct path *path,
>>>  {
>>>       struct inode *inode =3D d_inode(path->dentry);
>>>       struct nfs_server *server =3D NFS_SERVER(inode);
>>> +     struct nfs_inode *nfsi =3D NFS_I(inode);
>>>       unsigned long cache_validity;
>>>       int err =3D 0;
>>>       bool force_sync =3D query_flags & AT_STATX_FORCE_SYNC;
>>> @@ -845,7 +852,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const st=
ruct path *path,
>>>
>>>       request_mask &=3D STATX_TYPE | STATX_MODE | STATX_NLINK | STATX=
_UID |
>>>                       STATX_GID | STATX_ATIME | STATX_MTIME | STATX_C=
TIME |
>>> -                     STATX_INO | STATX_SIZE | STATX_BLOCKS |
>>> +                     STATX_INO | STATX_SIZE | STATX_BLOCKS | STATX_B=
TIME |
>>>                       STATX_CHANGE_COOKIE;
>>>
>>>       if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
>>> @@ -920,6 +927,10 @@ int nfs_getattr(struct mnt_idmap *idmap, const s=
truct path *path,
>>>               stat->attributes |=3D STATX_ATTR_CHANGE_MONOTONIC;
>>>       if (S_ISDIR(inode->i_mode))
>>>               stat->blksize =3D NFS_SERVER(inode)->dtsize;
>>> +     if (!(server->fattr_valid & NFS_ATTR_FATTR_BTIME))
>>> +             stat->result_mask &=3D ~STATX_BTIME;
>>> +     else
>>> +             stat->btime =3D nfsi->btime;
>>>  out:
>>>       trace_nfs_getattr_exit(inode, err);
>>>       return err;
>>> @@ -1803,7 +1814,7 @@ static int nfs_inode_finish_partial_attr_update=
(const struct nfs_fattr *fattr,
>>>               NFS_INO_INVALID_ATIME | NFS_INO_INVALID_CTIME |
>>>               NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
>>>               NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_OTHER |
>>> -             NFS_INO_INVALID_NLINK;
>>> +             NFS_INO_INVALID_NLINK | NFS_INO_INVALID_BTIME;
>>>       unsigned long cache_validity =3D NFS_I(inode)->cache_validity;
>>>       enum nfs4_change_attr_type ctype =3D NFS_SERVER(inode)->change_=
attr_type;
>>>
>>> @@ -2122,7 +2133,8 @@ static int nfs_update_inode(struct inode *inode=
, struct nfs_fattr *fattr)
>>>       nfsi->cache_validity &=3D ~(NFS_INO_INVALID_ATTR
>>>                       | NFS_INO_INVALID_ATIME
>>>                       | NFS_INO_REVAL_FORCED
>>> -                     | NFS_INO_INVALID_BLOCKS);
>>> +                     | NFS_INO_INVALID_BLOCKS
>>> +                     | NFS_INO_INVALID_BTIME);
>>>
>>>       /* Do atomic weak cache consistency updates */
>>>       nfs_wcc_update_inode(inode, fattr);
>>> @@ -2161,6 +2173,7 @@ static int nfs_update_inode(struct inode *inode=
, struct nfs_fattr *fattr)
>>>                                       | NFS_INO_INVALID_BLOCKS
>>>                                       | NFS_INO_INVALID_NLINK
>>>                                       | NFS_INO_INVALID_MODE
>>> +                                     | NFS_INO_INVALID_BTIME
>>>                                       | NFS_INO_INVALID_OTHER;
>>>                               if (S_ISDIR(inode->i_mode))
>>>                                       nfs_force_lookup_revalidate(ino=
de);
>>> @@ -2189,6 +2202,12 @@ static int nfs_update_inode(struct inode *inod=
e, struct nfs_fattr *fattr)
>>>               nfsi->cache_validity |=3D
>>>                       save_cache_validity & NFS_INO_INVALID_MTIME;
>>>
>>> +     if (fattr->valid & NFS_ATTR_FATTR_BTIME) {
>>> +             nfsi->btime =3D fattr->btime;
>>> +     } else if (fattr_supported & NFS_ATTR_FATTR_BTIME)
>>> +             nfsi->cache_validity |=3D
>>> +                     save_cache_validity & NFS_INO_INVALID_BTIME;
>>> +
>>>       if (fattr->valid & NFS_ATTR_FATTR_CTIME)
>>>               inode->i_ctime =3D fattr->ctime;
>>>       else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
>>> @@ -2332,6 +2351,7 @@ struct inode *nfs_alloc_inode(struct super_bloc=
k *sb)
>>>  #endif /* CONFIG_NFS_V4 */
>>>  #ifdef CONFIG_NFS_V4_2
>>>       nfsi->xattr_cache =3D NULL;
>>> +     memset(&nfsi->btime, 0, sizeof(nfsi->btime));
>>
>>
>> ^^ is this redundant if we're going to do it anyway in nfs_fhget for I=
_NEW?
>>
>> .. actually, I don't understand why were doing /any/ nfsi member
>> initialization here.. am I missing something?
>>
>> Otherwise, this gets
>>
>> Tested-by: Benjamin Coddington <bcodding@redhat.com>
>> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
>
> Reviewed-by: Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
>
> I am astonished that birth timestamp support in the Linux NFS client
> wasn't implemented... earlier.
>
> Just curious: What happens with this functionality if one filesystem
> exported by nfsd supports birth timestamps, and another filesystem
> does not support birth timestamps?

Without explicitly looking, I think the attribute would just not be liste=
d
in the supported attributes as queried by the client during mount, and th=
e
client would just behave as it does now.

Ben


